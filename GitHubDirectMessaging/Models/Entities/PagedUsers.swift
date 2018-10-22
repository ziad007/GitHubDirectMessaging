
import Foundation

struct PagedUsers {
    var values = [User]()

    var lastUserSeenUserID: Int {
        return values.last?.id ?? 0
    }

    init(usersDictionaries: [NSDictionary]) {
        self.values = usersDictionaries.compactMap { userDictionary in
            guard let user = User(json: userDictionary) else { return nil }
            return user
        }
    }
}
