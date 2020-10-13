import UIKit

public class Router {
    
    // MARK: - Injected Properties.
    
    private var root: Root
    private let window: UIWindow
    
    // MARK: - Properties.
    
    private var vc: UIViewController {
        return topViewController(for: root.vc)
    }
    
    private var nc: UINavigationController? {
        return vc.navigationController
    }
    
    // MARK: - Initialization.
    
    public init(root: Root, window: UIWindow) {
        self.root = root
        self.window = window
        
        window.rootViewController = root.vc
        window.makeKeyAndVisible()
    }
    
    // MARK: - Public Methods.
    
    public func show(_ vc: UIViewController, using transition: Transition) {
        var transition: Transition {
            if UITraitCollection.current.userInterfaceIdiom == .phone && (transition == .secondColumn || transition == .thirdColumn) {
                return .push
            }
            
            return transition
        }
        
        switch transition {
        case .modal:
            self.vc.present(vc, animated: true, completion: nil)
        case .push:
            self.nc?.pushViewController(vc, animated: true)
        case .secondColumn:
            guard case .splitViewController (let svc) = root else {
                fatalError()
            }
            
            svc.viewControllers[1] = vc
        case .thirdColumn:
            guard case .splitViewController (let svc) = root else {
                fatalError()
            }
            
            svc.viewControllers[2] = vc
        }
    }
    
    public func replace(with root: Root) {
        self.root = root
        window.rootViewController = root.vc
    }
    
    // MARK: - Private Methods.
    
    private func topViewController(for vc: UIViewController) -> UIViewController {
        if let svc = vc as? UISplitViewController {
            let count = svc.viewControllers.count
            return topViewController(for: svc.viewControllers[count - 1])
        }
        
        if let tbc = vc as? UITabBarController {
            return topViewController(for: tbc.selectedViewController!)
        }
        
        if let nc = vc as? UINavigationController {
            let count = nc.viewControllers.count
            return topViewController(for: nc.viewControllers[count - 1])
        }
        
        if let presented = vc.presentedViewController {
            return topViewController(for: presented)
        }
        
        return vc
    }
    
}
