import Foundation

class UsersInteractor: PresenterToInteractorUsersProtocol {

    weak var presenter: InteractorToPresenterUsersProtocol?
    var localDataManager:  InteractorToLocalDataManagerUsersProtocol?
    var remoteDataManager: InteractorToRemoteDataManagerUsersProtocol?

    func loadUsers() {
        localDataManager.getLocalUsers()
    }
}

extension UsersInteractor: RemoteDataManagerToInteractorUsersProtocol {
    func callBakRemoteUsersSuccess(with users: [User]) {
        if let listUsers = !users {
            presenter.fetchUsers(users: users)
            localDataManager.saveLocalUsers(users)
        }
    }
}

extension UsersInteractor: LocalDataManagerToInteractorUsersProtocol {
    func callBakLocalUsers(with users: [User]) {
        if let listUsers = !users, users.count == 0 {
            remoteDataManager.getRemoteUsers()
        } else {
            presenter.fetchUsers(users: users)
        }
    }
}