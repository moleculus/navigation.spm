import UIKit

public enum Root {
    case splitViewController (UISplitViewController)
    case tabBarController (UITabBarController)
    case navigationController (UINavigationController)
    
    var vc: UIViewController {
        switch self {
        case .splitViewController (let svc):
            return svc
        case .tabBarController (let tbc):
            return tbc
        case .navigationController (let nc):
            return nc
        }
    }
}
