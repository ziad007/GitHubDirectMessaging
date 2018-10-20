//
//  Message.swift
//  GitHubDirectMessaging
//
//  Created by ziad Bou Ismail on 10/18/18.
//  Copyright © 2018 Ziad. All rights reserved.
//

import Foundation




class Message: NSObject, NSCoding {

    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
   // static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")



    var body: String
    var isMine: Bool
    var postDate: Date

    struct PropertyKey {
        static let body = "name"
        static let isMine = "isMine"
        static let postDate = "postDate"
    }

    init(body: String, isMine: Bool, postDate: Date) {
        self.body = body
        self.isMine = isMine
        self.postDate = postDate

    }

    //MARK: NSCoding

    func encode(with aCoder: NSCoder) {
        aCoder.encode(body, forKey: PropertyKey.body)
        aCoder.encode(isMine, forKey: PropertyKey.isMine)
        aCoder.encode(postDate, forKey: PropertyKey.postDate)

    }

    required convenience init?(coder aDecoder: NSCoder) {

        guard let body = aDecoder.decodeObject(forKey: PropertyKey.body) as? String else {
            return nil
        }

       let isMine = aDecoder.decodeBool(forKey: PropertyKey.isMine)

        self.init(body: body, isMine: isMine, postDate: Date())
    }
}

