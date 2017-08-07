//
//  EmailPasswordCheckDelegate.swift
//  Betit
//
//  Created by Miroslav Čapkovič on 06/08/2017.
//  Copyright © 2017 Miros. All rights reserved.
//

import Foundation
import UIKit

/**
 Protocol for checking of given email and password. Neccessary to use in viewcontroller and call default implementation from extension in this file.
 */
protocol EmailPasswordCheckDelegate {
    func checkEmail(email: String?) -> Bool
    func checkPassword(password: String?) -> Bool
}

extension EmailPasswordCheckDelegate where Self: UIViewController  {
    
    //maybe I should check email validity with regex, but I think, that it should be implemented on server
    func checkEmail(email: String?) -> Bool {
        if let emailString = email, emailString.characters.count > 0 {
            return true
        }
        GeneralHelper.showAlertViewWithText(title: nil, text: NSLocalizedString("input_error_email", comment: ""), target: self)
        return false
    }
    
    func checkPassword(password: String?) -> Bool {
        if let passwordString = password, passwordString.characters.count > 0 {
            return true
        }
        GeneralHelper.showAlertViewWithText(title: nil, text: NSLocalizedString("input_error_password", comment: ""), target: self)
        return false
    }
}
