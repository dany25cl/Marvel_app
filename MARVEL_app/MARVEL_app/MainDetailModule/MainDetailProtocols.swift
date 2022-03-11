//
//  MainDetailProtocols.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 11/03/2022.
//  
//

import Foundation
import UIKit

protocol MainDetailViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: MainDetailPresenterProtocol? { get set }
    
    func pushCharacter(_ data: MainDetailModel)
    func didReceivedError(_ error: Error)
    func startActivityAnimation()
    func stopActivityAnimation()
}

protocol MainDetailWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createMainDetailModule(with id: Int) -> UIViewController
}

protocol MainDetailPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: MainDetailViewProtocol? { get set }
    var interactor: MainDetailInteractorInputProtocol? { get set }
    var wireFrame: MainDetailWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol MainDetailInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    
    func pushCharacter(_ data: MainDetailModel?)
    func didReceivedError(_ error: Error)
}

protocol MainDetailInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: MainDetailInteractorOutputProtocol? { get set }
    var localDatamanager: MainDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: MainDetailRemoteDataManagerInputProtocol? { get set }
    
    var id: Int? { get set}
    
    func loadCharacter()
}

protocol MainDetailDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol MainDetailRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: MainDetailRemoteDataManagerOutputProtocol? { get set }
    
    func getCharacter(id: Int)
}

protocol MainDetailRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteDatamanagerCallbackCharacter(_ data: vCharacter?)
    func didReceivedError(_ error: Error)
}

protocol MainDetailLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
