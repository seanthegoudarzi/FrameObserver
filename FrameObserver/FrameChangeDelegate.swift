//
//  FrameChangeDelegate.swift
//  FrameObserver
//
//  Created by Sean Goudarzi on 8/22/21.
//

import Foundation
import UIKit

public protocol FrameChangeDelegate: AnyObject {

    func frameChangeDelegateDidChange(for view: UIView, _ frame: CGRect, _ bounds: CGRect)

}
