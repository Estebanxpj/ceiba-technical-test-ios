//
//  UserPostsInteractor.swift
//  PostsManagerApp
//
//  Created by Esteban Penagos Salazar on 21/07/23.
//

import Foundation

class UserPostsInteractor: PresenterToInteractorUserPostsProtocol {
    weak var presenter: InteractorToPresenterUserPostsProtocol?
    var localDataManager:  InteractorToLocalDataManagerUserPostsProtocol?
    var remoteDataManager: InteractorToRemoteDataManagerUserPostsProtocol?

    func loadUserPosts(userId: Int) {
        localDataManager?.getLocalUserPosts(userId: userId)
    }
}

extension UserPostsInteractor: RemoteDataManagerToInteractorUserPostsProtocol {
    func callBakRemotePostsSuccess(posts: [Post]) {
        if posts.count == 0 {
            localDataManager?.saveLocalUserPosts(posts: posts)
        }
        presenter?.fetchPosts(posts: posts)
    }
}

extension UserPostsInteractor: LocalDataManagerToInteractorUserPostsProtocol {
    func callBakLocalPosts(posts: [Post], userId: Int) {
        if posts.count == 0 {
            remoteDataManager?.getRemoteUserPosts(userId: userId)
        } else {
            presenter?.fetchPosts(posts: posts)
        }
    }
}
