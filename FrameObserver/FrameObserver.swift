//
//  FrameObserver.swift
//  FrameObserver
//
//  Created by Sean Goudarzi on 8/22/21.
//

import Foundation
import UIKit

extension UIView {

    public func addFrameObserver(with delegate: FrameChangeDelegate) {
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

        let leading = NSLayoutConstraint(item: frameObserverView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: frameObserverView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: frameObserverView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: frameObserverView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)

        [leading, top, trailing, bottom].forEach { constraint in
            constraint.priority = UILayoutPriority(1)
        }

        NSLayoutConstraint.activate([
            leading,
            top,
            trailing,
            bottom,
        ])

        frameObserverView.tag = 31415926
        frameObserverView.accessibilityIdentifier = "FrameObserverView"
        return frameObserverView
    }

    public func addFrameObserver(with closure: @escaping (_ frame: CGRect, _ bounds: CGRect) -> Void) {
        let frameObserverView = addFrameObserverView()
        frameObserverView.onChange = closure
    }

    public func removeFrameObserver() {
        currentFrameObserverView()?.removeFromSuperview()
    }

    public func hasFrameObserver() -> Bool {
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
