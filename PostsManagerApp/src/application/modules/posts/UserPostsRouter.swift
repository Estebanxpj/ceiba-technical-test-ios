import UIKit

class UserPostsRouter: PresenterToRouterUserPostsProtocol {
    static func createUserPostsModule(with user: User) -> UIViewController {
        let viewController = mainstoryboard.instantiateViewController(withIdentifier: "postViewController")

        if let view = viewController as? UserPostsViewController {
            let presenter: ViewToPresenterUserPostsProtocol & InteractorToPresenterUserPostsProtocol = UserPostsPresenter()
            let interactor: PresenterToInteractorUserPostsProtocol & RemoteDataManagerToInteractorUserPostsProtocol & LocalDataManagerToInteractorUserPostsProtocol = UserPostsInteractor()
            let remoteDataManager: InteractorToRemoteDataManagerUserPostsProtocol = UserPostsRemoteDataManager()
            let localDataManager: InteractorToLocalDataManagerUserPostsProtocol = UserPostsLocalDataManager()
            let router: PresenterToRouterUserPostsProtocol = UserPostsRouter()
            
            view.presentor = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            presenter.selectedUser = user
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            interactor.localDataManager = localDataManager
            
            return viewController 
        }

        return UIViewController()
    }

    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "UserPostsView", bundle: Bundle.main)
    }
}