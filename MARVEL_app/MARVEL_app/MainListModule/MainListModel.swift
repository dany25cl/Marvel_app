//
//  MainListModel.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 10/03/2022.
//

import Foundation

struct MainListModel {
    
    var id: Int
    var name: String
    var img: oImage?
    var imgPath: String {
        if let imgA = img {
            return (imgA.path ?? "") + "/standard_small" + "."+(imgA.ext ?? "")
        }
        return ""
    }
    
    init(from entity: vCharacter){
        self.name = entity.name;
        self.id = entity.id
        self.img = entity.thumbnail;
    }
}
