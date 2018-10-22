//
//  PagesMessages.swift
//  GitHubDirectMessaging
//
//  Created by ziad Bou Ismail on 10/18/18.
//  Copyright © 2018 Ziad. All rights reserved.
//

import Foundation

class PagedMessages: NSObject, NSCoding {
    var values: [Message]?

    init(values: [Message]) {
        self.values = values
    }
    struct PropertyKey {
        static let values = "values"
    }

    //MARK: NSCoding

    func encode(with aCoder: NSCoder) {
        aCoder.encode(values, forKey: PropertyKey.values)
    }

    required convenience init?(coder aDecoder: NSCoder) {

        guard let values = aDecoder.decodeObject(forKey: PropertyKey.values) as? [Message] else {
            return nil
        }
        self.init(values: values)
    }
}
