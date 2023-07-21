import Foundation

class UsersRemoteDataManager: InteractorToRemoteDataManagerUsersProtocol {
    var remoteRequestHandler: RemoteDataManagerToInteractorUsersProtocol?
    var service: RemoteDataService

    func getRemoteUsers() {
        service = RemoteDataService()

        var concatUrl = "users"
        service.getData(urlString: urlString, success: { (code, data) in
            if let users = data? {
                remoteRequestHandler.callBakRemoteUsersSuccess(users: users)
            }
        })
    }
}