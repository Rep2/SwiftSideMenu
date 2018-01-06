import UIKit
import SwiftSideMenu

class ViewController: UIViewController, Identifiable {
    @IBOutlet private weak var stateSegmentedControl: UISegmentedControl!

    lazy var sideMenuPresenter = SideMenuPresenter(transitioningDelegate: self)

    @IBAction func stateSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        sideMenuPresenter.didChange(selectedSegmentIndex: sender.selectedSegmentIndex, containerViewController: self)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return sideMenuPresenter
            .screenEdge
            .flatMap { SideMenuAnimatedTransitioning(screenEdge: $0, direction: .present) }
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return sideMenuPresenter
            .screenEdge
            .flatMap { SideMenuAnimatedTransitioning(screenEdge: $0, direction: .dismiss) }
    }
}
