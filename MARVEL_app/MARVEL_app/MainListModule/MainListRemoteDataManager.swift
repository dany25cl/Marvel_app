//
//  MainListRemoteDataManager.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 10/03/2022.
//  
//

import Foundation
import Alamofire

class MainListRemoteDataManager:IRemoteDataManager, MainListRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: MainListRemoteDataManagerOutputProtocol?
    
    // Service for get Characters list
    func getCharacters(limit: Int, offset: Int, name: String?){
        guard let baseUrl = URL(string: self.BASE_URL) else {
          fatalError("Root URL is invalid")
        }
        
        let url = baseUrl.appendingPathComponent(MainListRemoteDataManager.EndPoints.characters)
        
        var params = self.getParams()
        params["limit"] = limit
        params["offset"] = offset
        if let nameF = name {
            params["nameStartsWith"] = nameF
        }
        
        AF.request(url, method: .get, parameters: params)
        //.validate()
        .responseData(completionHandler: { (response) in
            var result: CharacterDataWrapper? = nil
            var _error: Error? = nil
            
            if (response.response?.statusCode == 200){
                switch response.result {
                    case let .success(data):
                        do {
                            //let dateFormatter = DateFormatter()
                            //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

                            let decoder = JSONDecoder()
                            //decoder.dateDecodingStrategy = .formatted(dateFormatter)
                            
                            result = try decoder.decode(CharacterDataWrapper.self, from: data)
                            
                        } catch {
                            // error
                            _error = error
                        }
                    case let .failure(error):
                        // error
                        _error = error
                }
            }
            else{
                _error = NSError(domain: "RemoteDataManager", code: response.response?.statusCode ?? 500, userInfo: [NSLocalizedDescriptionKey : "Error en la llamaga get"])
            }
            
            self.remoteRequestHandler?.remoteDatamanagerCallbackCharacters(result)
            
            guard _error == nil else{
                self.remoteRequestHandler?.didReceivedError(_error!)
                return
            }
        })
    }    
}
