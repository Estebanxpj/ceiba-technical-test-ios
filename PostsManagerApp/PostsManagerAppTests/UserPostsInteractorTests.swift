//
//  UserPostsInteractorTests.swift
//  PostsManagerAppTests
//
//  Created by Esteban Penagos Salazar on 21/07/23.
//

import XCTest
@testable import PostsManagerApp
final class UserPostsInteractorTests: XCTestCase {
    
    var sut: UserPostsInteractor!
    var presenterMock: PresenterUserPostsMock!
    var localDataManagerMock: LocalDataManagerUserPostsMock?
    var remoteDataManagerMock: RemoteDataManagerUserPostsMock?

    override func setUpWithError() throws {
        sut = UserPostsInteractor()
        presenterMock = PresenterUserPostsMock()
        localDataManagerMock = LocalDataManagerUserPostsMock()
        remoteDataManagerMock = RemoteDataManagerUserPostsMock()

        sut?.presenter = presenterMock as? any InteractorToPresenterUserPostsProtocol
        sut?.localDataManager = localDataManagerMock
        sut?.remoteDataManager = remoteDataManagerMock as? any InteractorToRemoteDataManagerUserPostsProtocol
    }

    override func tearDownWithError() throws {
        sut = nil
        presenterMock = nil
        localDataManagerMock = nil
        remoteDataManagerMock = nil
    }

    func tests_loadUserPosts() throws {
        var userId: Int = 1
        sut?.loadUserPosts(userId: userId)
        XCTAssertTrue(presenterMock?.returnedPosts ?? false)
    }
}

class PresenterUserPostsMock: ViewToPresenterUserPostsProtocol {
    var view: PostsManagerApp.PresenterToViewUserPostsProtocol?
    
    var interactor: PostsManagerApp.PresenterToInteractorUserPostsProtocol?
    
    var router: PostsManagerApp.PresenterToRouterUserPostsProtocol?
    
    var selectedUser: PostsManagerApp.User?
    
    func viewDidLoad() {
    }
    
    var presenter: InteractorToPresenterUserPostsProtocol?
    var returnedPosts: Bool = false

    func fetchPosts(posts: [Post]) {
        if posts.count > 0 {
            self.returnedPosts = true
        } else {
            self.returnedPosts = false
        }
    }
}

class LocalDataManagerUserPostsMock: InteractorToLocalDataManagerUserPostsProtocol {
    func saveLocalUserPosts(posts: [PostsManagerApp.Post]) {
    }
    
    var localRequestHandler: LocalDataManagerToInteractorUserPostsProtocol?
    var listPostsResponse: [Post] = []

    func getLocalUserPosts(userId: Int) {
        localRequestHandler?.callBakLocalPosts(posts: listPostsResponse, userId: userId)
    }
}

class RemoteDataManagerUserPostsMock: InteractorToPresenterUsersProtocol {
    func fetchUsers(users: [PostsManagerApp.User]) {
    }
    
    var remoteRequestHandler: RemoteDataManagerToInteractorUserPostsProtocol?
    var listPostsResponse: [Post] = []

    func getLocalUserPosts(userId: Int) {
        remoteRequestHandler?.callBakRemotePostsSuccess(posts: listPostsResponse)
    }
}

