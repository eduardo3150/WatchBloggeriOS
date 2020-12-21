import Foundation
import UIKit

protocol SegueHandlerProtocol {
    func performSegue(withIdentifier identifier: String, sender: Any?)
    func performSegue(withIdentifier identifier: String, viewController: UIViewController, sender: Any?)
}

class SegueHandler: SegueHandlerProtocol {
    func performSegue(withIdentifier identifier: String, sender: Any?) {
        if let viewController = sender as? UIViewController {
            viewController.performSegue(withIdentifier: identifier, sender: sender)
        }
    }

    func performSegue(withIdentifier identifier: String, viewController: UIViewController, sender: Any?) {
        viewController.performSegue(withIdentifier: identifier, sender: sender)
    }
}
