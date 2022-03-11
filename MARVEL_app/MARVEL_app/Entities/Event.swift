//
//  Event.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 09/03/2022.
//

import Foundation

struct EventList: Codable {
    //The number of total available events in this list. Will always be greater than or equal to the "returned" value.
    var available: Int?
    //The number of events returned in this collection (up to 20).
    var returned: Int?
    //The path to the full list of events in this collection.
    var collectionURI: String?
    //The list of returned events in this collection.
    var items: [EventSummary]
    
    struct EventSummary: Codable {
        //The path to the individual event resource.
        var resourceURI: String?
        //The name of the event.
        var name: String?
    }
}


