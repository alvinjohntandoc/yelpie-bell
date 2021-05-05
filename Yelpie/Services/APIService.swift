//
//  APIService.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import Foundation
import Moya

enum SearchAPI {
    case search(input: SearchInput)
    case businessDetails(alias: String)
    case reviews(alias: String)
}

extension SearchAPI: TargetType {
    
    enum Constants {
        static let token = "_RkFAITVVDcgpPlZiMqAhc7d_APlN70R8BQSH-VVZt7Z00osXm2G1kweVvM_P78GtLcuhDeyUBQGGb57-utS4ge20L3tcLwcz3UajHZ0zj4yoV0XCdrb1wuKOPSQYHYx"
    }
    
    var baseURL: URL {
        return URL(string: "https://api.yelp.com/v3/")!
    }
    
    var path: String {
        switch self {
        case .search:
            return "businesses/search"
        case .businessDetails(let alias):
            return "businesses/\(alias)"
        case .reviews(let alias):
            return "businesses/\(alias)/reviews"
        }
    }
    
    var method: Moya.Method {
        return Method.get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .search(let input):
            return input.asParameters(encoding: URLEncoding.queryString)
        case .businessDetails,
             .reviews:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        let headers = ["Authorization": String(format: "Bearer %@", Constants.token)]
        return headers
    }
    
}

struct SearchAPIService {
    
    /// A simple api request helper to avoid redundancy of code
    /// Will return a cancellable protocol that we can cancel anytime
    /// Cancelling the cancellable will terminte the api request
    ///
    /// - Parameters:
    ///     - endpoint: Moya service endpoint
    ///     - target: Response data type
    ///     - completion: blocks that returns your target into a concrete object
    @discardableResult
    func request<T: Decodable>(_ endpoint: SearchAPI, target: T.Type, completion: ((T) -> Void)?) -> Cancellable {
        let provider = MoyaProvider<SearchAPI>()
        
        return provider.request(endpoint) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let decoder = JSONDecoder()
                
                do {
                    let decoded = try decoder.decode(T.self, from: data)
                    completion?(decoded)
                } catch let error {
                    debugPrint(error)
                }
                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
}
