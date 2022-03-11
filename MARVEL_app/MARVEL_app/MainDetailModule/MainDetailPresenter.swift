//
//  MainDetailPresenter.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 11/03/2022.
//  
//

import Foundation

class MainDetailPresenter  {
    
    // MARK: Properties
    weak var view: MainDetailViewProtocol?
    var interactor: MainDetailInteractorInputProtocol?
    var wireFrame: MainDetailWireFrameProtocol?
    
}

extension MainDetailPresenter: MainDetailPresenterProtocol {
    func viewDidLoad() {
        view?.startActivityAnimation()
        interactor?.loadCharacter()
    }
}

extension MainDetailPresenter: MainDetailInteractorOutputProtocol {
    func pushCharacter(_ data: MainDetailModel?) {
        view?.stopActivityAnimation()
        
        guard let char = data else{
            return
        }
        view?.pushCharacter(char)
    }
    
    func didReceivedError(_ error: Error) {
        view?.didReceivedError(error)
    }
}
