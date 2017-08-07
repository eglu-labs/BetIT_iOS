//
//  RoundedCorners.swift
//  Betit
//
//  Created by Miroslav Čapkovič on 06/08/2017.
//  Copyright © 2017 Miros. All rights reserved.
//

import UIKit

/**
 Protocol, that creates rounded corners for view. Neccessary to use in view and call default implementation from extension in this file.
 */
protocol RoundedCorners {
    func createRoundedCorners(radius: CGFloat)
}

extension RoundedCorners where Self: UIView {
    func createRoundedCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = false
    }
}
