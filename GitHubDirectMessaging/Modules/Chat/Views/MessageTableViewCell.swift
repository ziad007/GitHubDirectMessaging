import Foundation
import UIKit

class MessageTableViewCell: UITableViewCell {

    let textView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let textMessageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
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

    func setupBubbleImageView() {}

    private func commonInit() {
        textView.addSubview(bubbleImageView)
        textView.addSubview(textMessageLabel)

        contentView.addSubview(textView)

        layoutComponents()
        setupBubbleImageView()
    }

    func layoutComponents() {
        NSLayoutConstraint.activate([
            textMessageLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 16),
            textMessageLabel.bottomAnchor.constraint(equalTo: textView.bottomAnchor,constant: -16),
            textMessageLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -16),
            textMessageLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 16),

            bubbleImageView.widthAnchor.constraint(equalTo: textView.widthAnchor),
            bubbleImageView.heightAnchor.constraint(equalTo: textView.heightAnchor),

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
