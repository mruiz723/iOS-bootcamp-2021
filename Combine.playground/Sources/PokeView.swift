import UIKit
import Foundation

public class PokeView {

    public init() {}

    public var imageView = UIImageView()
    lazy
    public var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["1", "2", "3"])
        control.addTarget(self, action: #selector(valueDidChanged(_:)), for: .valueChanged)
        return control
    }()
    
    public var segmentAction: ((Int) -> Void)?
    public var pokemon: Pokemon? {
        didSet {
            if  let string = pokemon?.image,
                let url = URL(string: string),
                let data = try? Data(contentsOf: url) {
                imageView.image = UIImage(data: data)
            }
        }
    }
    @objc
    public func valueDidChanged(_ control: UISegmentedControl) {
        segmentAction?(control.selectedSegmentIndex)
    }

    public var view: UIView {
        let view = UIView()
        view.addSubview(imageView)
        view.addSubview(segmentedControl)

        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -20).isActive = true

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return view
    }

}
