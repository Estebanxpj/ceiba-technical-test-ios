//
//  UserPostsLocalDataManager.swift
//  PostsManagerApp
//
//  Created by Sebastian Betancur Salazar on 21/07/23.
//

import Foundation

class UserPostsLocalDataManager: InteractorToLocalDataManagerUserPostsProtocol {
    var localRequestHandler: LocalDataManagerToInteractorUserPostsProtocol?
    
    func getLocalUserPosts(userId: Int) {
        let repository = LocalDataRepository<PostRealm>()
        let posts = repository.fetch(predicate: NSPredicate(format: "userId == \(userId)"), sorted: nil)
        localRequestHandler?.callBakLocalPosts(posts: posts, userId: userId)
    }
    func saveLocalUserPosts(posts: [Post]) {
        do {
            let repository = LocalDataRepository<PostRealm>()
            try repository.save(items: posts)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
