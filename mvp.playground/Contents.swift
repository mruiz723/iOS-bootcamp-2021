import UIKit

//    MVP (Model — View — Presenter)
//    This design pattern overcomes these challenges of MVC
//    and provides an easy way to structure the project codes.
//
//    The reason why MVP is widely accepted is that it provides modularity, testability,
//    and a more clean and maintainable codebase. It is composed of the following three components:

//    Model
//    Layer for storing data.
//    It is responsible for handling the domain logic(real-world business rules)
//    and communication with the database and network layers.

//    View
//    UI(User Interface) layer.
//    It provides the visualization of the data and keep track
//    of the user’s action in order to notify the Presenter.

//    Presenter
//    Fetch the data from the model and applies the UI logic to decide what to display.
//    It manages the state of the View and takes actions according to
//    the user’s input notification from the View.

//    Model and View class doesn’t have knowledge about each other’s existence

let model       = Model(numberOfTodos: 8)

let view        = View()

let presenter   = Presenter(model: model, view: view)

PreviewWindow(presenter.view)
