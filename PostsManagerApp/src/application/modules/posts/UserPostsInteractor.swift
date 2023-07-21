import Foundation

class UserPostsInteractor: PresenterToInteractorUserPostsProtocol {

    weak var presenter: InteractorToPresenterUserPostsProtocol?
    var localDataManager:  InteractorToLocalDataManagerUserPostsProtocol?
    var remoteDataManager: InteractorToRemoteDataManagerUserPostsProtocol?

    func loadUserPosts(userId: Int) {
        localDataManager.getLocalUserPosts(userId: userId)
    }
}

extension UserPostsInteractor: RemoteDataManagerToInteractorUserPostsProtocol {
    func callBakRemotePostsSuccess(with posts: [Post]) {
        if let listPosts = !posts {
            presenter.fetchPosts(posts: posts)
            localDataManager.saveLocalUserPosts(users)
        }
    }
}

extension UserPostsInteractor: LocalDataManagerToInteractorUserPostsProtocol {
    func callBakLocalPosts(with posts: [Post]) {
        if let listPosts = !posts, posts.count == 0 {
            remoteDataManager.getRemoteUserPosts()
        } else {
            presenter.fetchPosts(posts: posts)
        }
    }
}