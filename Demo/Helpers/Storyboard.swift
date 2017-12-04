import UIKit

enum Storyboard: String {
    case main = "Main"

    /*
     Instantiates viewController from storyboard using its identifier.

     Warning - silent fail, test all usage
     */
    func viewController<T: UIViewController>() -> T where T: Identifiable {
        if let viewController = UIStoryboard(name: self.rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: T.identifier) as? T {
            return viewController
        } else {
            fatalError("ViewController registerd in storyboard \(String(describing: self)) using identifier " +
                " \(String(describing: T.identifier)) is not of type \(String(describing: T.self))")
        }
    }
}
