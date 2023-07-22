//
//  UserPostsPresenterTests.swift
//  PostsManagerAppTests
//
//  Created by Esteban Penagos Salazar on 21/07/23.
//

import XCTest
@testable import PostsManagerApp

final class UserPostsPresenterTests: XCTestCase {

    var sut: UserPostsPresenter!
    var viewMock: ViewUserPostsMock!
    var interactorMock: InteractorUserPostsMock?

    override func setUpWithError() throws {
        sut = UserPostsPresenter()
        viewMock = ViewUserPostsMock()
        interactorMock = InteractorUserPostsMock()
        sut?.view = viewMock
        sut?.interactor = interactorMock
    }

    override func tearDownWithError() throws {
        viewMock = nil
        sut = nil
        interactorMock = nil
    }

    func tests_viewDidLoad() throws {
        sut.selectedUser = User(JSONString: "")
        sut?.viewDidLoad()
        XCTAssertTrue(viewMock?.isAlertShow ?? false)
        XCTAssertTrue(viewMock?.isAlertShow ?? false)
    }
}

class ViewUserPostsMock: PresenterToViewUserPostsProtocol {
    func showInfoUser(user: PostsManagerApp.User) {
    }
    
    var presenter: ViewToPresenterUserPostsProtocol?
    
    var isAlertShow: Bool = false
    var spiner: Bool = false
    var listPosts: [Post] = []

    func pushPosts(posts: [Post]) {
        listPosts = posts
    }

    func startSpiner() {
        spiner = true
    }

    func stopSpiner() {
        spiner = false
    }

    func showMessage(message: String) {
        isAlertShow = true
    }
}

class InteractorUserPostsMock: PresenterToInteractorUserPostsProtocol {
    var localDataManager: PostsManagerApp.InteractorToLocalDataManagerUserPostsProtocol?
    
    var remoteDataManager: PostsManagerApp.InteractorToRemoteDataManagerUserPostsProtocol?
    
    func loadUserPosts(userId: Int) {
    }
    
    var presenter: InteractorToPresenterUserPostsProtocol?
    var listPostsResponse: [Post] = []

    func loadUserPosts() {
        presenter?.fetchPosts(posts: listPostsResponse)
    }
}
