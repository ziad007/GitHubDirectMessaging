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
    var requestloadUsersCompleteHandler: (() -> Void)?
    var userID: Int
    var numberOfItems: Int {
        return messagesResponse?.values?.count ?? 0
    }

    init(userID: Int) {
        self.userID = userID
        chatService = ChatService(dialogID: String(self.userID))
    }

    func saveMessage(body: String) {
        let message = Message(body: body, isMine: true, postDate: Date())
        chatService.saveMessage(message: message) { [weak self] (response) in
            guard let localSelf = self else { return }

            switch response {
            case .success(_):

                var messages =   localSelf.messagesResponse?.values ?? []
                messages.append(message)
                localSelf.messagesResponse?.values = messages
                let receiveMessage = body + " " + body
                localSelf.receiveMessage(body: receiveMessage)
                localSelf.requestloadUsersCompleteHandler?()
            case .failure(_): break

                }
        }
    }

    func receiveMessage(body: String) {
        let message = Message(body: body, isMine: false, postDate: Date())
        chatService.saveMessage(message: message) { [weak self] (response) in
            guard let localSelf = self else { return }

            switch response {
            case .success(_):

                var messages =   localSelf.messagesResponse?.values ?? []
                messages.append(message)
                localSelf.messagesResponse?.values = messages
                localSelf.requestloadUsersCompleteHandler?()
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
                localSelf.requestloadUsersCompleteHandler?()
            case .failure(_): break

            }
        }
    }
}


        /* if let previousResult = usersResponse {
         photoService.fetchNextRecentPhotos(pagedPhotos: previousResult) { [weak self] (response) in
         guard let localSelf = self else { return }
         switch response {
         case .success(let response):
         if let response = response {
         localSelf.photosResponse = localSelf.appendData(for: previousResult, nextPhotosReponse: response)
         localSelf.requestloadPhotosCompleteHandler?()
         }
         case .failure(let error):
         localSelf.controller?.showErrorAlert(error)
         }
         }
         } else {*/
       /* usersService.getUsers(lastUserID: 0) { [weak self] (response) in
            guard let localSelf = self else { return }
            switch response {
            case .success(let response):
                localSelf.usersResponse = response
                localSelf.requestloadUsersCompleteHandler?()
            case .failure(let error): break
                //localSelf.controller?.showErrorAlert(error)
            }
        }*/
   // }


    /*  private func appendData(for previousPhotosResponse: PagedPhotos, nextPhotosReponse: PagedPhotos) -> PagedPhotos {
     var newPhotosReponse = nextPhotosReponse
     var photos = previousPhotosResponse.values
     photos.append(contentsOf: nextPhotosReponse.values)
     newPhotosReponse.values = photos
     return newPhotosReponse
*/
