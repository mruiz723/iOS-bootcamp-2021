//
//  ActivityIndicator.swift
//  iOSBootcampChallenge
//
//  Created by Jorge Benavides on 07/11/21.
//

import UIKit

class ActivityIndicator: UIActivityIndicatorView {

    func show(in view: UIView) {
        view.addSubview(self)
        self.center = view.center
        self.startAnimating()
    }

    func hide() {
        self.removeFromSuperview()
        self.stopAnimating()
    }

}

class LaunchActivityIndicator {

    private let view: UIView

    init(superview: UIView) {
        self.view = superview
    }

    private var activityIndicator = ActivityIndicator(style: .medium)

    private var isFirstLauch: Bool = true

    public var shouldShowLoader: Bool = false {
        didSet {
            if isFirstLauch, shouldShowLoader {
                activityIndicator.show(in: view)
            } else {
                isFirstLauch = false
                activityIndicator.hide()
            }
        }
    }

}
