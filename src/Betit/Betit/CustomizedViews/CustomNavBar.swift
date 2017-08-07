//
//  CustomNavBar.swift
//  Betit
//
//  Created by Miroslav Čapkovič on 06/08/2017.
//  Copyright © 2017 Miros. All rights reserved.
//

import UIKit

/**
 Protocol for nav bar customization. Neccessary to use in viewcontroller and call default implementation from extension in this file.
 */
protocol CustomNavBar {
    func customizeNavBar()
}

extension CustomNavBar where Self: UIViewController {
    func customizeNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.barTintColor = Colors.PRIMARY_DARKER_COLOR
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = Colors.BACK_BUTTON_COLOR
    }
}
