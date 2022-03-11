//
//  MainListProtocols.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 10/03/2022.
//  
//

import Foundation
import UIKit

protocol MainListViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: MainListPresenterProtocol? { get set }
    
    func loadCharacters(_ data: [MainListModel], actualPage: Int, totalPages: Int)
    func didReceivedError(_ error: Error)
    func startActivityAnimation()
    func stopActivityAnimation()
}

protocol MainListWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createMainListModule() -> UIViewController
    
    func presentNewMainDetail(from view: MainListViewProtocol, withId: Int)
}

protocol MainListPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: MainListViewProtocol? { get set }
    var interactor: MainListInteractorInputProtocol? { get set }
    var wireFrame: MainListWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func reloadData(page: Int, name: String?)
    func presentDetailView(with id: Int)
}

protocol MainListInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func loadCharacters(_ data: [MainListModel], actualPage: Int, totalPages: Int)
    func didReceivedError(_ error: Error)
}

protocol MainListInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: MainListInteractorOutputProtocol? { get set }
    var localDatamanager: MainListLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: MainListRemoteDataManagerInputProtocol? { get set }
    
    func getCharacters(page: Int, name: String?)
}

protocol MainListDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol MainListRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: MainListRemoteDataManagerOutputProtocol? { get set }
    
    func getCharacters(limit: Int, offset: Int, name: String?)
}

protocol MainListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteDatamanagerCallbackCharacters(_ data: CharacterDataWrapper?)
    func didReceivedError(_ error: Error)
}

protocol MainListLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
