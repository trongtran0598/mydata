//
//  User.swift
//  APIRequest
//
//  Created by admin on 6/22/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation


struct User : Decodable {
    let userId : Int
    let id : Int
    let title : String
    let body : String
    
    init(_ dictionary: [String: Any]) {
        self.userId = dictionary["userId"] as? Int ?? 0
        self.id = dictionary["id"] as? Int ?? 0
        self.title = dictionary["title"] as? String ?? "nil"
        self.body = dictionary["body"] as? String ?? "nil"
    }
}
