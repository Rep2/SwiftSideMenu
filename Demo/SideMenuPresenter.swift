import UIKit
import SwiftSideMenu

class SideMenuPresenter {
    enum MenuState: Int {
        case letftMenuPresented
        case rightMenuPresented
        case bottomMenuPresented
        case topMenuPresented
        case leftBottomMenuPresented
        case rightTopMenuPresented
        case noMenuPresented

        func nextState(selectedIndex: Int) -> MenuState {
            if rawValue == selectedIndex {
                return .noMenuPresented
            } else if let newState = MenuState(rawValue: selectedIndex) {
                return newState
            } else {
                fatalError("HomePresenter.MenuState invalid rawValue: \(selectedIndex)")
            }
        }
    }

    private var menuState = MenuState.noMenuPresented
    private weak var transitioningDelegate: UIViewControllerTransitioningDelegate?

    init(transitioningDelegate: UIViewControllerTransitioningDelegate) {
        self.transitioningDelegate = transitioningDelegate
    }

    private  lazy var leftSideMenu: VerticalSideMenuViewController = {
        let viewController = Storyboard.main.viewController() as VerticalSideMenuViewController

        viewController.transitioningDelegate = transitioningDelegate

        return viewController
    }()

    private lazy var rightSideMenu: VerticalSideMenuViewController = {
        let viewController = Storyboard.main.viewController() as VerticalSideMenuViewController

        viewController.transitioningDelegate = transitioningDelegate

        return viewController
    }()

    private  lazy var leftBottomSideMenu: VerticalSideMenuViewController = {
        let viewController = Storyboard.main.viewController() as VerticalSideMenuViewController

        viewController.transitioningDelegate = transitioningDelegate

        return viewController
    }()

    private lazy var rightTopSideMenu: VerticalSideMenuViewController = {
        let viewController = Storyboard.main.viewController() as VerticalSideMenuViewController

        viewController.transitioningDelegate = transitioningDelegate

        return viewController
    }()

    private lazy var bottomSideMenu: HorizontalSideMenuViewController = {
        let viewController = Storyboard.main.viewController() as HorizontalSideMenuViewController

        viewController.transitioningDelegate = transitioningDelegate

        return viewController
    }()

    private lazy var topSideMenu: HorizontalSideMenuViewController = {
        let viewController = Storyboard.main.viewController() as HorizontalSideMenuViewController

        viewController.transitioningDelegate = transitioningDelegate

        return viewController
    }()

    func didChange(selectedSegmentIndex: Int, containerViewController: UIViewController) {
        let nextState = menuState.nextState(selectedIndex: selectedSegmentIndex)

        if nextState != menuState {
            viewController(for: menuState)?.dismiss(animated: true, completion: nil)
        }

        menuState = nextState

        viewController(for: nextState).flatMap { containerViewController.present($0, animated: true, completion: nil) }
    }

    var screenEdge: SideMenuScreenEdge? {
        switch menuState {
        case .letftMenuPresented:
            return .left
        case .rightMenuPresented:
            return .right
        case .bottomMenuPresented:
            return .bottom
        case .topMenuPresented:
            return .top
        case .leftBottomMenuPresented:
            return .leftBottom
        case .rightTopMenuPresented:
            return .rightTop
        default:
            return nil
        }
    }

    private func viewController(for menuState: MenuState) -> UIViewController? {
        switch menuState {
        case .letftMenuPresented:
            return leftSideMenu
        case .rightMenuPresented:
            return rightSideMenu
        case .bottomMenuPresented:
            return bottomSideMenu
        case .topMenuPresented:
            return topSideMenu
        case .leftBottomMenuPresented:
            return leftBottomSideMenu
        case .rightTopMenuPresented:
            return rightTopSideMenu
        default:
            return nil
        }
    }
}
