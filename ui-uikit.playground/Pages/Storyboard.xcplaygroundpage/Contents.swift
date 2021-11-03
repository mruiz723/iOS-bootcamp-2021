import PlaygroundSupport
import UIKit

//    Storyboard
//    A storyboard is a visual representation of the user interface of an iOS application,
//    showing screens of content and the connections between those screens.
//    A storyboard is composed of a sequence of scenes, each of which represents
//    a view controller and its views; scenes are connected by segue objects,
//    which represent a transition between two view controllers.

//    In addition, a storyboard enables you to connect a view to its controller object,
//    and to manage the transfer of data between view controllers.

let windowSize = CGSize(width: 320, height: 480)

let storyboard = UIStoryboard(name: "Main", bundle: .main)

let dataSource = DataSource(rows: 5)

let rootViewController = storyboard.instantiateInitialViewController()

if
    let navigationController = rootViewController as? UINavigationController,
    let tableViewController = navigationController.viewControllers.first as? UITableViewController
{
    tableViewController.tableView.dataSource = dataSource
}

rootViewController?.view.frame.size = windowSize
PlaygroundPage.current.liveView = rootViewController?.view
