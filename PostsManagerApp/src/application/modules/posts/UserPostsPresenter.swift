import Foundation

class UserPostsPresenter: ViewToPresenterUserPostsProtocol {
    weak var view: PresenterToViewUserPostsProtocol?
    var interactor: PresenterToInteractorUserPostsProtocol?
    var router: PresenterToRouterUserPostsProtocol?
    var selectedUser: User?

    func viewDidLoad() {
        if let user = selectedUser {
            view.showInfoUser(user: user)
            interactor?.loadUserPosts(user.id)
            view.startSpiner()
        }
    }

}

extension UserPostsPresenter: InteractorToPresenterUserPostsProtocol {
    
    func fetchPosts(posts: [Post]){        
        view.stopSpiner()
        if let listPosts = posts, posts.count > 0 {
            view.pushPosts(posts: posts)
        } else {
            let message: String = "No entries found for the selected user"
            view?.showErrorMessage()
        }
    }
}