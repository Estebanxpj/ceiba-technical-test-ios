import XCTest
@testable import PostsManagerApp

class UserPostsInteractorTests: XCTestCase {

    var sut: UserPostsInteractor!
    var presenterMock: PresenterUserPostsMock!
    var localDataManagerMock: LocalDataManagerUserPostsMock?
    var remoteDataManagerMock: RemoteDataManagerUserPostsMock?

    override func setUpWithError() throws {
        sut = UserPostsInteractor()
        presenterMock = PresenterUserPostsMock()
        localDataManagerMock = LocalDataManagerUserPostsMock()
        remoteDataManagerMock = RemoteDataManagerUserPostsMock()

        sut?.presenter = presenterMock
        sut?.localDataManager = localDataManagerMock
        sut?.remoteDataManager = remoteDataManagerMock
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
    var presenter: InteractorToPresenterUserPostsProtocol?
    var returnedPosts: Bool = false

    func fetchPosts(posts: [Post]) {
        if let listPosts = posts, posts.count > 0 {
            self.returnedPosts = true
        } else {
            self.returnedPosts = false
        }
    }
}

class LocalDataManagerUserPostsMock: InteractorToLocalDataManagerUserPostsProtocol {
    var localRequestHandler: LocalDataManagerToInteractorUserPostsProtocol?
    var listPostsResponse: [Post] = []

    func getLocalUserPosts(userId: Int) {       
        localRequestHandler.callBakLocalPosts(listPostsResponse)
    }
}

class RemoteDataManagerUserPostsMock: InteractorToPresenterUsersProtocol {
    var remoteRequestHandler: RemoteDataManagerToInteractorUserPostsProtocol?
    var listPostsResponse: [Post] = []

    func getLocalUserPosts(userId: Int) {       
        remoteRequestHandler.callBakRemotePostsSuccess(posts: listPostsResponse)
    }
}
