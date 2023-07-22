//
//  UserPostViewUITests.swift
//  PostsManagerAppUITests
//
//  Created by Esteban Penagos Salazar on 21/07/23.
//

import XCTest

final class UserPostViewUITests: XCTestCase {
    
    var sut: UserView
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "UserPostsView", bundle: nil)
        let vController = storyboard.instantiateViewController(identifier: "UserPostsViewController") as! UserPostsViewController
        sut = vController
        sut.loadViewIfNeeded()
        
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_LoadView() throws {
        let tableView = try XCTUnwrap(sut.postsTable, "-")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
