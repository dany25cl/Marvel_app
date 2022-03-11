//
//  MainListPresenter.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 10/03/2022.
//  
//

import Foundation

class MainListPresenter  {
    
    // MARK: Properties
    weak var view: MainListViewProtocol?
    var interactor: MainListInteractorInputProtocol?
    var wireFrame: MainListWireFrameProtocol?
    
}

extension MainListPresenter: MainListPresenterProtocol {
    
    func viewDidLoad() {
        
    }
    
    // Get characters from server
    func reloadData(page: Int, name: String?) {
        view?.startActivityAnimation()
        interactor?.getCharacters(page: page, name: name)
    }
    
    func presentDetailView(with id: Int) {
        wireFrame?.presentNewMainDetail(from: view!, withId: id)
    }
}

extension MainListPresenter: MainListInteractorOutputProtocol {
    func didReceivedError(_ error: Error) {
        view?.didReceivedError(error)
    }    
    
    func loadCharacters(_ data: [MainListModel], actualPage: Int, totalPages: Int) {
        view?.stopActivityAnimation()
        view?.loadCharacters(data, actualPage: actualPage, totalPages: totalPages)
    }
}
