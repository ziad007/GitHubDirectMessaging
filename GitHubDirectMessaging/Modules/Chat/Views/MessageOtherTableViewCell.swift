import Foundation
import UIKit

final class MessageOtherTableViewCell: MessageTableViewCell {

    override func setupBubbleImageView() {
        bubbleImageView.image = UIImage(named: "left_bubble")!
            .resizableImage(withCapInsets:
                UIEdgeInsets(top: 16, left: 18, bottom: 16, right: 18),
                            resizingMode: .stretch)

    }

    override func layoutComponents() {
        NSLayoutConstraint.activate([
            textMessageLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 16),
            textView.bottomAnchor.constraint(equalTo: textMessageLabel.bottomAnchor,constant: 16),
            textView.trailingAnchor.constraint(equalTo: textMessageLabel.trailingAnchor, constant: 16),
            textMessageLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 16),

            bubbleImageView.widthAnchor.constraint(equalTo: textView.widthAnchor),
            bubbleImageView.heightAnchor.constraint(equalTo: textView.heightAnchor),

            textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: textView.bottomAnchor,constant: 16),
            contentView.trailingAnchor.constraint(greaterThanOrEqualTo: textView.trailingAnchor, constant: 30),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
            ])
    }
}
