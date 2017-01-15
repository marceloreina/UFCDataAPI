//
//  EventsService.swift
//  UFCDataAPI
//
//  Created by Marcelo Reina on 11/01/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation
import Moya



public class UFCEventService {
    
    
    /// Asynch request to get all UFC events.
    ///
    /// - Parameter completion: completion handler that uses `UFCAPIResult` in order to bring `[UFCEvent]` as success or a `UFCAPIError` as a failure.
    public static func getAllUFCEvents(completion: @escaping (UFCAPIResult<[UFCEvent]>) -> Void) {
        let provider = MoyaProvider<UFCAPI>()
        provider.request(.events) { result in
            switch result {
            case let .success(moyaResponse):

                let statusCode = moyaResponse.statusCode
                guard statusCode == 200 else {
                    completion(.failure(error: .httpError))
                    return
                }
                
                let jsonData = try? moyaResponse.mapJSON()
                guard jsonData != nil else {
                    completion(.failure(error: .invalidJSONObject))
                    return
                }
                
                let array = jsonData as? [[String: Any]]
                guard array != nil else {
                    completion(.failure(error: .unknownError))
                    return
                }
                
                let events = UFCEvent.makeUFCEvents(from: array!)
                guard events != nil else {
                    completion(.failure(error: .invalidJSONMapping))
                    return
                }

                completion(.success(object: events!))
                
            // do something in your app
            case let .failure(_):
                completion(.failure(error: .requestFailureError))
            }
        }

    }
    
}
