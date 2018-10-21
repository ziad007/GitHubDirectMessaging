
import UIKit

final class UserListViewController: UIViewController {

    static let height: CGFloat = 70
    static let cellIdentifier = "UserTableViewCell"

    fileprivate var isLoading = false
    fileprivate var userImagesCache = [String: UIImage]()
    fileprivate let usersListInteractor: UsersListInteractor

    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()

    init() {
        usersListInteractor = UsersListInteractor()

        super.init(nibName: nil, bundle: nil)

        usersListInteractor.controller = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserListViewController.cellIdentifier)

        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self

        setupNavigationItem()
        addComponents()
        layoutComponents()
        setupLoadCompletion()

        fetchData()
    }

    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }

    private func setupNavigationItem() {
        navigationItem.title = "GitHub DM"
        navigationController?.navigationBar.barTintColor = UIColor.white
    }

    private func addComponents() {
        view.addSubview(tableView)
    }

    private func layoutComponents() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }

    fileprivate func fetchData() {
        isLoading = true
        usersListInteractor.fetchUsers()
    }

    private func setupLoadCompletion() {
        usersListInteractor.requestloadUsersCompleteHandler = { [weak self] () in
            guard let localSelf = self else { return }
            localSelf.isLoading = false
            localSelf.tableView.reloadData()
        }
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserListViewController.height
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersListInteractor.usersResponse?.values.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserListViewController.cellIdentifier) as! UserTableViewCell
        cell.accessoryType = .disclosureIndicator

        let user = usersListInteractor.usersResponse?.values[indexPath.row]
        cell.configure(user: user)
        cell.tag = indexPath.row
        cell.userAvatarImageView.image = UIImage(named: "avatar")

        if let urlString = user?.avatarUrl, let url = URL(string: urlString) {
            if let img = userImagesCache[urlString] {
                cell.userAvatarImageView.image = img
            } else {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async() {
                        if cell.tag == indexPath.row {
                            let imageData = UIImage(data: data)
                            self.userImagesCache[urlString] = imageData
                            cell.userAvatarImageView.image = imageData
                }
            }
        }
                task.resume()
            }

        }
        return cell
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let user = usersListInteractor.usersResponse?.values[indexPath.row] {
            self.navigationController?.pushViewController(ChatViewController(user: user), animated: true)
        }
    }
}

extension UserListViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height ) > scrollView.contentSize.height)
            && isLoading == false {
            fetchData()
        }
    }
}
