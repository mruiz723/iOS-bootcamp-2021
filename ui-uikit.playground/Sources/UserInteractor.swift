import UIKit

public class UserInteractor {
    
    let actionBlock: ((UIButton) -> Void)
    
    public init(_ actionBlock: @escaping ((UIButton) -> Void)) {
        self.actionBlock = actionBlock
    }
    
    @objc public func buttonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        actionBlock(sender)
    }
    
}
