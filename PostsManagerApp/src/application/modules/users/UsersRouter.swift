import UIKit

class UsersRouter: PresenterToRouterUsersProtocol {

    static func createUsersModule() -> UIViewController {
        let navController = mainstoryboard.instantiateViewController(withIdentifier: "navigation")

        if let view = navController.children.first as? UsersViewController {
        
            let presenter: ViewToPresenterUsersProtocol & InteractorToPresenterUsersProtocol = UsersPresenter()
            let interactor: PresenterToInteractorUsersProtocol & RemoteDataManagerToInteractorUsersProtocol & LocalDataManagerToInteractorUsersProtocol = UsersInteractor()
            let remoteDataManager: InteractorToRemoteDataManagerUsersProtocol = UserRemoteDataManager()
            let localDataManager: InteractorToRemoteDataManagerUsersProtocol = UserLocalDataManager()
            let router: PresenterToRouterQuotesProtocol = UsersRouter()
            
            view.presentor = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            interactor.localDataManager = localDataManager
            
            return navController 
        }

        return UIViewController()
    }

    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "UsersView", bundle: Bundle.main)
    }

    func presentPostsModule(form view: ViewToPresenterUsersProtocol, withData: User) {
        let newUserPostsView = UserPostsRouter.createUserPostsModule(withData)

        if let pushView = view as? UIViewController {
            pushView.navigationController?.pushViewController(newUserPostsView, animated: true)
        }
    }
}