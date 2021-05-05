//
//  Codable+Dictionary.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import Foundation
import Moya

extension Encodable {
    
    var asParameters: Task {
        guard let parameters = try? toDictionary() else { return .requestPlain }
        return .requestParameters(parameters: parameters,
                                  encoding: JSONEncoding.default)
    }
    
    func asParameters(encoding: ParameterEncoding) -> Task {
        guard let parameters = try? toDictionary() else { return .requestPlain }
        return .requestParameters(parameters: parameters,
                                  encoding: encoding)
    }
    
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(self)
        let object = try JSONSerialization.jsonObject(with: data)
        guard let json = object as? [String: Any] else {
            let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
            throw DecodingError.typeMismatch(type(of: object), context)
        }
        return json
    }
}
