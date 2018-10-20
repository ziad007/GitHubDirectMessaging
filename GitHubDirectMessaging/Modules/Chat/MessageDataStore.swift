//
//  DataStore.swift
//  GitHubDirectMessaging
//
//  Created by ziad Bou Ismail on 10/20/18.
//  Copyright © 2018 Ziad. All rights reserved.
//

import Foundation

class MessageDataStore {
    static let shared = MessageDataStore()

     func getMessages(for dialogID: String) -> [Message] {
        var messages = [Message]()
        if let data =  UserDefaults.standard.data(forKey: dialogID){
            do {
                if let messagesDecoded = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Message] {
                   messages = messagesDecoded
                }
            } catch {}
            return messages
        } else { return messages }
    }

    func saveMessage(for dialogID: String, message: Message) -> Bool {
         var messages = getMessages(for: dialogID)
            messages.append(message)

            do {
                let messagesData = try NSKeyedArchiver.archivedData(withRootObject: messages, requiringSecureCoding: false)
                UserDefaults.standard.set(messagesData, forKey: dialogID)
                UserDefaults.standard.synchronize()
                return true
            } catch { return false }
        }
    }
