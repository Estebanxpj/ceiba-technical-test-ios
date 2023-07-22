//
//  UsersProtocol.swift
//  PostsManagerApp
//
//  Created by Esteban Penagos Salazar on 21/07/23.
//

import Foundation
import UIKit

protocol ViewToPresenterUsersProtocol: class  {
    var view: PresenterToViewUsersProtocol? { get set }
    var interactor: PresenterToInteractorUsersProtocol? { get set }
    var router: PresenterToRouterUsersProtocol? { get set }
    var originUserList: [User] { get set }

    func viewDidLoad()
    func showUserPostsView(user: User)
    func filterUsersList(filter: String)
}

protocol PresenterToViewUsersProtocol:class {
    var presenter: ViewToPresenterUsersProtocol? { get set }
    func pushUsers(users: [User])
    func startSpiner()
    func stopSpiner()
    func showErrorMessage(message: String)
    
}

protocol PresenterToRouterUsersProtocol:class {
    static func createUsersModule() -> UIViewController
    func presentPostsModule(form view: PresenterToViewUsersProtocol, withData: User)
}

protocol InteractorToPresenterUsersProtocol:class {
    func fetchUsers(users: [User])
}

protocol PresenterToInteractorUsersProtocol: class {
    var presenter: InteractorToPresenterUsersProtocol? { get set }
    var localDataManager: InteractorToLocalDataManagerUsersProtocol? { get set }
    var remoteDataManager: InteractorToRemoteDataManagerUsersProtocol? { get set }
    func loadUsers()
}

protocol InteractorToRemoteDataManagerUsersProtocol: class {
    var remoteRequestHandler: RemoteDataManagerToInteractorUsersProtocol? { get set }
    func getRemoteUsers()
}

protocol RemoteDataManagerToInteractorUsersProtocol:class {
    func callBakRemoteUsersSuccess(with users: [User])
}

protocol InteractorToLocalDataManagerUsersProtocol:class {
    var localRequestHandler: LocalDataManagerToInteractorUsersProtocol? { get set }
    func getLocalUsers()
    func saveLocalUsers(users: [User])
}

protocol LocalDataManagerToInteractorUsersProtocol:class {
    func callBakLocalUsers(with users: [User])
}
