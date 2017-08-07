//
//  CommonBackground.swift
//  Betit
//
//  Created by Miroslav Čapkovič on 06/08/2017.
//  Copyright © 2017 Miros. All rights reserved.
//

import UIKit

/**
 Protocol for common background. Neccessary to use in viewcontroller and call default implementation from extension in this file.
 */
protocol CommonBackground {
    func setCommonBackground()
}

extension CommonBackground where Self: UIViewController {
    func setCommonBackground() {
        let backgroundImageView = UIImageView(frame: self.view.frame)
        backgroundImageView.image = UIImage(named: "Background")
        
        self.view.insertSubview(backgroundImageView, at: 0)
    }
}
