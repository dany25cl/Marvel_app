//
//  ExternalDataManager.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 10/03/2022.
//

import Foundation

class IRemoteDataManager {
    // Propiedades
    internal let BASE_URL = "https://gateway.marvel.com"
    internal struct EndPoints {
        private static var api: String { return "v1/public" }
        static var characters: String { return "\(api)/characters"}
    }
    
    internal func getParams() -> [String: Any]{
        guard let apiKey = Bundle.main.infoDictionary?["MARVEL_API_KEY"] as? String else {
          fatalError("MARVEL_API_KEY Not defined in info.plist")
        }
        guard let privateKey = Bundle.main.infoDictionary?["MARVEL_PRIVATE_KEY"] as? String else {
          fatalError("MARVEL_PRIVATE_KEY Not defined in info.plist")
        }
        
        let df = DateFormatter();
        df.dateFormat = "yyyyMMdd"
        
        let params = [
            "ts": df.string(from: Date()),
            "apikey": apiKey,
            "hash": Utils.MD5(string: df.string(from: Date())+privateKey+apiKey)
        ]
        
        return params
    }
}
