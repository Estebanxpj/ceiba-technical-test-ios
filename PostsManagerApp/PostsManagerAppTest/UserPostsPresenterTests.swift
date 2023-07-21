import XCTest
@testable import PostsManagerApp

class UserPostsPresenterTests: XCTestCase {

    var sut: UserPostsPresenter!
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
        viewMock = nil
        sut = nil
        interactorMock = nil
        routerMock= nil
    }

    func tests_viewDidLoad() throws {
        sut.selectedUser = nil
        interactorMock.
        sut?.viewDidLoad(sut.selectedUser)
        XCTAssertTrue(viewMock?.isAlertShow ?? false)
        XCTAssertTrue(viewMock?.isSpinerShow ?? false)
    }
}

class ViewUserPostsMock: PresenterToViewUserPostsProtocol {
    var presenter: ViewToPresenterUserPostsProtocol?
    
    var isAlertShow: Bool = false
    var spiner: Bool = false
    var listPosts: [Post]

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
    var presenter: InteractorToPresenterUserPostsProtocol?
    var listPostsResponse: [Post] = []

    func loadUserPosts() {
        presenter.fetchPosts(posts: listPostsResponse)
    }
}
