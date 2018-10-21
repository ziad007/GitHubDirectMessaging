
import UIKit

final class ChatViewController: UIViewController {


    private var userID: Int
    static let height: CGFloat = 100
    static let cellIdentifier = "MessageMineTableViewCell"

    fileprivate let chatInteractor: ChatInteractor

    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()

    fileprivate lazy var chatView: ChatTextFieldView = {
        let chatView = Bundle.main.loadNibNamed("ChatTextFieldView", owner: self, options: nil)?.first as! ChatTextFieldView
        chatView.delegate = self
        chatView.translatesAutoresizingMaskIntoConstraints = false
        return chatView
    }()

    init(userID: Int) {
        self.userID = userID
        chatInteractor = ChatInteractor(userID: userID)

        super.init(nibName: nil, bundle: nil)


        chatInteractor.controller = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(MessageMineTableViewCell.self, forCellReuseIdentifier: ChatViewController.cellIdentifier)
        tableView.tableFooterView = UIView()

        tableView.dataSource = self

        setupNavigationItem()
        addComponents()
        layoutComponents()
        setupLoadCompletion()

        fetchData()
    }

    private func setupNavigationItem() {
        navigationItem.title = "Messages"
        navigationController?.navigationBar.barTintColor = UIColor.white
        //  navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.gray]
        self.navigationController?.navigationBar.tintColor = .green
    }


    private func addComponents() {
        view.addSubview(tableView)
        view.addSubview(chatView)
    }

    private func layoutComponents() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
           tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            chatView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            chatView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            chatView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            chatView.heightAnchor.constraint(equalToConstant: 90)
            ])
    }

    private func fetchData() {
        chatInteractor.fetchMessages()
    }

    private func setupLoadCompletion() {
        chatInteractor.requestloadUsersCompleteHandler = { [weak self] () in
            guard let localSelf = self else { return }

            
            DispatchQueue.main.async {
                localSelf.tableView.reloadData()
                localSelf.scrollDown()
            }
        }
    }

    private func scrollDown() {
        let messageCount = chatInteractor.messagesResponse?.values?.count ?? 0

        if messageCount > 0 {
            let lastRowIndex = messageCount - 1
            let pathToLastRow = NSIndexPath(row: lastRowIndex, section: 0)
            tableView.scrollToRow(at: pathToLastRow as IndexPath, at: .bottom, animated: false)
        }

    }
}

extension ChatViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserListViewController.height
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatInteractor.messagesResponse?.values?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatViewController.cellIdentifier) as! MessageMineTableViewCell

        if let messages = chatInteractor.messagesResponse?.values {
            let message = messages[indexPath.row]
            cell.configure(message: message)
        }

        return cell
    }
}

extension ChatViewController: ChatTextFieldViewDelegate {
    func sendButtonDidTap(body: String) {
        chatInteractor.saveMessage(body: body)
    }
}

