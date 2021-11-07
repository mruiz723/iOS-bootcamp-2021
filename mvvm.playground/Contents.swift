import PlaygroundSupport
import UIKit

//    MVVM
//    A "code organizing" architectural design paradigm.
//    Facilitates the separation of concerns for the View object
//    thus making development of gui and business logic independently

//    Model
//        - UI Independent
//        - Data + Logic

//    View
//        - Reflects the model
//        - Stateless
//        - Declared

//    ViewModel
//        - Binds View to Model
//        - Interpreter
//        - Processes Intent


let model       = Model(numberOfTodos: 8)

let viewModel   = ViewModel(model: model)

let view        = View(viewModel: viewModel)

let controller  = Controller(view: view)

PreviewWindow(controller.view)
