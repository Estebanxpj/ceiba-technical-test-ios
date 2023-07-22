import XCTest
@testable import PostsManagerApp

class UserViewUITests: XCTestCase {
    var sut: UserView
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "UserPostsView", bundle: nil)
        let vController = storyboard.instantiateViewController(identifier: "UserPostsViewController") as! UserPostsViewController
        sut = vController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_LoadView() throws {
        let tableView = try XCTUnwrap(sut.postsTable, "-")
    }
}
