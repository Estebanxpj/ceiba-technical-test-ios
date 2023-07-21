import Foundation

class UserPostsLocalDataManager: InteractorToLocalDataManagerUserPostsProtocol {
    var localRequestHandler: LocalDataManagerToInteractorUserPostsProtocol?
    
    func getLocalUserPosts(userId: Int) {       
        let repository = LocalDataRepository<PostRealm>()
        if let posts = repository?.fetch(NSPredicate(format: "userId == \(userId)"))? {
            localRequestHandler.callBakLocalPosts(posts)
        }
    }

    func saveLocalUserPosts(posts: [Post]) {
        do {
            let repository = RealmService<PostRealm>()
            try repository.save(items: posts)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}