//
//  UsersInteractor.swift
//  PostsManagerApp
//
//  Created by Sebastian Betancur Salazar on 21/07/23.
//

import Foundation

class UsersInteractor: PresenterToInteractorUsersProtocol {
    weak var presenter: InteractorToPresenterUsersProtocol?
    var localDataManager:  InteractorToLocalDataManagerUsersProtocol?
    var remoteDataManager: InteractorToRemoteDataManagerUsersProtocol?

    func loadUsers() {
        localDataManager?.getLocalUsers()
    }
}

extension UsersInteractor: RemoteDataManagerToInteractorUsersProtocol {
    func callBakRemoteUsersSuccess(with users: [User]) {
        if users.count == 0 {
            localDataManager?.saveLocalUsers(users: users)
        }
        presenter?.fetchUsers(users: users)
    }
}

extension UsersInteractor: LocalDataManagerToInteractorUsersProtocol {
    func callBakLocalUsers(with users: [User]) {
        if users.count == 0 {
            remoteDataManager?.getRemoteUsers()
        } else {
            presenter?.fetchUsers(users: users)
        }
    }
}
