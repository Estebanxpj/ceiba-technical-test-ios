import XCTest
@testable import PostsManagerApp

class UsersPresenterTest: XCTestCase {

    var sut: UsersPresenter!
    var viewMock: ViewUsersMock!
    var interactorMock: InteractorUsersMock?
    var routerMock: RouterUsersMock?

    override func setUpWithError() throws {
        sut = SignInPresenter()
        viewMock = ViewUsersMock()
        interactorMock = InteractorUsersMock()
        routerMock = RouterUsersMock()
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

    func tests_filterUsersList() {
    }

    func tests_showUserPostsView() {
    }
}

class ViewUsersMock: PresenterToViewUsersProtocol {
    var spiner: Bool = false
    var presenter: ViewToPresenterUsersProtocol?

    func pushUsers(users: [User]) {
        listUsers = users
    }

    func startSpiner() {
        spiner = true
    }

    func stopSpiner() {
        spiner = false
    }
}

class InteractorUsersMock: PresenterToInteractorUsersProtocol {
    func loadUsers() {
    }
}

class RouterUsersMock: PresenterToRouterUsersProtocol {
    func presentPostsModule(form view: ViewToPresenterUsersProtocol, withData: User) {

    }
}