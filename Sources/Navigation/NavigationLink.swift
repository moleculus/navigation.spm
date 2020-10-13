import UIKit

public struct NavigationLink {
    
    // MARK: - Properties.
    
    public let vc: UIViewController
    public let title: String
    public let icon: UIImage?
    
    // MARK: - Initialization.
    
    public init(vc: UIViewController, title: String, icon: UIImage? = nil) {
        self.vc = vc
        self.title = title
        self.icon = icon
    }
    
}
