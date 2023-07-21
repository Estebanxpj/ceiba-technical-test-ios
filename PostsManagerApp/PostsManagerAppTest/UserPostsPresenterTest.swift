import XCTest
@testable import PostsManagerApp

class UserPostsPresenterTest: XCTestCase {

    var sut: UsersPresenter!
    var viewMock: ViewUserPostsMock!
    var interactorMock: InteractorUserPostsMock?
    var routerMock: RouterUserPostsMock?

    override func setUpWithError() throws {
        sut = SignInPresenter()
        viewMock = ViewUserPostsMock()
        interactorMock = InteractorUserPostsMock()
        routerMock = RouterUserPostsMock()
        sut?.view = viewMock
        sut?.interactor = interactorMock
        sut?.router = routerMock
    }

    override func tearDownWithError() throws {
        sutView = nil
        sut = nil
    }

    func tests_viewDidLoad() throws {
        mockInteractor?.noReturn = true
        sut?.viewDidLoad(username: "")
        XCTAssertTrue(mockView?.loading ?? false)
    }
}

class ViewUserPostsMock: PresenterToViewUserPostsProtocol {
    var spiner: Bool = false
    var presenter: ViewToPresenterUsersProtocol?

    func pushPosts(users: [User]) {
        listUsers = users
    }

    func startSpiner() {
        spiner = true
    }

    func stopSpiner() {
        spiner = false
    }
}

class InteractorUserPostsMock: PresenterToInteractorUserPostsProtocol {
    func loadUserPosts() {
    }
}
