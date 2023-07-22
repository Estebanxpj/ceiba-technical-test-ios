//
//  UsersViewController.swift
//  PostsManagerApp
//
//  Created by Esteban Penagos Salazar on 21/07/23.

import Foundation
import UIKit

class UsersViewController: UIViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController()
    
    @IBOutlet weak var userFilter: UISearchBar!
    @IBOutlet weak var userSpiner: UIActivityIndicatorView!
    @IBOutlet weak var usersTable: UITableView!
    
    var presenter: ViewToPresenterUsersProtocol?
    var listUsers = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Buscar"
        self.presenter?.viewDidLoad()
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        self.usersTable.delegate = self
        self.usersTable.dataSource = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text else {
            return
        }
        presenter?.filterUsersList(filter: filter)
    }
}

extension UsersViewController: PresenterToViewUsersProtocol {
    func pushUsers(users: [User]) {
        self.listUsers = users
        DispatchQueue.main.async {
            self.usersTable.reloadData()
        }
    }

    func startSpiner() {
        DispatchQueue.main.async {
            //self.userSpiner.startAnimating()
        }

    }

    func stopSpiner() {
        DispatchQueue.main.async {
            self.userSpiner.stopAnimating()
            self.userSpiner.hidesWhenStopped = true
            
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 	{
        return self.listUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = self.listUsers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserViewCell
        
        cell.lblName?.text = user.name
        cell.lblEmail?.text = user.email
        cell.lblPhone?.text = user.phone
        cell.lblShowPost.text = "VER PUBLICACIONES"
        return cell
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showUserPostsView(user: listUsers[indexPath.row])
    }
}

