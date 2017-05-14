//
//  UIView+Extension.swift
//  InFans
//
//  Created by Tops on 4/29/16.
//  Copyright © 2016 Tops. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func dropShadow(radius:CGFloat){
        self.layer.cornerRadius = radius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 5
    }
    
    
}
