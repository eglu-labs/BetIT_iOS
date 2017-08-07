//
//  ViewController.swift
//  Betit
//
//  Created by Miroslav Čapkovič on 06/08/2017.
//  Copyright © 2017 Miros. All rights reserved.
//

import UIKit
import KRProgressHUD
import SimpleAlert
import SCrypto

class LoginViewController: UIViewController, CommonBackground, EmailPasswordCheckDelegate {
    @IBOutlet weak var emailTextField: BorderedTextField!
    @IBOutlet weak var passwordTextField: BorderedTextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: RoundedCornersButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //implementations of implemented protocols
        self.setCommonBackground()
        self.loginButton.createRoundedCorners(radius: Sizes.ROUNDED_CORNER_RADIUS)
        
        setProgressHUD()
        setLocalizations()
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordTextField.isSecureTextEntry = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func loginPressed(_ sender: Any) {
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
                    //usually returned instance of user would be saved to prefs (actoken to keychain), but in this case, user object is just an assumption, so this app just shows info about successfull login
                    //UserHelper.saveUser(user: user)
                    
                    GeneralHelper.showAlertViewWithText(title: NSLocalizedString("title_success", comment: ""), text: "User sucessfully signed in", target: self)
                }
            }, failure: { (error) in
                KRProgressHUD.dismiss()
                GeneralHelper.showAlertViewWithText(title: error, text: nil, target: self)
            })
        }
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showForgotPassword", sender: self)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showRegistration", sender: self)
    }
    
    //this is singleton, so should be enough to set once at the beginning
    private func setProgressHUD() {
        KRProgressHUD.set(style: .white)
        KRProgressHUD.set(maskType: .black)
        KRProgressHUD.set(activityIndicatorViewStyle: .gradationColor(head: Colors.PRIMARY_COLOR, tail: Colors.PRIMARY_DARKER_COLOR))
    }
    
    private func setLocalizations() {
        self.emailTextField.placeholder = NSLocalizedString("textfield_placeholder_email", comment: "")
        self.passwordTextField.placeholder = NSLocalizedString("textfield_placeholder_password", comment: "")
        self.forgotPasswordButton.setTitle(NSLocalizedString("button_title_forgot_password", comment: ""), for: .normal)
        self.loginButton.setTitle(NSLocalizedString("button_title_login", comment: ""), for: .normal)
        self.createAccountButton.setTitle(NSLocalizedString("button_title_create_account", comment: ""), for: .normal)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            self.passwordTextField.becomeFirstResponder()
        } else {
            loginPressed(textField)
        }
        return false
    }
}

