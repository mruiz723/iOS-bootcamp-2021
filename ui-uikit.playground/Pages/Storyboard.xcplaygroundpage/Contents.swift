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


let storyboard = UIStoryboard(name: "Main", bundle: .main)

let dataSource = DataSource(rows: 5)
let rootViewController = storyboard.instantiateInitialViewController()

if
    let navigationController = rootViewController as? UINavigationController,
    let tableViewController = navigationController.viewControllers.first as? UITableViewController
{
    tableViewController.tableView.dataSource = dataSource
}

rootViewController?.view.frame.size = CGSize(width: 320, height: 480)
PlaygroundPage.current.liveView = rootViewController?.view
