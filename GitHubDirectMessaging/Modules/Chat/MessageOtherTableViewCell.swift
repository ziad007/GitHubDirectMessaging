import Foundation
import UIKit

final class MessageOtherTableViewCell: MessageTableViewCell {

    override func layoutComponents() {
        super.layoutComponents()
        NSLayoutConstraint.activate([
            textView.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -30),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
            ])
    }
}

