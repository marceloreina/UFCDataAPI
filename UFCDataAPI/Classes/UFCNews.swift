//
//  UFCNews.swift
//  Pods
//
//  Created by Marcelo Reina on 15/01/17.
//
//

import Foundation
import ObjectMapper

public struct UFCNews {
    var id: Int64?
    var externalURLText: String?
    var author: String?
    var title: String?
    var articleMediaId: Int64?
    var articleDate: Date?
    var thumbnail: String?
    var externalURL: String?
    var introduction: String?
    var articleFighterId: Int64?
    var featuredNewsCategory: String?
    var lastModified: Date?
    var urlName: String?
    var created: Date?
    var keywordIds: [Int64]?
    var publishedStartDate: Date?
}

extension UFCNews: Mappable {
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        id <- map["id"]
        externalURLText <- map["external_url_text"]
        author <- map["author"]
        title <- map["title"]
        articleMediaId <- map["article_media_id"]
        thumbnail <- map["thumbnail"]
        externalURL <- map["external_url"]
        introduction <- map["introduction"]
        articleFighterId <- map["article_fighter_id"]
        featuredNewsCategory <- map["featured_news_category"]
        urlName <- map["url_name"]
        keywordIds <- map["keyword_ids"]
        
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
        articleDate <- (map["article_date"], transform)
        lastModified <- (map["last_modified"], transform)
        created <- (map["created"], transform)
        publishedStartDate <- (map["published_start_date"], transform)
    }
}

extension UFCNews {
    static func makeUFCNews(from jsonArray: [[String: Any]]) -> [UFCNews]? {
        return Mapper<UFCNews>().mapArray(JSONArray: jsonArray)
    }
}
