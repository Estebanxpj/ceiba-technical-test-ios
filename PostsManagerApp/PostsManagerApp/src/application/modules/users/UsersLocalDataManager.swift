//
//  UsersLocalDataManager.swift
//  PostsManagerApp
//
//  Created by Esteban Penagos Salazar on 21/07/23.
//

import Foundation

class UsersLocalDataManager: InteractorToLocalDataManagerUsersProtocol {
    
    var localRequestHandler: LocalDataManagerToInteractorUsersProtocol?
    
    func getLocalUsers() {
        let repository = LocalDataRepository<UserRealm>()
        let users = repository.fetchAll()
        localRequestHandler?.callBakLocalUsers(with: users)
    }

    func saveLocalUsers(users: [User]) {
        do {
            let repository = LocalDataRepository<UserRealm>()
            try repository.save(items: users)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
