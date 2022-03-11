//
//  MainListInteractor.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 10/03/2022.
//  
//

import Foundation

class MainListInteractor: MainListInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: MainListInteractorOutputProtocol?
    var localDatamanager: MainListLocalDataManagerInputProtocol?
    var remoteDatamanager: MainListRemoteDataManagerInputProtocol?
    let pageElements: Int = 25
    
    func getCharacters(page: Int, name: String?) {
        let offset = pageElements * (page - 1)
        remoteDatamanager?.getCharacters(limit: pageElements, offset: offset, name: name)
    }
}

extension MainListInteractor: MainListRemoteDataManagerOutputProtocol {
    
    func remoteDatamanagerCallbackCharacters(_ data: CharacterDataWrapper?) {
        // Parse total data to view model
        var result: [MainListModel] = []
        var actualPage = 1
        var totalPages = 1
        
        if let wrap = data {
            result = wrap.data.results.map { (char) -> MainListModel in
                return MainListModel.init(from: char)
            }
            
            actualPage = max((wrap.data.offset / wrap.data.limit)+1, 1)
            totalPages = Int(ceil(Double(wrap.data.total) / Double(wrap.data.limit)))
        }
        
        presenter?.loadCharacters(result, actualPage: actualPage, totalPages: totalPages)
    }
    
    func didReceivedError(_ error: Error) {
        presenter?.didReceivedError(error)
    }
}
