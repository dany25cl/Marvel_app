//
//  Series.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 09/03/2022.
//

import Foundation

struct SeriesList: Codable {
    //The number of total available series in this list. Will always be greater than or equal to the "returned" value.
    var available: Int?
    //The number of series returned in this collection (up to 20).
    var returned: Int?
    //The path to the full list of series in this collection.
    var collectionURI: String?
    //The list of returned series in this collection.
    var items: [SeriesSummary]
    
    struct SeriesSummary: Codable {
        //The path to the individual series resource.
        var resourceURI: String?
        //The canonical name of the series.
        var name: String?
    }
}


