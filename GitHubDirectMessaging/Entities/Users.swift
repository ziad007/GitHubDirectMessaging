
import Foundation

struct User {

    var id: Int?
    var login: String?
    var avatarUrl: String?
    var type: String?
    var url: String?
}

extension User {
    init?(json: NSDictionary) {
        guard let id = json["id"] as? Int, let login = json["login"] as? String else { return nil }

        self.id = id
        self.login = login

        if let avatarUrl = json["avatar_url"] as? String {
            self.avatarUrl = avatarUrl
        }

        if let url = json["url"] as? String {
            self.url = url
        }

        if let type = json["type"] as? String {
            self.type = type
        }
    }
}
