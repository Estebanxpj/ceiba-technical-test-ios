//
//  UsersViewController.swift
//  PostsManagerApp
//
//  Created by Sebastian Betancur Salazar on 21/07/23.

import Foundation
import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var usersTable: UITableView!
    
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    @IBOutlet weak var filterBar: UISearchBar!
    
    var presenter: ViewToPresenterUsersProtocol?
    var originUserList: [User] = []
    var listUsers: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }
}

extension UsersViewController: PresenterToViewUsersProtocol {
    func pushUsers(users: [User]) {
        listUsers = users
        DispatchQueue.main.async {
            self.usersTable.reloadData()
        }
    }

    func startSpiner() {
        DispatchQueue.main.async {
            self.spiner.startAnimating()
        }

    }

    func stopSpiner() {
        DispatchQueue.main.async {
            self.spiner.stopAnimating()
            self.spiner.hidesWhenStopped = true
        }
    }

    func showErrorMessage(message: String) {
        let alertController: UIAlertController = UIAlertController(title: "User List", message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}


extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "userCell") as! UserCell
        
        cell.txtName?.text = listUsers[indexPath.row].name
        cell.txtEmail.text = listUsers[indexPath.row].email
        cell.txtPhone?.text = listUsers[indexPath.row].phone
        return cell
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showUserPostsView(user: listUsers[indexPath.row])
    }
}

extension UsersViewController: UISearchBarDelegate {
    func searchBar(_searchBar: UISearchBar, textDidChange searchTest: String){
        presenter?.filterUsersList(filter: searchTest)
    }

}

class UserCell: UITableViewCell{
    
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtPhone: UILabel!
    
}
