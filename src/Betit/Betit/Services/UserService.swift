//
//  UserService.swift
//  Betit
//
//  Created by Miroslav Čapkovič on 06/08/2017.
//  Copyright © 2017 Miros. All rights reserved.
//

import Foundation
import Alamofire

/**
 Service for all alamofire request related to user
 */
class UserService {
    typealias FailureHandler = (String) -> Void
    
    //request signin/signup
    class func signUser(signRequest: URLRequestConvertible, success user: @escaping (User?) -> Void, failure: @escaping FailureHandler) {
        
        //mocking only
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let mockUser = User()
            mockUser.success = true
            user(mockUser)
        }
        
        /*Alamofire.request(signRequest).responseObject { (response: DataResponse<User>) in
         switch response.result {
         case .success(let value):
         user(value)
         break
         case .failure(let error):
         failure(error.localizedDescription)
         break
         }
         }*/
    }
    
    //request new password
    class func recoverPassword(email: String, success mappable: @escaping (UniversalMappable?) -> Void, failure: @escaping FailureHandler) {
        
        //mocking only
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let mockUM = UniversalMappable()
            mockUM.success = true
            mappable(mockUM)
        }
        
        /*Alamofire.request(UserRouter.forgotPasswordRequest(email)).responseObject { (response: DataResponse<UniversalMappable>) in
         switch response.result {
         case .success(let value):
         mappable(value)
         break
         case .failure(let error):
         failure(error.localizedDescription)
         break
         }
         }*/
    }
}
