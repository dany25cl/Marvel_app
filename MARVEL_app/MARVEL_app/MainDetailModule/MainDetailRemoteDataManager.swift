//
//  MainDetailRemoteDataManager.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 11/03/2022.
//  
//

import Foundation
import Alamofire

class MainDetailRemoteDataManager:IRemoteDataManager, MainDetailRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: MainDetailRemoteDataManagerOutputProtocol?
    
    func getCharacter(id: Int){
        guard let baseUrl = URL(string: self.BASE_URL) else {
          fatalError("Root URL is invalid")
        }
        
        let url = baseUrl.appendingPathComponent(MainListRemoteDataManager.EndPoints.characters)
            .appendingPathComponent(String(id));
                
        AF.request(url, method: .get, parameters: self.getParams()
        )
        //.validate()
        .responseData(completionHandler: { (response) in
            var result: vCharacter?
            var _error: Error? = nil
            
            if (response.response?.statusCode == 200){
                switch response.result {
                    case let .success(data):
                        do {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

                            let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .formatted(dateFormatter)
                            
                            let wrapper = try decoder.decode(CharacterDataWrapper.self, from: data)
                            // success
                            if (wrapper.data.results.count > 0) {
                                result = wrapper.data.results[0];
                            }
                        } catch {
                            // error
                            _error = error
                        }
                    case let .failure(error):
                        // error
                        _error = error
                }
            }
            
            self.remoteRequestHandler?.remoteDatamanagerCallbackCharacter(result)
            
            guard _error == nil else{
                self.remoteRequestHandler?.didReceivedError(_error!)
                return
            }
        })
    }
    
}
