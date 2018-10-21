//
//  ChatTextFieldView.swift
//  GitHubDirectMessaging
//
//  Created by ziad Bou Ismail on 10/18/18.
//  Copyright © 2018 Ziad. All rights reserved.
//

import Foundation
import UIKit

protocol ChatTextFieldViewDelegate: class {
    func sendButtonDidTap(body: String)
}

class ChatTextFieldView: UIView {

    @IBOutlet weak var messageTextView: UITextView!
    weak var delegate: ChatTextFieldViewDelegate?

    @IBAction private func didSelectSend(_ sender: AnyObject) {

        guard let body = messageTextView.text else { return }
        delegate?.sendButtonDidTap(body: body)
        messageTextView.text = ""
        messageTextView.resignFirstResponder()

    }
}
