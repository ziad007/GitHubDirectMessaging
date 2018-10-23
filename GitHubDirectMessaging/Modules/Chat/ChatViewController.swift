
import UIKit

final class ChatViewController: UIViewController {

    private var user: User
    static let height: CGFloat = 100
    static let mineCellIdentifier = "MessageMineTableViewCell"
    static let otherCellIdentifier = "MessageOtherTableViewCell"

    fileprivate let chatInteractor: ChatInteractor
    fileprivate lazy var keyboardHC: NSLayoutConstraint = {
        return self.chatView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
    }()

    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        return tableView
    }()

    fileprivate lazy var chatView: ChatTextFieldView = {
        let chatView = Bundle.main.loadNibNamed("ChatTextFieldView", owner: self, options: nil)?.first as! ChatTextFieldView
        chatView.delegate = self
        chatView.translatesAutoresizingMaskIntoConstraints = false
        return chatView
    }()

    init(user: User) {
        self.user = user
        chatInteractor = ChatInteractor(userID: user.id)

        super.init(nibName: nil, bundle: nil)

        chatInteractor.controller = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

        tableView.register(MessageMineTableViewCell.self, forCellReuseIdentifier: ChatViewController.mineCellIdentifier)
           tableView.register(MessageOtherTableViewCell.self, forCellReuseIdentifier: ChatViewController.otherCellIdentifier)
        tableView.tableFooterView = UIView()

        tableView.dataSource = self

        setupNavigationItem()
        addComponents()
        layoutComponents()
        setupLoadCompletion()

        fetchData()
    }

    private func setupNavigationItem() {
        navigationItem.title = user.login
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
            keyboardHC,
            chatView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            ])
    }

    private func fetchData() {
        chatInteractor.fetchMessages()
    }

    private func setupLoadCompletion() {
        chatInteractor.requestloadMessagesCompleteHandler = { [weak self] () in
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

    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo
        let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        keyboardHC.constant = -keyboardFrame.size.height
        let duration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]

        UIView.animate(withDuration: duration as! TimeInterval, animations: {
            self.view.layoutIfNeeded()
        })
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let userInfo = notification.userInfo
        keyboardHC.constant = 0
        let duration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]

        UIView.animate(withDuration: duration as! TimeInterval, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

extension ChatViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatInteractor.messagesResponse?.values?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let messages = chatInteractor.messagesResponse?.values else { fatalError() }

        let message = messages[indexPath.row]
        if message.isMine {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatViewController.mineCellIdentifier) as! MessageMineTableViewCell
                cell.configure(message: message)
                return cell
            } else {
                 let cell = tableView.dequeueReusableCell(withIdentifier: ChatViewController.otherCellIdentifier) as! MessageOtherTableViewCell
                cell.configure(message: message)
                return cell
            }
    }
}

extension ChatViewController: ChatTextFieldViewDelegate {
    func sendButtonDidTap(body: String) {
       chatInteractor.saveMessage(body: body)
    }
}
