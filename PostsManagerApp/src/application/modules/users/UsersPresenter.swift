import Foundation

class UsersPresenter: ViewToPresenterUsersProtocol {
    weak var view: PresenterToViewUsersProtocol?
    var interactor: PresenterToInteractorUsersProtocol?
    var router: PresenterToRouterUsersProtocol?

    func viewDidLoad() {
        interactor?.loadUsers()
        view?.startSpiner()
    }

    func filterUsersList(filter: String) {
        var users = filter ? view?.originUserList?.filter({$0.name.lowercased().contains(filter.lowercased())}): view?.originUserList
        if let listUsers = users, users.count > 0 {
            view?.pushUsers(users: users)
        } else {
            let message: String = "List is empty"
            view?.showErrorMessage()
        }
    }

    func showUserPostsView(user: User) {
        router?.presentPostsModule(form: view!, user: user)
    }

}

extension UsersPresenter: InteractorToPresenterUsersProtocol {
    func fetchUsers(users: [User]){
        view?.stopSpiner()
        if let listUsers = users, users.count > 0 {
            view?.originUserList = listUsers
            view?.pushUsers(users: users)
        } else {
            let message: String = "No Users found"
            view?.showErrorMessage()
        }
    }
}