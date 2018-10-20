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
    var requestloadUsersCompleteHandler: (() -> Void)?

    var numberOfItems: Int {
        return usersResponse?.values.count ?? 0
    }

    init() {
        usersService = UserService()
    }

    func fetchUsers() {
       /* if let previousResult = usersResponse {
            photoService.fetchNextRecentPhotos(pagedPhotos: previousResult) { [weak self] (response) in
                guard let localSelf = self else { return }
                switch response {
                case .success(let response):
                    if let response = response {
                        localSelf.photosResponse = localSelf.appendData(for: previousResult, nextPhotosReponse: response)
                        localSelf.requestloadPhotosCompleteHandler?()
                    }
                case .failure(let error):
                    localSelf.controller?.showErrorAlert(error)
                }
            }
        } else {*/
            usersService.getUsers(lastUserID: 0) { [weak self] (response) in
                guard let localSelf = self else { return }
                switch response {
                case .success(let response):
                    localSelf.usersResponse = response
                    localSelf.requestloadUsersCompleteHandler?()
                case .failure(let error): break
                    //localSelf.controller?.showErrorAlert(error)
                }
            }
        }


  /*  private func appendData(for previousPhotosResponse: PagedPhotos, nextPhotosReponse: PagedPhotos) -> PagedPhotos {
        var newPhotosReponse = nextPhotosReponse
        var photos = previousPhotosResponse.values
        photos.append(contentsOf: nextPhotosReponse.values)
        newPhotosReponse.values = photos
        return newPhotosReponse
    }*/
}
