//
//  CustomBackButton.swift
//  Betit
//
//  Created by Miroslav Čapkovič on 06/08/2017.
//  Copyright © 2017 Miros. All rights reserved.
//

import UIKit

/**
 Protocol for back button customization. Neccessary to use in viewcontroller and call default implementation from extension in this file.
 */
protocol CustomBackButton {
    func customizeBackButton()
}

extension CustomBackButton where Self: UIViewController {
    func customizeBackButton() {
        let backImage = UIImage(named: "BackButton")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.backItem?.title = ""
    }
}
