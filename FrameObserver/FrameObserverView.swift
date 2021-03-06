//
//  FrameObserverView.swift
//  FrameObserver
//
//  Created by Sean Goudarzi on 8/22/21.
//

import Foundation
import UIKit

internal class FrameObserverView: UIView {

    weak var delegate: FrameChangeDelegate?

    /// The reference to the main view the observer was added to
    weak var mainView: UIView?

    var onChange: ((_ frame: CGRect, _ bounds: CGRect) -> Void)?

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        if let mainView = mainView {
            delegate?.frameChangeDelegateDidChange(for: mainView, self.frame, self.bounds)
        }
        onChange?(self.frame, self.bounds)
    }

}
