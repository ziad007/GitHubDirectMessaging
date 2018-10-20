
import Foundation

let SharedAPICall = APICall()
typealias response = Result<Any?, NSError>


let baseURLString = "https://api.github.com"

protocol RequestApi {
    var path: String { get }
    var format: ResponseFormat { get }
    var akmethod: HTTPMethods { get }
    var queryString: String? { get }
}

extension RequestApi {
    var completeURLString: String {
        return "\([baseURLString, path].joined(separator: "/"))\(queryString ?? "")"
    }
}

enum ResponseFormat: String {
    case json = "json"
}

enum HTTPMethods {
    case get, post, put, patch, delete

        var description: String {
            switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .put:
                return "PUT"
            case .patch:
                return "PATCH"
            case .delete:
                return "DELETE"
            }
        }
    }


class APICall {

    func sendRequest<T: RequestApi>(
        _ API: T,
        handler: @escaping (response) -> Void)  {
        print(API.completeURLString)

        guard let url = URL(string: API.completeURLString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = API.akmethod.description

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

            if let error = error {
                DispatchQueue.main.async {
                    handler(Result.failure(error as NSError))
                }
                return
            }

            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])

                DispatchQueue.main.async {
                        handler(Result.success(json))
                    }
        }
        task.resume()
    }
}
