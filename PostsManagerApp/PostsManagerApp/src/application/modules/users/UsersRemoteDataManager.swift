//
//  UsersRemoteDataManager.swift
//  PostsManagerApp
//
//  Created by Esteban Penagos Salazar on 21/07/23.
//

class UsersRemoteDataManager: InteractorToRemoteDataManagerUsersProtocol {
    
    var remoteRequestHandler: RemoteDataManagerToInteractorUsersProtocol?
    var service: RemoteDataService?

    func getRemoteUsers() {
        self.service = RemoteDataService()

        var concatUrl = "users"
        self.service?.getData(_type: User.self, concatUrl: concatUrl, complete: { (code, data) in
            self.remoteRequestHandler?.callBakRemoteUsersSuccess(with: data)
        })
    }
}
