//
//  FrameObserverTests.swift
//  FrameObserverTests
//
//  Created by Sean Goudarzi on 8/22/21.
//

import XCTest
import UIKit
@testable import FrameObserver

class FrameObserverTests: XCTestCase {

    var viewController: UIViewController!

    override func setUpWithError() throws {
        viewController = UIViewController()
    }

    override func tearDownWithError() throws {
        viewController = nil
    }

    func testHasObserver() {
        XCTAssertEqual(viewController.view.hasFrameObserver(), false)
        viewController.view.addFrameObserver { _, _ in
        }
        XCTAssertEqual(viewController.view.hasFrameObserver(), true)
        viewController.view.removeObserver()
        XCTAssertEqual(viewController.view.hasFrameObserver(), false)
    }

}
