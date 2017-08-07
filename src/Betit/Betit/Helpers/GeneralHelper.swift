//
//  GeneralHelper.swift
//  Betit
//
//  Created by Miroslav Čapkovič on 06/08/2017.
//  Copyright © 2017 Miros. All rights reserved.
//

import Foundation
import UIKit
import SimpleAlert

/**
 Collection of static general funcs
 */
class GeneralHelper {
    
    /**
     Show general alert with title and text. Can be used from every viewcontroller
     */
    class func showAlertViewWithText(title: String?, text:String?, target: UIViewController) {
        let alertController: AlertController = AlertController(title: title, message: text, style: .alert)
        let okAction = AlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        okAction.button.tintColor = Colors.PRIMARY_COLOR
        alertController.popoverPresentationController?.sourceView = target.view
        target.present(alertController, animated: true, completion: nil)
    }
}
