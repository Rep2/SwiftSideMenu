import UIKit

public enum SideMenuScreenEdge {
    case left
    case right
    case top
    case bottom
    case leftBottom
    case leftTop
    case rightBottom
    case rightTop
    case bottomLeft
    case bottomRight

    public func addSubviews(fromView: UIView, toView: UIView, containerView: UIView) {
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
    }

    public func setPositionBeforeAnimation(fromView: UIView, toView: UIView, direction: TransitionDirection) {
        toView.frame = direction == .present ?
            positionDismissed(fromView: fromView, toView: toView) :
            positionPresented(fromView: fromView, toView: toView)
    }

    public func setPositionAfterAnimation(fromView: UIView, toView: UIView, direction: TransitionDirection) {
        toView.frame = direction == .present ?
            positionPresented(fromView: fromView, toView: toView) :
            positionDismissed(fromView: fromView, toView: toView)
    }

    private func positionDismissed(fromView: UIView, toView: UIView) -> CGRect {
        return CGRect(
            x: xPositionDismissed(fromView: fromView, toView: toView),
            y: yPositionDismissed(fromView: fromView, toView: toView),
            width: toView.frame.width,
            height: toView.frame.height
        )
    }

    private func positionPresented(fromView: UIView, toView: UIView) -> CGRect {
        return CGRect(
            x: xPositionPresented(fromView: fromView, toView: toView),
            y: yPositionPresented(fromView: fromView, toView: toView),
            width: toView.frame.width,
            height: toView.frame.height
        )
    }

    private func xPositionDismissed(fromView: UIView, toView: UIView) -> CGFloat {
        switch self {
        case .left, .leftBottom, .leftTop:
            return fromView.frame.minX - toView.frame.width
        case .right, .rightBottom, .rightTop:
            return fromView.frame.maxX
        case .top, .bottom:
            return fromView.frame.minX + (fromView.frame.width - toView.frame.width) / 2
        case .bottomLeft:
            return 0
        case .bottomRight:
            return fromView.frame.maxX - toView.frame.width
        }
    }

    private func yPositionDismissed(fromView: UIView, toView: UIView) -> CGFloat {
        switch self {
        case .left, .right:
            return fromView.frame.minY + (fromView.frame.height - toView.frame.height) / 2
        case .top:
            return fromView.frame.minY - toView.frame.height
        case .bottom, .bottomLeft, .bottomRight:
            return fromView.frame.maxY
        case .leftBottom, .rightBottom:
            return fromView.frame.minY + (fromView.frame.height - toView.frame.height)
        case .leftTop, .rightTop:
            return fromView.frame.minY
        }
    }

    private func xPositionPresented(fromView: UIView, toView: UIView) -> CGFloat {
        switch self {
        case .left, .leftBottom, .leftTop:
            return fromView.frame.minX
        case .right, .rightBottom, .rightTop:
            return fromView.frame.maxX - toView.frame.width
        case .top, .bottom:
            return fromView.frame.minX + (fromView.frame.width - toView.frame.width) / 2
        case .bottomLeft:
            return 0
        case .bottomRight:
            return fromView.frame.maxX - toView.frame.width
        }
    }

    private func yPositionPresented(fromView: UIView, toView: UIView) -> CGFloat {
        switch self {
        case .left, .right:
            return fromView.frame.minY + (fromView.frame.height - toView.frame.height) / 2
        case .top:
            return fromView.frame.minY
        case .bottom, .bottomLeft, .bottomRight:
            return fromView.frame.maxY - toView.frame.height
        case .leftBottom, .rightBottom:
            return fromView.frame.minY + (fromView.frame.height - toView.frame.height)
        case .leftTop, .rightTop:
            return fromView.frame.minY
        }
    }
}
