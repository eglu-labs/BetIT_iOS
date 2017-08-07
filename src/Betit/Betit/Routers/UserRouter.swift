//
//  UserRouter.swift
//  Betit
//
//  Created by Miroslav Čapkovič on 06/08/2017.
//  Copyright © 2017 Miros. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

/**
Enum for alamofire requests, related to user.
 */
enum UserRouter: URLRequestConvertible {
    static let baseURLEndPoint = URLs.BASE_URL + "/user"
    
    case signinRequest(String, String)
    case signupRequest(String, String)
    case forgotPasswordRequest(String)
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .signinRequest, .signupRequest, .forgotPasswordRequest:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .signinRequest(_, _):
            return "/login"
        case .signupRequest(_, _):
            return "/register"
        case .forgotPasswordRequest(_):
            return "/forgotPassword"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlString = URL(string: UserRouter.baseURLEndPoint)!
        var mutableURLRequest = URLRequest(url: urlString.appendingPathComponent(path))
        mutableURLRequest.httpMethod = method.rawValue
        
        switch self {
        case .signinRequest(let email, let password), .signupRequest(let email, let password):
            return try Alamofire.JSONEncoding.default.encode(mutableURLRequest, with: ["email": email, "password": password])
        case .forgotPasswordRequest(let email):
            return try Alamofire.JSONEncoding.default.encode(mutableURLRequest, with: ["email": email])
        }
    }
}

