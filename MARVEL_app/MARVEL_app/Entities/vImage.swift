//
//  vImage.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 08/03/2022.
//

import Foundation

struct oImage: Codable {
    //The directory path of to the image.
    var path : String?
    //The file extension for the image.
    var ext : String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
