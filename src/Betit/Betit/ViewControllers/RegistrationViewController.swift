//
//  RegistrationViewController.swift
//  Betit
//
//  Created by Miroslav Čapkovič on 06/08/2017.
//  Copyright © 2017 Miros. All rights reserved.
//

import UIKit
import KRProgressHUD
import SCrypto

class RegistrationViewController: UIViewController, CommonBackground, CustomNavBar, CustomBackButton, EmailPasswordCheckDelegate {
    @IBOutlet weak var emailTextField: BorderedTextField!
    @IBOutlet weak var passwordTextField: BorderedTextField!
    @IBOutlet weak var registerButton: RoundedCornersButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("title_new_account", comment: "")
        
        //implementations of implemented protocols
        self.setCommonBackground()
        self.customizeNavBar()
        self.customizeBackButton()
        self.registerButton.createRoundedCorners(radius: Sizes.ROUNDED_CORNER_RADIUS)
        
        setLocalizations()
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordTextField.isSecureTextEntry = true
    }

    @IBAction func registerPressed(_ sender: Any) {
        if checkEmail(email: emailTextField.text) && checkPassword(password: passwordTextField.text) {
            KRProgressHUD.show()
            
            //password is hashed
            let signInRequest = UserRouter.signinRequest(emailTextField.text!, passwordTextField.text!.SHA256())
            UserService.signUser(signRequest: signInRequest, success: { (user) in
                KRProgressHUD.dismiss()
                guard let sucess = user?.success else {
                    GeneralHelper.showAlertViewWithText(title: NSLocalizedString("response_error_general", comment: ""), text: nil, target: self)
                    return
                }
                
                if !sucess {
                    GeneralHelper.showAlertViewWithText(title: user?.message ?? NSLocalizedString("response_error_general", comment: ""), text: nil, target: self)
                } else {
                    //usually returned instance of user would be saved to prefs (actoken to keychain), but in this case, user object is just an assumption, so this app just shows info about successfull registration
                    //UserHelper.saveUser(user: user)
                    
                    GeneralHelper.showAlertViewWithText(title: NSLocalizedString("title_success", comment: ""), text: "User sucessfully signed up", target: self)
                }
            }, failure: { (error) in
                KRProgressHUD.dismiss()
                GeneralHelper.showAlertViewWithText(title: error, text: nil, target: self)
            })
        }
    }
    
    private func setLocalizations() {
        self.emailTextField.placeholder = NSLocalizedString("textfield_placeholder_email", comment: "")
        self.passwordTextField.placeholder = NSLocalizedString("textfield_placeholder_password", comment: "")
        self.registerButton.setTitle(NSLocalizedString("button_title_register", comment: ""), for: .normal)
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            self.passwordTextField.becomeFirstResponder()
        } else {
            registerPressed(textField)
        }
        return false
    }
}
