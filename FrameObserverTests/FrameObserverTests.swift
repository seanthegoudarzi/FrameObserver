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
        viewController.view.removeFrameObserver()
        XCTAssertEqual(viewController.view.hasFrameObserver(), false)
    }

    func testFrame() {
        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()
        viewController.viewDidAppear(true)
        let viewFrame = viewController.view.frame
        let startingWidth = viewFrame.width
        let startingHeight = viewFrame.height

        let dummyView = UIView()
        viewController.view.addSubview(dummyView)

        let expectation = self.expectation(description: "dummy view will notify with frame and bounds same as main view")

        dummyView.addFrameObserver { frame, bounds in
            XCTAssertEqual(startingWidth, frame.width)
            XCTAssertEqual(startingHeight, frame.height)
            expectation.fulfill()
        }


        dummyView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: dummyView, attribute: .leading, relatedBy: .equal, toItem: viewController.view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: dummyView, attribute: .trailing, relatedBy: .equal, toItem: viewController.view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: dummyView, attribute: .top, relatedBy: .equal, toItem: viewController.view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: dummyView, attribute: .bottom, relatedBy: .equal, toItem: viewController.view, attribute: .bottom, multiplier: 1, constant: 0),
        ])

        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()

        wait(for: [expectation], timeout: 3)

    }

}
