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
        super.layoutComponents()
        NSLayoutConstraint.activate([
            textView.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -30),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
            ])
    }
}
