import Foundation

protocol ViewToPresenterUserPostsProtocol: class  {
    var view: PresenterToViewUserPostsProtocol? { get set }
    var interactor: PresenterToInteractorUserPostsProtocol? { get set }
    var router: PresenterToRouterUserPostsProtocol? { get set }
    var selectedUser: User? { get set }

    func viewDidLoad()
}

protocol PresenterToViewUserPostsProtocol:class {
    var presenter: ViewToPresenterUserPostsProtocol? { get set }

    func showInfoUser(user: user)
    func pushPosts(posts: [Post])
    func showMessage(message: String)
    func startSpiner()
    func stopSpiner()
}

protocol PresenterToRouterUserPostsProtocol:class {
    static func createUserPostsModule(with user: User) -> UIViewController
}

protocol InteractorToPresenterUserPostsProtocol:class {
    func fetchPosts(posts: [Post])
}

protocol PresenterToInteractorUserPostsProtocol:class {
    var presenter: InteractorToPresenterUserPostsProtocol? { get set }
    var localDataManager: LocalDataManagerToInteractorUserPostsProtocol? { get set }
    var remoteDataManager: RemoteDataManagerToInteractorUserPostsProtocol? { get set }
    func loadUserPosts(userId: Int)
}

protocol InteractorToRemoteDataManagerUserPostsProtocol:class {  
    var remoteRequestHandler: RemoteDataManagerToInteractorUserPostsProtocol? { get set }
    func getRemoteUserPosts(userId: Int)
}

protocol RemoteDataManagerToInteractorUserPostsProtocol:class { 
    func callBakRemotePostsSuccess(posts: [Post])
}

protocol InteractorToLocalDataManagerUserPostsProtocol:class {
    var localRequestHandler: LocalDataManagerToInteractorUserPostsProtocol? { get set }
    func getLocalUserPosts(userId: Int)
}

protocol LocalDataManagerToInteractorUserPostsProtocol:class {
    func callBakLocalPosts(posts: [Post])
}