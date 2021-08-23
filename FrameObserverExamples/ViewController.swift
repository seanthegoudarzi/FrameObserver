//
//  ViewController.swift
//  FrameObserverExamples
//
//  Created by Sean Goudarzi on 8/22/21.
//

import UIKit
import FrameObserver

class ViewController: UIViewController {

    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()

        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical

        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(redView)

        view.addFrameObserver { [weak self] frame, bounds in
            guard
                let self = self else {
                return
            }

            // making the red view be always the half of the width and height of main view
            self.redView.frame = CGRect(x: 0, y: 0, width: frame.width / 2, height: frame.height / 2)

        }

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // attaching the stack view to the very bottom
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: 0),
        ])

        let frameObserverLabel = UILabel()
        stackView.addArrangedSubview(frameObserverLabel)

        frameObserverLabel.text = "Hello!"
        frameObserverLabel.textAlignment = .center

        let gradientLayer = CAGradientLayer()
        stackView.layer.insertSublayer(gradientLayer, at: 0)

        gradientLayer.colors = [
            UIColor.red.cgColor,
            UIColor.green.cgColor,
        ]

        gradientLayer.locations = [
            0.0,
            1.0,
        ]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        stackView.addFrameObserver { frame, bounds in
            print("StackView frame", frame, "Bounds", bounds)
            gradientLayer.frame = bounds // the gradient layer's poisition will always be kept updated 
        }

    }


}

