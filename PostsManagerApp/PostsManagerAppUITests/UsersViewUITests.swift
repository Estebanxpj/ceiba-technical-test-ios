import XCTest
@testable import PostsManagerApp

class UserViewUITests: XCTestCase {
    var sut: UserView
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "UsersView", bundle: nil)
        let vController = storyboard.instantiateViewController(identifier: "UsersViewController") as! UsersViewController
        sut = vController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_LoadView() throws {
        let tableView = try XCTUnwrap(sut.usersTable, "-")
    }
}
