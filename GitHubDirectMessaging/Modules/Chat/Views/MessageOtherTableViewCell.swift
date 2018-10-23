import Foundation
import UIKit

final class MessageOtherTableViewCell: MessageTableViewCell {

    override func setupBubbleImageView() {
        bubbleImageView.image = UIImage(named: "left_bubble")!
            .resizableImage(withCapInsets:
                UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                            resizingMode: .stretch)

    }

    override func layoutComponents() {
        NSLayoutConstraint.activate([
            textMessageLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 20),
            textView.bottomAnchor.constraint(equalTo: textMessageLabel.bottomAnchor,constant: 20),
            textView.trailingAnchor.constraint(equalTo: textMessageLabel.trailingAnchor, constant: 20),
            textMessageLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 20),

            bubbleImageView.widthAnchor.constraint(equalTo: textView.widthAnchor),
            bubbleImageView.heightAnchor.constraint(equalTo: textView.heightAnchor),

            textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: textView.bottomAnchor,constant: 16),
            contentView.trailingAnchor.constraint(greaterThanOrEqualTo: textView.trailingAnchor, constant: 30),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
            ])
    }
}
