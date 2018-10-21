
import Foundation

enum ErrorCodes: Int {
    case RateLimitExceeded = 403
    case unknown

    init?(code: Int) {
        self.init(rawValue: code)
    }

    var description: String {
        switch self {

        case .RateLimitExceeded:
            return "API rate limit exceeded"
        default:
            return "Unknown Error"
        }
    }

    var error: NSError {
        return NSError(domain: description, code: self.rawValue, userInfo: nil)
    }
}
