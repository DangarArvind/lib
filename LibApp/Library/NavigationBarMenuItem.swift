//
//  NavigationBarMenuItem.swift
//  WMA
//
//  Created by tasol on 4/22/16.
//  Copyright © 2016 tasol. All rights reserved.
//

import UIKit

class NavigationBarMenuItem: NSObject
{
    var menuName : String!
    var menuTag : Int!
    
    init(MenuName name : String,MenuTag tag : Int)
    {
        super.init()
        menuName = name
        menuTag = tag
    }
}
