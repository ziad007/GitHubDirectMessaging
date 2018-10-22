//
//  PhotoInteractor.swift
//  Photos
//
//  Created by ziad Bou Ismail on 9/30/18.
//  Copyright © 2018 ziad Bou Ismail. All rights reserved.
//

import Foundation

protocol ChatInteractorInputs {
    func fetchMessages()
}

protocol ChatInteractorOutputs {
    var messagesResponse: PagedMessages? { get }
}

final class ChatInteractor: ChatInteractorInputs, ChatInteractorOutputs {
 
    var chatService: ChatService
    weak var controller: ChatViewController?
    var messagesResponse: PagedMessages?
    var requestloadMessagesCompleteHandler: (() -> Void)?
    var userID: Int

    var numberOfItems: Int {
        return messagesResponse?.values?.count ?? 0
    }

    init(userID: Int) {
        self.userID = userID
        chatService = ChatService(dialogID: String(self.userID))

        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveMessage(_:)), name:
            NSNotification.Name(rawValue: "didReceiveData"), object: nil)
    }

    func saveMessage(body: String) {
        let message = Message(body: body, isMine: true)
        chatService.saveMessage(message: message) { [weak self] (response) in
            guard let localSelf = self else { return }

            switch response {
            case .success(_):
                var messages = localSelf.messagesResponse?.values ?? []
                messages.append(message)
                localSelf.messagesResponse?.values = messages
                localSelf.requestloadMessagesCompleteHandler?()
            case .failure(_): break
            }
        }
    }

    func fetchMessages() {
        chatService.getMessages() { [weak self] (response) in
            guard let localSelf = self else { return }

            switch response {
            case .success(let result):
                localSelf.messagesResponse = result
                localSelf.requestloadMessagesCompleteHandler?()
            case .failure(_): break
            }
        }
    }

    @objc func onDidReceiveMessage(_ notification: Notification) {
        if let message = notification.object as? Message {
            chatService.saveMessage(message: message) { [weak self] (response) in
                guard let localSelf = self else { return }

                switch response {
                case .success(_):
                    var messages =  localSelf.messagesResponse?.values ?? []
                    messages.append(message)
                    localSelf.messagesResponse?.values = messages
                    localSelf.requestloadMessagesCompleteHandler?()
                case .failure(_): break
                }
            }
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
