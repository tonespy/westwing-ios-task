//
//  UIView+Extension.swift
//  CampaignBrowser
//
//  Created by Abubakar Oladeji on 11/09/2018.
//  Copyright © 2018 Westwing GmbH. All rights reserved.
//

import UIKit

extension UIView {
    
    func elevate(elevation: Double) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: elevation)
        self.layer.shadowRadius = CGFloat(elevation)
        self.layer.shadowOpacity = 0.24
    }
}
