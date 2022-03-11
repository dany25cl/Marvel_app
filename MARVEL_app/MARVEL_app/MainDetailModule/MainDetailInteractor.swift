//
//  MainDetailInteractor.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 11/03/2022.
//  
//

import Foundation

class MainDetailInteractor: MainDetailInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: MainDetailInteractorOutputProtocol?
    var localDatamanager: MainDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: MainDetailRemoteDataManagerInputProtocol?
    
    var id: Int?
    
    func loadCharacter() {
        remoteDatamanager?.getCharacter(id: id ?? 0)
    }
}

extension MainDetailInteractor: MainDetailRemoteDataManagerOutputProtocol {
    func remoteDatamanagerCallbackCharacter(_ data: vCharacter?) {
        var result : MainDetailModel? = nil
        
        if let char = data {
            result = MainDetailModel.init(from: char)
        }
        
        presenter?.pushCharacter(result)
    }
    
    func didReceivedError(_ error: Error) {
        presenter?.didReceivedError(error)
    }
}
