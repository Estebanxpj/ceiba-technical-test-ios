//
//  UsersPresenterTests.swift
//  PostsManagerAppTests
//
//  Created by Esteban Penagos Salazar on 21/07/23.
//

import XCTest
@testable import PostsManagerApp

final class UsersPresenterTests: XCTestCase {

    var sut: UsersPresenter!
    var viewMock: ViewUsersMock!
    var interactorMock: InteractorUsersMock?
    var routerMock: RouterUsersMock?

    override func setUpWithError() throws {
        sut = UsersPresenter()
        viewMock = ViewUsersMock()
        interactorMock = InteractorUsersMock()
        routerMock = RouterUsersMock()
        sut?.view = viewMock
        sut?.interactor = interactorMock
        sut?.router = routerMock
    }

    override func tearDownWithError() throws {
        viewMock = nil
        sut = nil
        routerMock = nil
        interactorMock = nil
    }

    func tests_viewDidLoad() throws {
        interactorMock?.listUsersResponse = []
        sut?.viewDidLoad()
        XCTAssertTrue(viewMock?.isAlertShow ?? true)
        XCTAssertTrue(viewMock?.isSpinerShow ?? false)
    }
    
    func tests_filterUsersList() {
        interactorMock?.listUsersResponse = []
        sut?.filterUsersList(filter: "")
        XCTAssertTrue(viewMock?.isAlertShow ?? true)
        XCTAssertTrue(viewMock?.isSpinerShow ?? false)
    }

    func tests_showUserPostsView() {
        guard var user = User(JSONString: "") else { return }
        sut?.showUserPostsView(user: user)
        XCTAssertTrue(routerMock?.redirectNewView ?? true)
        XCTAssertTrue(viewMock?.isSpinerShow ?? false)
    }
}

class ViewUsersMock: PresenterToViewUsersProtocol {
    var presenter: ViewToPresenterUsersProtocol?
    var isSpinerShow: Bool = false
    var originUserList: [User] = []
    var isAlertShow: Bool = false

    func pushUsers(users: [User]) {
        originUserList = users
    }

    func startSpiner() {
        isSpinerShow = true
    }

    func stopSpiner() {
        isSpinerShow = false
    }

    func showErrorMessage(message: String) {
        isAlertShow = true
    }
}

class InteractorUsersMock: PresenterToInteractorUsersProtocol {
    var localDataManager: PostsManagerApp.InteractorToLocalDataManagerUsersProtocol?
    
    var remoteDataManager: PostsManagerApp.InteractorToRemoteDataManagerUsersProtocol?
    
    var presenter: InteractorToPresenterUsersProtocol?
    var listUsersResponse: [User] = []

    func loadUsers() {
        presenter?.fetchUsers(users: listUsersResponse)
    }
}

class RouterUsersMock: PresenterToRouterUsersProtocol {
    static func createUsersModule() -> UIViewController {
        return UIViewController()
    }
    
    func presentPostsModule(form view: PostsManagerApp.PresenterToViewUsersProtocol, withData: PostsManagerApp.User) {
    }
    
    var redirectNewView: Bool = false
    func presentPostsModule(form view: ViewToPresenterUsersProtocol, withData: User) {
        self.redirectNewView = true
    }
}
