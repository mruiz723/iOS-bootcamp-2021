//
//  DetailView.swift
//  iOSBootcampChallenge
//
//  Created by Jorge Benavides on 07/11/21.
//

import UIKit

@objc protocol DetailViewDelegate: AnyObject {
    func closeButtonPressed()
}

struct DetailView {

    let body: UIView = UIView()

    let viewModel: DetailViewModel

    let container: UIView

    private weak var delegate: DetailViewDelegate?

    init(viewModel: DetailViewModel, container: UIView, delegate: DetailViewDelegate? = nil) {
        self.viewModel = viewModel
        self.container = container
        self.delegate = delegate
        self.viewLoad()
    }

    private let margin: CGFloat = 20

    private func viewLoad() {
        container.addSubview(body)
        body.translatesAutoresizingMaskIntoConstraints = false
        body.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        body.rightAnchor.constraint(equalTo: container.rightAnchor).isActive = true
        body.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        body.leftAnchor.constraint(equalTo: container.leftAnchor).isActive = true

        container.layoutIfNeeded()

        body.layer.insertSublayer(gradient, at: 0)

        let closeButton = self.closeButton
        body.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: body.topAnchor, constant: margin).isActive = true
        closeButton.leftAnchor.constraint(equalTo: body.leftAnchor, constant: margin).isActive = true

        let nameLabel = self.nameLabel
        body.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: margin).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: closeButton.leftAnchor).isActive = true
        nameLabel.widthAnchor.constraint(lessThanOrEqualTo: body.widthAnchor, multiplier: 0.7).isActive = true

        let idLabel = idLabel
        body.addSubview(idLabel)
        idLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        idLabel.rightAnchor.constraint(equalTo: body.rightAnchor, constant: -margin).isActive = true

        let typesStackView = self.typesStackView
        body.addSubview(typesStackView)
        typesStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: margin).isActive = true
        typesStackView.leftAnchor.constraint(equalTo: closeButton.leftAnchor).isActive = true
        typesStackView.widthAnchor.constraint(lessThanOrEqualTo: body.widthAnchor, multiplier: 0.7).isActive = true

        let cardView = self.cardView
        body.addSubview(cardView)
        cardView.topAnchor.constraint(equalTo: body.topAnchor, constant: body.frame.size.height/2.5).isActive = true
        cardView.leftAnchor.constraint(equalTo: body.leftAnchor).isActive = true
        cardView.rightAnchor.constraint(equalTo: body.rightAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: body.bottomAnchor).isActive = true

        let imageView = imageView
        body.addSubview(imageView)
        imageView.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: margin * 2).isActive = true
        imageView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

}

extension DetailView {

    private var gradient: CAGradientLayer {
        let gradient = PokemonColor.typeLinearGradient(name: viewModel.primaryType)
        gradient.frame = body.bounds
        return gradient
    }

    private var closeButton: UIButton {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        if let delegate = delegate {
            button.addTarget(delegate, action: #selector(delegate.closeButtonPressed), for: .touchUpInside)
        }
        return button
    }

    private var nameLabel: UILabel {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.pokemonName
        return label
    }

    public var idLabel: UILabel {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.pokemonID
        return label
    }

    private var typesStackView: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = margin/2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        for type in viewModel.pokemonTypes {
            let padding = 20.0
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 17)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = type.capitalized
            label.backgroundColor = .white.withAlphaComponent(0.30)
            label.layer.cornerRadius = 7.0
            label.layer.masksToBounds = true
            let paddedWidth = label.intrinsicContentSize.width + padding
            label.widthAnchor.constraint(equalToConstant: paddedWidth).isActive = true
            stackView.addArrangedSubview(label)
        }
        return stackView
    }

    private var imageView: UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        if let url = viewModel.pokemonImageURL {
            view.kf.setImage(with: url)
        }
        return view
    }

    private var cardView: CardView {
        let title = "About"
        let cardView = CardView(card: Card(title: title, items: items))
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }

    private var items: [Item] {
        var items = [Item]()

        // abilities
        let abilities = viewModel.pokemonAbilities

        if abilities.count > 0 {
            let title = "Abilities"
            let description = abilities.joined(separator: "\n")
            let item = Item(title: title, description: description)
            items.append(item)
        }

        // weight
        let weight = "Weight"
        items.append(Item(title: weight, description: viewModel.pokemonWeight))

        // baseExperience
        let baseExperience = "Base Experience"
        items.append(Item(title: baseExperience, description: viewModel.pokemonExperience))

        return items
    }

}
