//
//  UserPostsRemoteDataManager.swift
//  PostsManagerApp
//
//  Created by Esteban Penagos Salazar on 21/07/23.
//

import Foundation

class UserPostsRemoteDataManager: InteractorToRemoteDataManagerUserPostsProtocol {
    var remoteRequestHandler: RemoteDataManagerToInteractorUserPostsProtocol?
    var service: RemoteDataService?

    func getRemoteUserPosts(userId: Int) {
        service = RemoteDataService()

        var concatUrl = "/posts?userId=\(userId)"
        self.service?.getData(_type: Post.self, concatUrl: concatUrl, complete: { (code, data) in
            self.remoteRequestHandler?.callBakRemotePostsSuccess(posts: data)
        })
    }
}
