import Foundation
import UIKit

class MessageTableViewCell: UITableViewCell {
    let textView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let textMessageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
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
        textView.addSubview(textMessageLabel)

        contentView.addSubview(textView)
        layoutComponents()
    }

    func layoutComponents() {
        NSLayoutConstraint.activate([
            textMessageLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 5),
            textMessageLabel.bottomAnchor.constraint(equalTo: textView.bottomAnchor,constant: -5),
            textMessageLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -5),
            textMessageLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 5),

            textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -16),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16)
            ])
    }

    func configure(message: Message) {
        textMessageLabel.text = message.body
    }
}
