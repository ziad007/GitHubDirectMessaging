
import Foundation

typealias UsersResponse = (Result<PagedUsers?, NSError>) -> Void

protocol UserServiceProtocol {
    func getUsers(lastUserID: Int, completionHandler: @escaping UsersResponse)
    func fetchNextUsers(pagedUsers: PagedUsers, completionHandler: @escaping UsersResponse)
}


final class UserService: UserServiceProtocol {

    let apiCall: APICall

    init(apiCall: APICall = APICall()) {
        self.apiCall = apiCall
    }

    func getUsers(lastUserID: Int, completionHandler: @escaping UsersResponse) {
        let api = UsersApi.GetUsers(lastUserID: lastUserID)
        self.apiCall.sendRequest(api) { response in
            switch(response) {
            case .success(let result):
                guard let usersContainer = result as? [NSDictionary] else { return }
                let pagedUsers = PagedUsers(usersDictionaries: usersContainer)
                completionHandler(Result.success(pagedUsers))
            case .failure(let error):
                completionHandler(Result.failure(error as NSError))
            }
        }
    }

    func fetchNextUsers(pagedUsers: PagedUsers, completionHandler: @escaping UsersResponse) {
        getUsers(lastUserID: pagedUsers.lastUserSeenUserID) { response in
            switch(response) {
            case .success(let response):
                if let response = response {
                    var mutable = pagedUsers
                    mutable.values.append(contentsOf: response.values)
                    completionHandler(Result.success(mutable))
                }
            case .failure(let error):
                completionHandler(Result.failure(error as NSError))
            }
        }
    }
}
