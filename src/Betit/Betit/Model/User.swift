//
//  User.swift
//  Betit
//
//  Created by Miroslav Čapkovič on 06/08/2017.
//  Copyright © 2017 Miros. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

/**
User mappable. It represents user object. Should be saved to prefs, after sign in, sing up.
 */

//This is just an asumption of possible user object returning from server in json
class User: UniversalMappable {
    var userId: String?
    var email: String?
    var accessToken: String?
    var name: String?
    
    //this constructor is only for mocking
    override init() {
        super.init()
    }
    
    // MARK: Mapping
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        userId <- map["id"]
        email <- map["email"]
        accessToken <- map["access_token"]
        name <- map["name"]
    }
    
    // MARK: NSCoding
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        userId = decoder.decodeObject(forKey: "userId") as? String
        email = decoder.decodeObject(forKey: "email") as? String
        name = decoder.decodeObject(forKey: "name") as? String
    }
    
    override func encode(with coder: NSCoder) {
        super.encode(with: coder)
        coder.encode(self.userId, forKey: "userId")
        coder.encode(self.email, forKey: "email")
        coder.encode(self.name, forKey: "name")
    }
}
