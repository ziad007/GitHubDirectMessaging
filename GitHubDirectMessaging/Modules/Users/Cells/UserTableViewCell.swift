import Foundation
import UIKit

final class UserTableViewCell: UITableViewCell {

    private let rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .center
        return stackView
    }()

    private let userAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 999, height: 999))

        rootStackView.addArrangedSubview(userAvatarImageView)
        rootStackView.addArrangedSubview(userNameLabel)

        contentView.addSubview(rootStackView)
        layoutComponents()
    }

    private func layoutComponents() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            rootStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            rootStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            rootStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            userAvatarImageView.widthAnchor.constraint(equalToConstant: 50),
            userAvatarImageView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }

    func configure(user: User?) {

        guard let user = user  else {
            return
        }
        userAvatarImageView.image = nil
        userNameLabel.text = user.login
        if let urlString = user.avatarUrl, let url = URL(string: urlString) {
            userAvatarImageView.downloadedFrom(url: url)
        }
    }
}
