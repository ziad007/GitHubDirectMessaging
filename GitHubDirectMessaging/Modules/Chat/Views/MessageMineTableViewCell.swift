import Foundation
import UIKit

final class MessageMineTableViewCell: MessageTableViewCell {

    override func setupBubbleImageView() {
        bubbleImageView.image = UIImage(named: "right_bubble.png")!
            .resizableImage(withCapInsets:
                UIEdgeInsets(top: 16, left: 18, bottom: 16, right: 18),
                            resizingMode: .stretch)

    }

    override func layoutComponents() {
        super.layoutComponents()
        NSLayoutConstraint.activate([
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 30)
            ])
    }
}
