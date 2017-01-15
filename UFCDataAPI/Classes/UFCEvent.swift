//
//  UFCEvent.swift
//  UFCDataAPI
//
//  Created by Marcelo Reina on 11/01/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation
import ObjectMapper

public struct UFCEvent {
    var id: Int64?
    var eventDate: Date?
    var secondaryFeatureImage: String?
    var ticketImage: String?
    var eventTimeZoneText: String?
    var shortDescription: String?
    var eventDategmt: Date?
    var endEventDategmt: Date?
    var ticketURL: String?
    var ticketSellerName: String?
    var baseTitle: String?
    var titleTagLine: String?
    var twitterHashtag: String?
    var ticketGeneralSaleDate: String?
    var statid: Int64?
    var featureImage: String?
    var eventTimeText: String?
    var ticketGeneralSaleText: String?
    var subtitle: String?
    var eventStatus: String?
    var isPPVEvent: Bool?
    var cornerAudioAvailable: Bool?
    var cornerAudioBlueStreamURL: String?
    var cornerAudioRedStreamURL: String?
    var lastModified: Date?
    var urlName: String?
    var created: Date?
    var trailerURL: String?
    var arena: String?
    var location: String?
    var fmFntFeedURL: String?
    var mainEventFighter1Id: Int64?
    var mainEventFighter2Id: Int64?
    var latitude: Double?
    var longitude: Double?
}

extension UFCEvent: Mappable {
    public init?(map: Map) {}
    
    mutating public func mapping(map: Map) {
        id <- map["id"]
        secondaryFeatureImage <- map["secondary_feature_image"]
        ticketImage <- map["ticket_image"]
        eventTimeZoneText <- map["event_time_zone_text"]
        shortDescription <- map["short_description"]
        ticketURL <- map["ticketurl"]
        ticketSellerName <- map["ticket_seller_name"]
        baseTitle <- map["base_title"]
        titleTagLine <- map["title_tag_line"]
        twitterHashtag <- map["twitter_hashtag"]
        ticketGeneralSaleDate <- map["ticket_general_sale_date"]
        statid <- map["statid"]
        featureImage <- map["feature_image"]
        eventTimeText <- map["event_time_text"]
        ticketGeneralSaleText <- map["ticket_general_sale_text"]
        subtitle <- map["subtitle"]
        eventStatus <- map["event_status"]
        isPPVEvent <- map["isppvevent"]
        cornerAudioAvailable <- map["corner_audio_available"]
        cornerAudioBlueStreamURL <- map["corner_audio_blue_stream_url"]
        cornerAudioRedStreamURL <- map["corner_audio_red_stream_url"]
        urlName <- map["url_name"]
        trailerURL <- map["trailer_url"]
        arena <- map["arena"]
        location <- map["location"]
        fmFntFeedURL <- map["fm_fnt_feed_url"]
        mainEventFighter1Id <- map["main_event_fighter1_id"]
        mainEventFighter2Id <- map["main_event_fighter2_id"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        
        // convert string from json to Date object (closure)
        let transform = TransformOf<Date, String>(fromJSON: { (value: String?) -> Date? in
            return Date.makeDate(from: value)
        }, toJSON: { (value: Date?) -> String? in
            if let value = value {
                return Date.makeString(from: value, dateStyle: .short)
            }
            return nil
        })
        // custom map using transform closure
        eventDate <- (map["event_date"], transform)
        eventDategmt <- (map["event_dategmt"], transform)
        endEventDategmt <- (map["end_event_dategmt"], transform)
        lastModified <- (map["last_modified"], transform)
        created <- (map["created"], transform)
    }
}

extension UFCEvent {
    static func makeUFCEvents(from jsonArray: [[String: Any]]) -> [UFCEvent]? {
        return Mapper<UFCEvent>().mapArray(JSONArray: jsonArray)
    }
}
