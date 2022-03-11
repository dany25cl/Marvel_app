//
//  Storie.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 09/03/2022.
//

import Foundation

struct StoryList: Codable {
    //The number of total available stories in this list. Will always be greater than or equal to the "returned" value.
    var available: Int?
    //The number of stories returned in this collection (up to 20).
    var returned: Int?
    //The path to the full list of stories in this collection.
    var collectionURI: String?
    //The list of returned stories in this collection
    var items: [StorySummary]
    
    class StorySummary: Codable {
        //The path to the individual story resource.
        var resourceURI: String?
        //The canonical name of the story.
        var name: String?
        //The type of the story (interior or cover).
        var type: String?
    }
}


