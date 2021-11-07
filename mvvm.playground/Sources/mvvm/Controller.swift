import UIKit

public class Controller: UIViewController {

    public convenience init(view: View) {
        self.init()
        self.view = view.body
    }

}
