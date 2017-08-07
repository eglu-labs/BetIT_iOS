//
//  ForgotPasswordViewController.swift
//  Betit
//
//  Created by Miroslav Čapkovič on 06/08/2017.
//  Copyright © 2017 Miros. All rights reserved.
//

import UIKit
import KRProgressHUD

class ForgotPasswordViewController: UIViewController, CommonBackground, CustomNavBar, CustomBackButton, EmailPasswordCheckDelegate {
    @IBOutlet weak var emailTextField: BorderedTextField!
    @IBOutlet weak var passwordRecoveryDescLabel: UILabel!
    @IBOutlet weak var sendButton: RoundedCornersButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("title_password_recovery", comment: "")
        
        //implementations of implemented protocols
        self.setCommonBackground()
        self.customizeNavBar()
        self.customizeBackButton()
        self.sendButton.createRoundedCorners(radius: Sizes.ROUNDED_CORNER_RADIUS)
        
        setLocalizations()
        
        self.emailTextField.delegate = self
    }
    
    @IBAction func sendPressed(_ sender: Any) {
        if checkEmail(email: emailTextField.text) {
            KRProgressHUD.show()
            UserService.recoverPassword(email: emailTextField.text!, success: { (uniMappable) in
                KRProgressHUD.dismiss()
                guard let sucess = uniMappable?.success else {
                    GeneralHelper.showAlertViewWithText(title: NSLocalizedString("response_error_general", comment: ""), text: nil, target: self)
                    return
                }
                
                if !sucess {
                    GeneralHelper.showAlertViewWithText(title: uniMappable?.message ?? NSLocalizedString("response_error_general", comment: ""), text: nil, target: self)
                } else {
                    //just showing the message
                    self.emailTextField.resignFirstResponder()
                    GeneralHelper.showAlertViewWithText(title: NSLocalizedString("title_success", comment: ""), text: NSLocalizedString("text_password_was_send", comment: ""), target: self)
                }
            }, failure: { (error) in
                KRProgressHUD.dismiss()
                GeneralHelper.showAlertViewWithText(title: error, text: nil, target: self)
            })
        }
    }
    
    private func setLocalizations() {
        self.emailTextField.placeholder = NSLocalizedString("textfield_placeholder_email", comment: "")
        self.passwordRecoveryDescLabel.text = NSLocalizedString("label_password_recovery_description", comment: "")
        self.sendButton.setTitle(NSLocalizedString("button_title_send", comment: ""), for: .normal)
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendPressed(textField)
        return false
    }
}
