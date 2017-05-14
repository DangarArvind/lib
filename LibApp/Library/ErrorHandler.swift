//
//  ErrorHandler.swift
//  WMA
//
//  Created by tasol on 2/9/16.
//  Copyright © 2016 tasol. All rights reserved.
//

import UIKit

let TAG_204 =  "No Content Found."
let TAG_400 = "Wrong Data."
let TAG_401 = "Unable to authenticate. Check username or password"
let TAG_402 = "Invalid Password."
let TAG_404 = "No Such Request Found."
let TAG_415 = "Unsupported File Type."
let TAG_416 = "Upload Limit Exceeded."
let TAG_500 = "Server Error."
let TAG_501 = "Server Error."
let TAG_701 = "Username Already Exists."
let TAG_702 = "Email Already Exists."
let TAG_703 = "Facebook User Not Found."
let TAG_704 = "Session Expired."
let TAG_705 = "Permission Denied."
let TAG_706 = "Restricted Access."
let TAG_707 = "Request already exists."
let TAG_708 = "Awaiting approval."
let TAG_709 = "You already sent friend request to this user."
let TAG_710 = "This user already sent you a friend request."
let TAG_711 = "Comment is not allowed, because you are no more friend with this guy."
let TAG_1111 = "Network connection lost."

class ErrorHandler: NSObject
{
    var message : String = ""
    func hasError(dicResponse : NSDictionary)
    {
        
        var errorCode : Int = 0
        
        if let code = dicResponse.valueForKey("code") as? String
        {
            errorCode = Int(code)!
        }
        
        let title : String = "Alert"
        if let code = dicResponse.valueForKey("code")
        {
            errorCode = Int(code as! String)!
        }else{
            errorCode = 0
        }
        
        if let msg = dicResponse.valueForKey("message")
        {
            message = msg as! String
        }
        else
        {
            message = ""
        }
        
        switch(errorCode)
        {
        case 204 :
            showAlert(title, body: TAG_204)
            break
        case 400 :
            showAlert(title, body: TAG_400)
            break
        case 401 :
            showAlert(title, body: TAG_401)
            break
        case 402 :
            showAlert(title, body: TAG_402)
            break
        case 404 :
            showAlert(title, body: TAG_404)
            break
        case 415 :
            showAlert(title, body: TAG_415)
            break
        case 416 :
            showAlert(title, body: TAG_416)
            break
        case 500 :
            showAlert(title, body: TAG_500)
            break
        case 501 :
            showAlert(title, body: TAG_501)
            break
        case 701 :
            showAlert(title, body: TAG_701)
            break
        case 702 :
            showAlert(title, body: TAG_702)
            break
        case 703 :
            showAlert(title, body: TAG_703)
            break
        case 704 :
            showAlert(title, body: TAG_704)
            break
        case 705 :
            showAlert(title, body: TAG_705)
            break
        case 706 :
            showAlert(title, body: TAG_706)
            break
        case 707 :
            showAlert(title, body: TAG_707)
            break
        case 708 :
            showAlert(title, body: TAG_708)
            break
        case 709 :
            showAlert(title, body: TAG_709)
            break
        case 710 :
            showAlert(title, body: TAG_710)
            break
        case 711 :
            showAlert(title, body: TAG_711)
            break
        case 1111 :
            showAlert(title, body: TAG_1111)
            break
        default:
            break
        }
        
    }
    
    func showAlert(title : String,body : String)
    {
        let alert : UIAlertView = UIAlertView(title: title, message: "", delegate: nil, cancelButtonTitle: "Ok")

        if(message != "")
        {
            alert.message = message
        }
        else{
            alert.message = body
        }
        alert.show()
    }
}
