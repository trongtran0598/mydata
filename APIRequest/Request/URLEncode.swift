//
//  URLEncode.swift
//  apiTool
//
//  Created by TrongTran on 6/21/20.
//  Copyright © 2020 TrongTran. All rights reserved.
//

import Foundation
public typealias Parameters = [String: String]


public struct URLEncode {
    

    
    public func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        switch value {
        case let dictionary as [String: Any]:
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        default:
            components.append((escape(key), escape("\(value)")))
        }
        return components
    }
    
    
    
    public func escape(_ string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed)! 
    }
    
    
    public func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
}


public extension CharacterSet {
    
    static let afURLQueryAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        let encodableDelimiters = CharacterSet(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return CharacterSet.urlQueryAllowed.subtracting(encodableDelimiters)
    }()
}
