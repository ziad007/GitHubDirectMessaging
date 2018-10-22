
import Foundation

typealias ChatResponse = (Result<PagedMessages?, NSError>) -> Void
typealias ChatSaveResponse = (Result<Bool, NSError>) -> Void

protocol ChatServiceProtocol {
    func getMessages(completionHandler: @escaping ChatResponse)
    func saveMessage(message: Message, completionHandler: @escaping ChatSaveResponse)
}

final class ChatService: ChatServiceProtocol {

    let apiCall: APICall
    let returnBackMessageDuration: TimeInterval = 1
    private let dialogID: String

    init(dialogID: String, apiCall: APICall = APICall()) {
        self.apiCall = apiCall
        self.dialogID = dialogID
    }

    func getMessages(completionHandler: @escaping ChatResponse) {
        let messages =  MessageDataStore.shared.getMessages(for: dialogID)
        let pagedMessages = PagedMessages(values: messages)
        completionHandler(Result.success(pagedMessages))
    }

    func saveMessage(message: Message, completionHandler: @escaping ChatSaveResponse) {
        let isSaved = MessageDataStore.shared.saveMessage(for: dialogID, message: message)
        completionHandler(Result.success(isSaved))

        if message.isMine {
            DispatchQueue.main.asyncAfter(deadline: .now() + returnBackMessageDuration, execute: {
                self.receiveRepeatedMessage(message: message)
            })

        }
    }

    private func receiveRepeatedMessage(message: Message) {
        let receivedMessageBody = message.body + " " + message.body
        let receivedMessage = Message(body: receivedMessageBody, isMine: false)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didReceiveData"), object: receivedMessage)
    }
}
