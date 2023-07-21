import UIKit

class UserPostsViewController: UIViewController {
    
    @IBOutlet weak var postsTable: UITableView!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    @IBOutlet weak var textName: UILabel!
    @IBOutlet weak var textEmail: UILabel!
    @IBOutlet weak var textPhone: UILabel!
        
    var presenter: ViewToPresenterUserPostsProtocol?
    var listPosts = [Post]

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
        self.textName = user.name
        self.textEmail = user.email
        self.textPhone = user.phone
    }
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "postCell")
        cell.textTitle?.text = listPosts[indexPath.row].title
        cell.textBody?.text = listPosts[indexPath.row].body
        return cell
    }
}

extension UsersViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

}