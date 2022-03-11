//
//  MainDetailWireFrame.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 11/03/2022.
//  
//

import Foundation
import UIKit

class MainDetailWireFrame: MainDetailWireFrameProtocol {

    class func createMainDetailModule(with id: Int) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MainDetailView")
        if let view = viewController as? MainDetailView {
            let presenter: MainDetailPresenterProtocol & MainDetailInteractorOutputProtocol = MainDetailPresenter()
            let interactor: MainDetailInteractorInputProtocol & MainDetailRemoteDataManagerOutputProtocol = MainDetailInteractor()
            let localDataManager: MainDetailLocalDataManagerInputProtocol = MainDetailLocalDataManager()
            let remoteDataManager: MainDetailRemoteDataManagerInputProtocol = MainDetailRemoteDataManager()
            let wireFrame: MainDetailWireFrameProtocol = MainDetailWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            interactor.id = id
            remoteDataManager.remoteRequestHandler = interactor
            
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "MainDetailView", bundle: Bundle.main)
    }
    
}
