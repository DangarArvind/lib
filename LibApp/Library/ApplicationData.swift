//
//  ApplicationData.swift
//  WMA
//
//  Created by tasol on 1/13/16.
//  Copyright © 2016 tasol. All rights reserved.
//

import UIKit

class ApplicationData: NSObject
{
    static let sharedInstance = ApplicationData()
    
    override private init()
    {
        
    }
    
    var extentionConfig : NSDictionary = NSDictionary()
    var jomSocialConfig : NSDictionary = NSDictionary()
    var k2Config        : NSDictionary = NSDictionary()
    var globalConfig    : NSDictionary = NSDictionary()
    
    var currentUserData : NSDictionary = NSDictionary()
    var selectedHomeTab : Int = 1
    var cartCount : Int = 0
}
