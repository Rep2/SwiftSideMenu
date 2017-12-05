# SwiftSideMenu

Side menu implemented using custom VC transition, written in Swift.

## Usage

Implement `UIViewControllerTransitioningDelegate` and return `SideMenuAnimatedTransitioning` with wanted `SideMenuScreenEdge` and `TransitionDirection`.

```Swift
extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuAnimatedTransitioning(screenEdge: .left, direction: .present)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuAnimatedTransitioning(screenEdge: .left, direction: .dismiss)
    }
}
```

Set `modalPresentationStyle = .custom` `transitioningDelegate` on presented `ViewController`.

```Swift
viewController.transitioningDelegate = transitioningDelegate // Your UIViewControllerTransitioningDelegate implementation
viewController.modalPresentationStyle = .custom
```

Present/dismiss `ViewController`.

```Swift
containerViewController.present(sideMenuViewController, animated: true, completion: nil)

sideMenuViewController.dismiss(animated: true, completion: nil)
```

For more info examine the demo project.

## Demo

![example](https://github.com/Rep2/SwiftSideMenu/blob/master/example.gif)

## SideMenuScreenEdge

```Swift
enum SideMenuScreenEdge {
    case left
    case right
    case top
    case bottom
    case leftBottom
    case leftTop
    case rightBottom
    case rightTop
}
```
