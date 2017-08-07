//
//  UniversalMappable.swift
//  Betit
//
//  Created by Miroslav Čapkovič on 06/08/2017.
//  Copyright © 2017 Miros. All rights reserved.
//

import ObjectMapper
import AlamofireObjectMapper

/**
 Universal mappable. Parent for all mappable objects. These properties would be common for all mappable objects.
 */
class UniversalMappable: NSObject, Mappable, NSCoding {
    var success: Bool?
    var message: String?
    
    //this constructor is only for mocking
    override init() {
        super.init()
    }
    
    // MARK: Mapping
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
    }
    
    // MARK: NSCoding
    required init?(coder decoder: NSCoder) {
        
    }
    
    func encode(with coder: NSCoder) {
        
    }
}
