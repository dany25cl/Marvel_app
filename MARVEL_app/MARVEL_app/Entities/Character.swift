//
//  Character.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 08/03/2022.
//

import Foundation


struct CharacterDataWrapper: Codable {
    //The HTTP status code of the returned result.
    var code: Int
    //A string description of the call status.
    var status: String
    //The copyright notice for the returned result.
    var copyright: String?
    //The attribution notice for this result. Please display either this notice or the contents of the attributionHTML field on all screens which contain data from the Marvel Comics API.
    var attributionText: String?
    //An HTML representation of the attribution notice for this result. Please display either this notice or the contents of the attributionText field on all screens which contain data from the Marvel Comics API.
    var attributionHTML: String?
    //The results returned by the call.
    var data: CharacterDataContainer
    //A digest value of the content returned by the call.
    var etag: String?
    
    struct CharacterDataContainer: Codable {
        //The requested offset (number of skipped results) of the call.
        var offset: Int
        //The requested result limit.
        var limit: Int
        //The total number of resources available given the current filter set.
        var total: Int
        //The total number of results returned by this call.
        var count: Int
        //The list of characters returned by the call.
        var results: [vCharacter]
    }
}

struct vCharacter: Codable {
    //The unique ID of the character resource.
    var id: Int
    //The name of the character.
    var name: String
    //A short bio or description of the character.
    var description: String?
    //The date the resource was most recently modified.
    //The data from server is inconsistent
    var modified: String
    var modifiedDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return dateFormatter.date(from: modified)
    }
    //The canonical URL identifier for this resource.
    var resourceURI: String
    //A set of public web site URLs for the resource.
    var urls : [vUrl]
    //The representative image for this character.
    var thumbnail: oImage
    //A resource list containing comics which feature this character.
    var comics: ComicList
    //A resource list of stories in which this character appears.
    var stories: StoryList
    //A resource list of events in which this character appears.
    var events: EventList
    //A resource list of series in which this character appears.
    var series: SeriesList
    
    struct vUrl: Codable{
        //A text identifier for the URL.
        var type: String?
        //A full URL (including scheme, domain, and path).
        var url: String?
    }
}


