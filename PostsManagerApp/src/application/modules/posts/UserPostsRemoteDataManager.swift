import Foundation

class UserPostsRemoteDataManager: InteractorToRemoteDataManagerUserPostsProtocol {
    var remoteRequestHandler: RemoteDataManagerToInteractorUserPostsProtocol?
    var service: RemoteDataService

    func getRemoteUserPosts(userId: Int) {
        service = RemoteDataService()

        var concatUrl = "/posts?userId=\(userId)"
        service.getData(urlString: urlString, success: { (code, posts) in
            remoteRequestHandler.callBakRemotePostsSuccess(posts: posts)
        })
    }
}