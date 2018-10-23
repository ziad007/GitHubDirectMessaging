import Foundation
import UIKit

final class MessageMineTableViewCell: MessageTableViewCell {

    override func setupBubbleImageView() {
        bubbleImageView.image = UIImage(named: "right_bubble.png")!
            .resizableImage(withCapInsets:
                UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 25),
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
            contentView.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: 16),
            textView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 30)
            ])

    }
}
