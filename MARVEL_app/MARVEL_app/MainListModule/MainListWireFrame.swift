//
//  MainListWireFrame.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 10/03/2022.
//  
//

import Foundation
import UIKit

class MainListWireFrame: MainListWireFrameProtocol {

    class func createMainListModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "MainListView")
        if let view = navController.children.first as? MainListView {
            let presenter: MainListPresenterProtocol & MainListInteractorOutputProtocol = MainListPresenter()
            let interactor: MainListInteractorInputProtocol & MainListRemoteDataManagerOutputProtocol = MainListInteractor()
            let localDataManager: MainListLocalDataManagerInputProtocol = MainListLocalDataManager()
            let remoteDataManager: MainListRemoteDataManagerInputProtocol = MainListRemoteDataManager()
            let wireFrame: MainListWireFrameProtocol = MainListWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "MainListView", bundle: Bundle.main)
    }
    
    func presentNewMainDetail(from view: MainListViewProtocol, withId: Int) {
        // Create Detail module and present it
        let detailView = MainDetailWireFrame.createMainDetailModule(with: withId)
        
        if let viewC = view as? UIViewController {
            if let nav = viewC.navigationController {
                nav.pushViewController(detailView, animated: true)
            }
            else {
                viewC.present(detailView, animated: true, completion: nil)
            }
        }
    }
    
}
