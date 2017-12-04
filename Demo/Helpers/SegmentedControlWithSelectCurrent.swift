import UIKit

class SegmentedControlWithSelectCurrent: UISegmentedControl {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentSelectedSegmentIndex = selectedSegmentIndex

        super.touchesEnded(touches, with: event)

        if currentSelectedSegmentIndex == selectedSegmentIndex {
            sendActions(for: .valueChanged)
        }
    }
}
