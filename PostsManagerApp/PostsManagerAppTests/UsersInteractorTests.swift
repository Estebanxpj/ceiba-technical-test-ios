//
//  UsersInteractorTests.swift
//  PostsManagerAppTests
//
//  Created by Esteban Penagos Salazar on 21/07/23.
//

import XCTest
@testable import PostsManagerApp

final class UsersInteractorTests: XCTestCase {

    var sut: UsersInteractor!
    var presenterMock: PresenterUsersMock!
    var localDataManagerMock: LocalDataManagerUsersMock?

    override func setUpWithError() throws {
        sut = UsersInteractor()
        presenterMock = PresenterUsersMock()
        localDataManagerMock = LocalDataManagerUsersMock()

        sut?.presenter = presenterMock as? any InteractorToPresenterUsersProtocol
        sut?.localDataManager = localDataManagerMock
    }

    override func tearDownWithError() throws {
        sut = nil
        presenterMock = nil
        localDataManagerMock = nil
    }

    func tests_loadUsers() throws {
        sut?.loadUsers()
        XCTAssertTrue(presenterMock?.returnedUsers ?? false)
    }
}

class PresenterUsersMock: ViewToPresenterUsersProtocol {
    var view: PostsManagerApp.PresenterToViewUsersProtocol?
    
    var interactor: PostsManagerApp.PresenterToInteractorUsersProtocol?
    
    var router: PostsManagerApp.PresenterToRouterUsersProtocol?
    
    var originUserList: [PostsManagerApp.User] = []
    
    func viewDidLoad() {
    }
    
    func showUserPostsView(user: PostsManagerApp.User) {
    }
    
    func filterUsersList(filter: String) {
    }
    
    var presenter: InteractorToPresenterUsersProtocol?
    var returnedUsers: Bool = false

    func fetchUsers(users: [User]) {
        if users.count > 0 {
            self.returnedUsers = true
        } else {
            self.returnedUsers = false
        }
    }
}

class LocalDataManagerUsersMock: InteractorToLocalDataManagerUsersProtocol {
    func saveLocalUsers(users: [PostsManagerApp.User]) {
    }
    
    var localRequestHandler: LocalDataManagerToInteractorUsersProtocol?
    var listUsersResponse: [User] = []

    func getLocalUsers() {
        localRequestHandler?.callBakLocalUsers(with: listUsersResponse)
    }
}
