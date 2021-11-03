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

let windowSize = CGSize(width: 320, height: 480)
let window = UIView(frame: CGRect(origin: .zero, size: windowSize))


// CGRect

let square = UIImageView()

square.image = UIImage(named: "swift")
square.contentMode = .scaleAspectFill

square.frame.origin.y = 100
square.frame.size.width = 200
square.frame.size.height = 100
square.backgroundColor = UIColor.red

square.layer.cornerRadius = 10
square.alpha = 0.8
square.center = window.center
square.clipsToBounds = true

window.addSubview(square)


// NSLayoutConstraints

let title = UILabel()
title.text = "UIKit = UILabel with a super long title"
title.font = UIFont.boldSystemFont(ofSize: 22)
title.textColor = UIColor.black
title.translatesAutoresizingMaskIntoConstraints = false

let titleConstraints = [
    NSLayoutConstraint(item: title,
                       attribute: .centerX,
                       relatedBy: .equal,
                       toItem: window,
                       attribute: .centerX,
                       multiplier: 1,
                       constant: 0),
    NSLayoutConstraint(item: title,
                       attribute: .top,
                       relatedBy: .equal,
                       toItem: window,
                       attribute: .top,
                       multiplier: 1,
                       constant: 15),
    NSLayoutConstraint(item: title,
                       attribute: .width,
                       relatedBy: .equal,
                       toItem: window,
                       attribute: .width,
                       multiplier: 0.8,
                       constant: 0)
]

window.addSubview(title)
window.addConstraints(titleConstraints)


// NSLayoutAnchor

let button = UIButton()
button.setTitle("Press me", for: .normal)
button.setTitle("Again!", for: .selected)
button.setTitleColor(.white, for: .normal)
button.backgroundColor = .systemBlue

window.addSubview(button)
button.translatesAutoresizingMaskIntoConstraints = false

let userInteractor = UserInteractor({ sender in
    UIView.animate(withDuration: 0.3, animations: {
        button.backgroundColor = sender.isSelected ? .gray : .systemBlue
    })
    UIView.animate(withDuration: 0.3,
                   delay: 0.1,
                   usingSpringWithDamping: 0.4,
                   initialSpringVelocity: 0.4,
                   options: .curveLinear,
                   animations: {
        square.center.y = window.center.y + (sender.isSelected ? -50:50)
    }, completion: { _ in })
})

button.addTarget(userInteractor,
                 action: #selector(UserInteractor.buttonPressed(_:)),
                 for: .touchUpInside)

button
    .bottomAnchor
    .constraint(equalTo: window.bottomAnchor, constant: 0)
    .isActive = true
button
    .leftAnchor
    .constraint(equalTo: window.leftAnchor, constant: 0)
    .isActive = true
button
    .rightAnchor
    .constraint(equalTo: window.rightAnchor, constant: 0)
    .isActive = true
button
    .heightAnchor
    .constraint(equalToConstant: 60)
    .isActive = true


PlaygroundPage.current.liveView = window
