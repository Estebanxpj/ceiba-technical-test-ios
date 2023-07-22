//
//  UserPostsViewController.swift
//  PostsManagerApp
//
//  Created by Esteban Penagos Salazar on 21/07/23.
//

import UIKit

class UserPostsViewController: UIViewController {
    
    @IBOutlet weak var postsTable: UITableView!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    @IBOutlet weak var textName: UILabel!
    @IBOutlet weak var textEmail: UILabel!
    @IBOutlet weak var textPhone: UILabel!
        
    var presenter: ViewToPresenterUserPostsProtocol?
    var listPosts: [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }
}

extension UserPostsViewController: PresenterToViewUserPostsProtocol {
    func pushPosts(posts: [Post]) {
        listPosts = posts
        DispatchQueue.main.async {
            self.postsTable.reloadData()
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

    func showInfoUser(user: User) {
        DispatchQueue.main.async {
            self.textName.text = user.name
            self.textEmail.text = user.email
            self.textPhone.text = user.phone
        }
    }

    func showMessage(message: String) {
        let alertController: UIAlertController = UIAlertController(title: "Posts", message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension UserPostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "postCell")
        cell.textLabel?.text = listPosts[indexPath.row].title
        cell.detailTextLabel?.text = listPosts[indexPath.row].body
        return cell
    }

}
