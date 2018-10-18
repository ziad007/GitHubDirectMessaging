
import Foundation

final class UsersApi {
    struct GetUsers: RequestApi {
        let path = "users"
        let format: ResponseFormat = .json
        let akmethod: HTTPMethods = .get
        let lastUserID: Int
        var queryString: String? {
            return "?since=\(lastUserID)"
        }
    }
}
