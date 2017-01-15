//
//  API.swift
//  UFCDataAPI
//
//  Created by Marcelo Reina on 11/01/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation
import Moya

public enum UFCAPIError: Swift.Error {
    case unknownError
    case httpError
    case requestFailureError
    case invalidJSONObject
    case invalidJSONMapping
}

public enum UFCAPIResult<T> {
    case success(object: T)
    case failure(error: UFCAPIError)
}


enum UFCAPI {
    case events
}


// MARK: - Target Type protocol implementation
extension UFCAPI: TargetType {
    
    var accessDevice: String { return "iphone" }
    var version:String { return "v3" }
    var baseURL: URL {
        return URL(string: "http://ufc-data-api.ufc.com/api/\(version)/\(accessDevice)")!
    }
    
    var path: String {
        switch self {
        case .events:
            return "/events"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .events:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .events:
            return nil
        }
    }
    
    var sampleData: Data {
        return Data()
    }

    var task:Task {
        switch self {
        case .events:
            return .request
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding() //All requests are GET
    }
}
