//
//  UsersPresenter.swift
//  PostsManagerApp
//
//  Created by Esteban Penagos Salazar on 21/07/23.
//

import Foundation

class UsersPresenter: ViewToPresenterUsersProtocol {

    weak var view: PresenterToViewUsersProtocol?
    var interactor: PresenterToInteractorUsersProtocol?
    var router: PresenterToRouterUsersProtocol?
    
    var originUserList = [User]()
    
    func viewDidLoad() {
        interactor?.loadUsers()
        view?.startSpiner()
    }

    func filterUsersList(filter: String) {
        let users = filter != "" ? self.originUserList.filter({$0.name.lowercased().contains(filter.lowercased())}) : self.originUserList
        
        if users.count > 0 {
            view?.pushUsers(users: users)
        } else {
            let message: String = "List is empty"
            view?.showErrorMessage(message: message)
        }
    }

    func showUserPostsView(user: User) {
        router?.presentPostsModule(form: view!, withData: user)
    }

}

extension UsersPresenter: InteractorToPresenterUsersProtocol {
    func fetchUsers(users: [User]){
        if users.count > 0 {
            self.originUserList = users
            view?.pushUsers(users: users)
        } else {
            let message: String = "No Users found"
            view?.showErrorMessage(message: message)
        }
        view?.stopSpiner()
    }
}
