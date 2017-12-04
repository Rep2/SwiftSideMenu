import UIKit

public class SideMenuAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    let screenEdge: SideMenuScreenEdge
    let direction: TransitionDirection
    let transitionDuration: Double

    public init(screenEdge: SideMenuScreenEdge, direction: TransitionDirection, transitionDuration: Double = 0.3) {
        self.screenEdge = screenEdge
        self.direction = direction
        self.transitionDuration = transitionDuration
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to) else {
                return
        }

        let homeView = direction == .present ? fromViewController : toViewController
        let menuView = direction == .present ? toViewController : fromViewController

        screenEdge.addSubviews(fromView: homeView.view, toView: menuView.view, containerView: transitionContext.containerView)
        screenEdge.setPositionBeforeAnimation(fromView: homeView.view, toView: menuView.view, direction: direction)

        UIView.animate(
            withDuration: transitionDuration,
            animations: {
                self.screenEdge.setPositionAfterAnimation(fromView: homeView.view, toView: menuView.view, direction: self.direction)
        },
            completion: { _ in
                // System bug http://openradar.appspot.com/radar?id=5320103646199808
                UIApplication.shared.keyWindow?.addSubview(transitionContext.transitionWasCancelled ? fromViewController.view : toViewController.view)

                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
