//
//  UFCNewsService.swift
//  Pods
//
//  Created by Marcelo Reina on 15/01/17.
//
//

import Foundation
import Moya


public class UFCNewsService {
    public static func getUFCNews(completion: @escaping (UFCAPIResult<[UFCNews]>) -> Void) {
        let provider = MoyaProvider<UFCAPI>()
        provider.request(.news) { result in
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
                
                let events = UFCNews.makeUFCNews(from: array!)
                guard events != nil else {
                    completion(.failure(error: .invalidJSONMapping))
                    return
                }
                
                completion(.success(object: events!))
                
            case let .failure(_):
                completion(.failure(error: .requestFailureError))
            }
        }
    }
}
