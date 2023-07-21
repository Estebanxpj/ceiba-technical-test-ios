import Foundation

class UsersLocalDataManager: InteractorToRemoteDataManagerUsersProtocol {
    var localRequestHandler: LocalDataManagerToInteractorUsersProtocol?
    
    func getLocalUsers() {
        let repository = LocalDataRepository<UserRealm>()
        if let users = repository?.fetchAll()? {
            localRequestHandler.callBakLocalUsers(users)
        }
    }

    func saveLocalUsers(users: [User]) {
        do {
            let repository = RealmService<UserRealm>()
            try repository.save(items: users)
            completion()
        } catch let error {
            print(error.localizedDescription)
            completion()
        }
    }
}