
import UIKit

final class UserListViewController: UIViewController {

    static let height: CGFloat = 100
    static let cellIdentifier = "UserTableViewCell"

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

    private func setupNavigationItem() {
        navigationItem.title = "Users"
        navigationController?.navigationBar.barTintColor = UIColor.white
      //  navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.gray]
        self.navigationController?.navigationBar.tintColor = .green
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

    private func fetchData() {
        usersListInteractor.fetchUsers()
    }

    private func setupLoadCompletion() {
        usersListInteractor.requestloadUsersCompleteHandler = { [weak self] () in
            guard let localSelf = self else { return }
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
        let user = usersListInteractor.usersResponse?.values[indexPath.row]
        cell.configure(user: user)
        return cell
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        let user = usersListInteractor.usersResponse?.values[indexPath.row]

        if let userID = user?.id{
            self.navigationController?.pushViewController(ChatViewController(userID: userID), animated: true)
        }
    }
}

