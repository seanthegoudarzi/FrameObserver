//
//  FrameObserver.swift
//  FrameObserver
//
//  Created by Sean Goudarzi on 8/22/21.
//

import Foundation
import UIKit

extension UIView {

    internal func addFrameObserver(with delegate: FrameChangeDelegate) {
        let frameObserverView = addFrameObserverView()
        frameObserverView.delegate = delegate
    }

    private func addFrameObserverView() -> FrameObserverView {

        if let currentFrameObserverView = self.currentFrameObserverView() {
            return currentFrameObserverView
        }

        let frameObserverView = FrameObserverView()

        frameObserverView.mainView = self

        frameObserverView.isUserInteractionEnabled = false
        self.insertSubview(frameObserverView, at: 0)

        frameObserverView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: frameObserverView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: frameObserverView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: frameObserverView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: frameObserverView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
        ])

        frameObserverView.tag = 31415926
        frameObserverView.accessibilityIdentifier = "FrameObserverView"
        return frameObserverView
    }

    internal func addFrameObserver(with closure: @escaping (_ frame: CGRect, _ bounds: CGRect) -> Void) {
        let frameObserverView = addFrameObserverView()
        frameObserverView.onChange = closure
    }

    internal func removeObserver() {
        currentFrameObserverView()?.removeFromSuperview()
    }

    internal func hasFrameObserver() -> Bool {
        return currentFrameObserverView() != nil
    }

    private func currentFrameObserverView() -> FrameObserverView? {
        let subviews = self.subviews
        for subview in subviews {
            if subview.tag == 31415926, let frameObserverView = subview as? FrameObserverView {
                return frameObserverView
            }
        }
        return nil
    }

}
