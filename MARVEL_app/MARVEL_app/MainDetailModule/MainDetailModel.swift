//
//  MainDetailModel.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 11/03/2022.
//

import Foundation

struct MainDetailModel {
    var name: String
    var description: String?
    var img: oImage?
    var imgPath: String {
        if let imgA = img {
            return (imgA.path ?? "") + "/portrait_incredible" + "."+(imgA.ext ?? "")
        }
        return ""
    }
    
    init(from entity: vCharacter){
        self.name = entity.name;
        self.description = entity.description
        self.img = entity.thumbnail;
    }
}
