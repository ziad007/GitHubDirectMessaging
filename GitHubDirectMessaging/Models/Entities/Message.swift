//
//  Message.swift
//  GitHubDirectMessaging
//
//  Created by ziad Bou Ismail on 10/18/18.
//  Copyright © 2018 Ziad. All rights reserved.
//

import Foundation

class Message: NSObject, NSCoding {

    var body: String
    var isMine: Bool

    struct PropertyKey {
        static let body = "body"
        static let isMine = "isMine"
    }

    init(body: String, isMine: Bool) {
        self.body = body
        self.isMine = isMine
    }

    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(body, forKey: PropertyKey.body)
        aCoder.encode(isMine, forKey: PropertyKey.isMine)
    }

    required convenience init?(coder aDecoder: NSCoder) {

        guard let body = aDecoder.decodeObject(forKey: PropertyKey.body) as? String else {
            return nil
        }

       let isMine = aDecoder.decodeBool(forKey: PropertyKey.isMine)
        self.init(body: body, isMine: isMine)
    }
}

