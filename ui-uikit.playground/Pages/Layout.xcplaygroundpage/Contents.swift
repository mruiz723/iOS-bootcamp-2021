//: [Previous](@previous)
//: [Next](@next)

import PlaygroundSupport
import UIKit

//    UIKit
//    Construct and manage a graphical, event-driven user interface for your iOS or tvOS app.
//
//    The UIKit framework provides the required infrastructure for your iOS or tvOS apps.
//    It provides the window and view architecture for implementing your interface,
//    the event handling infrastructure for delivering Multi-Touch and other types of input to your app,
//    and the main run loop needed to manage interactions among the user, the system, and your app.
//    Other features offered by the framework include animation support, document support, drawing and printing support,
//    information about the current device, text management and display, search support, accessibility support, app extension support, and resource management.
//
//    Note
//    Use UIKit classes only from your app’s main thread or main dispatch queue, unless otherwise indicated. This restriction particularly applies to classes derived from UIResponder or that involve manipulating your app’s user interface in any way.


let window = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 320, height: 480)))

let square = UIView()

square.frame.origin.y = 100
square.frame.size.width = 100
square.frame.size.height = 100
square.backgroundColor = UIColor.red

window.addSubview(square)

let title = UILabel()
title.text = "UIKit"
title.textColor = UIColor.black
title.translatesAutoresizingMaskIntoConstraints = false

let titleConstraints = [
    NSLayoutConstraint(item: title, attribute: .centerX, relatedBy: .equal, toItem: window, attribute: .centerX, multiplier: 1, constant: 0),
    NSLayoutConstraint(item: title, attribute: .top, relatedBy: .equal, toItem: window, attribute: .top, multiplier: 1, constant: 15)
]

window.addSubview(title)
window.addConstraints(titleConstraints)


let button = UIButton()
button.translatesAutoresizingMaskIntoConstraints = false
button.setTitle("Press me", for: .normal)
button.setTitle("Again!", for: .selected)
button.setTitleColor(.black, for: .normal)
button.backgroundColor = .green

window.addSubview(button)
button.translatesAutoresizingMaskIntoConstraints = false

class UserInteractions {
    @objc public func buttonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        print("hello")
    }
}


let userInteractions = UserInteractions()
button.addTarget(userInteractions, action: #selector(UserInteractions.buttonPressed(_:)), for: .touchUpInside)

button.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: 0).isActive = true
button.leftAnchor.constraint(equalTo: window.leftAnchor, constant: 0).isActive = true
button.rightAnchor.constraint(equalTo: window.rightAnchor, constant: 0).isActive = true
button.heightAnchor.constraint(equalToConstant: 60).isActive = true


PlaygroundPage.current.liveView = window
