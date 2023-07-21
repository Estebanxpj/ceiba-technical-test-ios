import Foundation
import UIKit

class UsersViewController: UIViewController {

    @IBOutlet weak var usersTable: UITableView!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    @IBOutlet weak var filterBar: UISearchBar!
    
    var presenter: ViewToPresenterUsersProtocol?
    var originUserList = [User]
    var listUsers = [User]

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
        let cell = UITableViewCell(style: .default, reuseIdentifier: "userCell")
        cell.textName?.text = listUsers[indexPath.row].textName
        cell.textEmail?.text = listUsers[indexPath.row].textEmail
        cell.textPhone?.text = listUsers[indexPath.row].textPhone
        return cell
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showUserPostsView(user: listUsers[indexPath.row])
    }
}

extension UsersViewController: UISearchBarDelegate {
    func searchBar(_searchBar: UISearchBar, textDidChange searchTest: String){
        present.filterUsersList(textDidChange)
    }

}