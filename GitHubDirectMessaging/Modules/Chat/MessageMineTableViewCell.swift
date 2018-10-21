import Foundation
import UIKit

final class MessageMineTableViewCell: MessageTableViewCell {

    override func layoutComponents() {
        super.layoutComponents()
        NSLayoutConstraint.activate([
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 30)
            ])
    }
}
