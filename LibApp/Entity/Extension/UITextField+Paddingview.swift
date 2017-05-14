//
//  UITextField+Paddingview.swift
//  Lyst
//
//  Created by Tops on 3/16/16.
//  Copyright © 2016 Tops. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func paddingview(){
        let l3 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = l3
        self.leftViewMode = UITextFieldViewMode.always
        //return self
    }
    
    func leftPaddingImage(img:UIImage,width:CGFloat,height:CGFloat){
        let l3 = UIView(frame: CGRect(x:0, y:0 ,width: width + 5,height: self.frame.height))
        let imgview:UIImageView = UIImageView(frame: CGRect(x:0,y: (self.frame.height / 2) - (width / 2) + 2, width:width, height:height))
        imgview.image = img
        l3.addSubview(imgview)
        self.leftView = l3
        self.leftViewMode = UITextFieldViewMode.always
        
    }
    
}
