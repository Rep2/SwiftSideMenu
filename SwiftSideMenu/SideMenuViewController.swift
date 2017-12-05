import UIKit

open class SideMenuViewController: UIViewController {
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupView()
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        setupView()
    }

    func setupView() {
        modalPresentationStyle = .custom
    }
}
