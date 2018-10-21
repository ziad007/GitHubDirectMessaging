//
//  PhotoInteractor.swift
//  Photos
//
//  Created by ziad Bou Ismail on 9/30/18.
//  Copyright © 2018 ziad Bou Ismail. All rights reserved.
//

import Foundation

protocol UsersListInteractorInputs {
    func fetchUsers()
}

protocol UsersListInteractorOutputs {
    var usersResponse: PagedUsers? { get }
}

final class UsersListInteractor: UsersListInteractorInputs, UsersListInteractorOutputs {
    var usersService: UserServiceProtocol
    weak var controller: UserListViewController?
    var usersResponse: PagedUsers?
    var needToFetchNext: Bool = true
    var requestloadUsersCompleteHandler: (() -> Void)?

    var numberOfItems: Int {
        return usersResponse?.values.count ?? 0
    }


    init() {
        usersService = UsersService()
    }

    func fetchUsers() {
        if let previousResult = usersResponse {
            usersService.fetchNextUsers(pagedUsers: previousResult) { [weak self] (response) in
                guard let localSelf = self else { return }
                switch response {
                case .success(let response):
                    if let response = response {
                        localSelf.usersResponse = response
                        localSelf.requestloadUsersCompleteHandler?()
                    }
                case .failure(let error):
                 localSelf.controller?.showErrorAlert(message: error.description)
                }
            }
        } else {
            usersService.getUsers(lastUserID: 0) { [weak self] (response) in
                guard let localSelf = self else { return }
                switch response {
                case .success(let response):
                    localSelf.usersResponse = response
                    localSelf.requestloadUsersCompleteHandler?()
                case .failure(let error):
                    localSelf.controller?.showErrorAlert(message: error.description)
                }
            }
        }
    }
}
