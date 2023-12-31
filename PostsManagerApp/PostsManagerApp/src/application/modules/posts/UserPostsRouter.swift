//
//  UserPostsRouter.swift
//  PostsManagerApp
//
//  Created by Esteban Penagos Salazar on 21/07/23.
//

import UIKit

class UserPostsRouter: PresenterToRouterUserPostsProtocol {
    static func createUserPostsModule(with user: User) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "UserPostsViewController")

        if let view = viewController as? UserPostsViewController {
            let presenter: ViewToPresenterUserPostsProtocol & InteractorToPresenterUserPostsProtocol = UserPostsPresenter()
            let interactor: PresenterToInteractorUserPostsProtocol & RemoteDataManagerToInteractorUserPostsProtocol & LocalDataManagerToInteractorUserPostsProtocol = UserPostsInteractor()
            let remoteDataManager: InteractorToRemoteDataManagerUserPostsProtocol = UserPostsRemoteDataManager()
            let localDataManager: InteractorToLocalDataManagerUserPostsProtocol = UserPostsLocalDataManager()
            let router: PresenterToRouterUserPostsProtocol = UserPostsRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            presenter.selectedUser = user
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            interactor.localDataManager = localDataManager
            localDataManager.localRequestHandler = interactor
            remoteDataManager.remoteRequestHandler = interactor
            
            return viewController
        }

        return UIViewController()
    }

    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "UserPostsView", bundle: Bundle.main)
    }
}
