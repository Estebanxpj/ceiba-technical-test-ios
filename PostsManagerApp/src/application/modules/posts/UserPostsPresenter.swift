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
        view.pushPosts(posts: posts)

        view.stopSpiner()
    }
}