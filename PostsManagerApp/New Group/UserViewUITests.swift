//
//  UserViewUITests.swift
//  PostsManagerAppUITests
//
//  Created by Esteban Penagos Salazar on 21/07/23.
//

import XCTest
@testable import PostsManagerApp

final class UserViewUITests: XCTestCase {
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "UsersView", bundle: nil)
        let vController = storyboard.instantiateViewController(identifier: "UsersViewController") as! UsersViewController
        sut = vController
        sut.loadViewIfNeeded()
        
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_LoadView() throws {
        let tableView = try XCTUnwrap(sut.usersTable, "-")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
