//
//  Comic.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 08/03/2022.
//

import Foundation


struct ComicList: Codable {
    // The number of total available issues in this list. Will always be greater than or equal to the "returned" value.
    var available: Int?
    //The number of issues returned in this collection (up to 20).
    var returned: Int?
    //The path to the full list of issues in this collection.
    var collectionURI: String?
    //The list of returned issues in this collection.
    var items: [ComicSummary]
    
    class ComicSummary: Codable {
        //The path to the individual comic resource.
        var resourceURI: String?
        //The canonical name of the comic
        var name: String?
    }
}


