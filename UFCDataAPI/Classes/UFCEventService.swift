//
//  EventsService.swift
//  UFCDataAPI
//
//  Created by Marcelo Reina on 11/01/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation
import Moya

public enum UFCAPIError: Swift.Error {
    case unknownError
}

public enum UFCAPIResult<T> {
    case success(object: T)
    case failure(error: UFCAPIError)
}

public class UFCEventService {
    
    
    /// Asynch request to get all UFC events.
    ///
    /// - Parameter completion: completion handler that uses `UFCAPIResult` in order to bring `[UFCEvent]` as success or a `UFCAPIError` as a failure.
    public static func getAllUFCEvents(completion: @escaping (UFCAPIResult<[UFCEvent]>) -> Void) {
        let provider = MoyaProvider<UFCAPI>()
        provider.request(.events) { result in
            switch result {
            case let .success(moyaResponse):
                //                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                guard statusCode == 200 else {
                    completion(.failure(error: .unknownError))
                    return
                }
                
                let jsonData = try? moyaResponse.mapJSON()
                guard jsonData != nil else {
                    completion(.failure(error: .unknownError))
                    return
                }
                
                let array = jsonData as? [[String: Any]]
                guard array != nil else {
                    completion(.failure(error: .unknownError))
                    return
                }
                
                let events = UFCEvent.makeUFCEvents(from: array!)
                guard events != nil else {
                    completion(.failure(error: .unknownError))
                    return
                }

                //TODO: Map and return
                completion(.success(object: events!))
                
            // do something in your app
            case let .failure(error):
                completion(.failure(error: .unknownError))
            }
        }

    }
    
}
