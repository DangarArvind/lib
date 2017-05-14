//
//  WebServiceDataProvider.swift
//  WMA
//
//  Created by tasol on 1/4/16.
//  Copyright (c) 2016 tasol. All rights reserved.
//

import Foundation

protocol WebServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withExtTask task: NSString)
}

class WebServiceDataProvider: NSObject
{
    var delegate : WebServiceDataProviderDelegate?
    
    class  var sharedInstance : WebServiceDataProvider
    {
        struct Static
        {
            static let instance = WebServiceDataProvider()
        }
        return Static.instance
    }
    
    class func sharedInstanceWithDelegate (delgate : WebServiceDataProviderDelegate) -> WebServiceDataProvider
    {
        sharedInstance.delegate = delgate
        return sharedInstance
    }
    
    // Funcation Send Request To Server
    func sendRequestToServer (requestObj : NSDictionary)
    {
        let dicParam : NSDictionary = [CommonConstant.TAG_REQUEST_OBJ : requestObj.JSONString()]
        print("Request Obj :- \(requestObj.JSONString())")
        print("Url :- \(CommonConstant.TAG_URL)")
        
//        let request = AFHTTPRequestSerializer() // you can use an AFNetworking Request Serializer to create this
//
//
//        
//        if((requestObj.valueForKey(CommonConstant.TAG_TASK)) != nil)
//        {
//            if requestObj.valueForKey(CommonConstant.TAG_TASK) as! String == LoginConstant.TAG_TASK_LOGIN
//            {
//                let userDefault : NSUserDefaults = NSUserDefaults.standardUserDefaults()
//                
//                if let dicCookiesProparty = userDefault.objectForKey(CommonConstant.TAG_URL)
//                {
//                    let cookie : NSHTTPCookie = NSHTTPCookie(properties: dicCookiesProparty as! [String : AnyObject])!
//                    
//                    NSHTTPCookieStorage .sharedHTTPCookieStorage() .setCookies([cookie], forURL: NSURL(string: CommonConstant.TAG_URL), mainDocumentURL: nil)
//                }
//                userDefault.synchronize()
//            }
//            
//            if let cookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(NSURL(string: CommonConstant.TAG_URL)!)
//            {
//                for (headerField, cookie) in NSHTTPCookie.requestHeaderFieldsWithCookies(cookieStorage)
//                {
//                    print(headerField)
//                    print(cookie)
//                    request .setValue(cookie, forHTTPHeaderField: headerField)
//                }
//            }
//        }

        let manager =  AFHTTPRequestOperationManager()
//        manager .requestSerializer = request
        manager.requestSerializer.timeoutInterval = 120
        manager.POST(CommonConstant.TAG_URL, parameters: dicParam,
            success:
            {
                (operation : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in

                if responseObject == nil
                {
                    if self.delegate != nil
                    {
                        let errorDict : NSMutableDictionary = NSMutableDictionary()
                        errorDict.setValue("400", forKey: "code")
                        
                        if((requestObj.valueForKey(CommonConstant.TAG_EXTTASK)) != nil)
                        {
                            self.delegate?.dataRecievedFromServer(errorDict as NSDictionary, withExtTask: requestObj.valueForKey(CommonConstant.TAG_EXTTASK) as! String)
                        }
                        else if((requestObj.valueForKey(CommonConstant.TAG_TASK)) != nil)
                        {
                            self.delegate?.dataRecievedFromServer(errorDict as NSDictionary, withExtTask: requestObj.valueForKey(CommonConstant.TAG_TASK) as! String)
                        }
                    }
                    return
                }
                
                print("Response :- \(responseObject.JSONString())")
                
                let code  = responseObject["code"]
                
                if (responseObject["code"] != nil && code as! String == "704" && self.autoLogin(requestObj, arrImg: []))
                {
                    return
                }
                else if (responseObject["code"] != nil && code as! String == "400")
                {
                    if requestObj .valueForKey(CommonConstant.TAG_TASK) != nil
                    {
                        if requestObj.valueForKey(CommonConstant.TAG_TASK) as! String == LoginConstant.TAG_TASK_LOGOUT && self.autoLogin(requestObj, arrImg: [])
                        {
                            return
                        }
                    }
                }
                
                if (self.delegate != nil)
                {
                    self.saveNotificationCount(responseObject)
                    
                    if((requestObj.valueForKey(CommonConstant.TAG_EXTTASK)) != nil)
                    {
                        self.delegate?.dataRecievedFromServer(responseObject as! NSDictionary, withExtTask: requestObj.valueForKey(CommonConstant.TAG_EXTTASK) as! String)
                    }
                    else if((requestObj.valueForKey(CommonConstant.TAG_TASK)) != nil)
                    {
//                        if requestObj.valueForKey(CommonConstant.TAG_TASK) as! String == LoginConstant.TAG_TASK_LOGIN
//                        {
//                            print(operation.response.allHeaderFields)
//                            
//                            var cookies: [NSHTTPCookie] = [NSHTTPCookie]()
//                            cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(operation.response.allHeaderFields as! [String : String], forURL: NSURL(string: CommonConstant.TAG_URL)!)
//                            print(cookies)
//                           
//                            let userDefault : NSUserDefaults = NSUserDefaults.standardUserDefaults()
//                            for cookie in cookies
//                            {
//                                if cookie.name == "activeProfile"
//                                {
//                                    userDefault .setValue(cookie.properties, forKey: CommonConstant.TAG_URL)
//                                }
//                            }
//                            userDefault.synchronize()
//                        }
                        self.delegate?.dataRecievedFromServer(responseObject as! NSDictionary, withExtTask: requestObj.valueForKey(CommonConstant.TAG_TASK) as! String)
                    }
                }
            },
            failure:
            {
                (operation,error) -> Void in
                
                print("Response String :- \(operation.responseString)")
                print("Error :- \(error)")
                
                if(self.delegate != nil)
                {
                    let errorDict : NSMutableDictionary = NSMutableDictionary()
                    errorDict.setValue("1111", forKey: "code")
                    
                    if((requestObj.valueForKey(CommonConstant.TAG_EXTTASK)) != nil)
                    {
                        self.delegate?.dataRecievedFromServer(errorDict as NSDictionary, withExtTask: requestObj.valueForKey(CommonConstant.TAG_EXTTASK) as! String)
                    }
                    else if((requestObj.valueForKey(CommonConstant.TAG_TASK)) != nil)
                    {
                        self.delegate?.dataRecievedFromServer(errorDict as NSDictionary, withExtTask: requestObj.valueForKey(CommonConstant.TAG_TASK) as! String)
                    }
                }
            }
        )
    }
    
    // Mark : Send Request With Image
    func sendRequestToServerWithFile(requestObj : NSDictionary,arrImg : NSArray)
    {
        let dicParameter : NSDictionary = [CommonConstant.TAG_REQUEST_OBJ : requestObj.JSONString()]
        print("Request Obj :- \(requestObj.JSONString())")
        print("Url :- \(CommonConstant.TAG_URL)")
        
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer.timeoutInterval = 120
        manager.POST(CommonConstant.TAG_URL, parameters: dicParameter, constructingBodyWithBlock:
            { (formData) -> Void in
                if arrImg.count > 0
                {
                    for item in arrImg
                    {
                        let dicFileData : NSDictionary = item as! NSDictionary
                        
                        formData.appendPartWithFileData(dicFileData.objectForKey("fileData") as! NSData, name: dicFileData.objectForKey("fileTag") as! String, fileName: dicFileData.objectForKey("fileName") as! String, mimeType: dicFileData.objectForKey("fileType") as! String)
                    }
                }
            }, success: { (operation : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
                
                if responseObject == nil
                {
                    if self.delegate != nil
                    {
                        let errorDict : NSMutableDictionary = NSMutableDictionary()
                        errorDict.setValue("400", forKey: "code")
                        
                        if((requestObj.valueForKey(CommonConstant.TAG_EXTTASK)) != nil)
                        {
                            self.delegate?.dataRecievedFromServer(errorDict as NSDictionary, withExtTask: requestObj.valueForKey(CommonConstant.TAG_EXTTASK) as! String)
                        }
                        else if((requestObj.valueForKey(CommonConstant.TAG_TASK)) != nil)
                        {
                            self.delegate?.dataRecievedFromServer(errorDict as NSDictionary, withExtTask: requestObj.valueForKey(CommonConstant.TAG_TASK) as! String)
                        }
                    }
                    return
                }
                
                print("Response Obj :- \(responseObject.JSONString())")
                
                if (responseObject["code"] != nil && responseObject["code"] as! String == "704" && self.autoLogin(requestObj, arrImg: arrImg))
                {
                    return
                }
                else if (responseObject["code"] != nil && responseObject["code"] as! String == "400")
                {
                    if requestObj .valueForKey(CommonConstant.TAG_TASK) != nil
                    {
                        if requestObj.valueForKey(CommonConstant.TAG_TASK) as! String == LoginConstant.TAG_TASK_LOGOUT && self.autoLogin(requestObj, arrImg: [])
                        {
                            return
                        }
                    }
                }
                
                if (self.delegate != nil)
                {
                    self .saveNotificationCount(responseObject)
                    
                    if((requestObj.valueForKey(CommonConstant.TAG_EXTTASK)) != nil)
                    {
                        self.delegate?.dataRecievedFromServer(responseObject as! NSDictionary, withExtTask: requestObj.valueForKey(CommonConstant.TAG_EXTTASK) as! String)
                    }
                    else if((requestObj.valueForKey(CommonConstant.TAG_TASK)) != nil)
                    {
                        self.delegate?.dataRecievedFromServer(responseObject as! NSDictionary, withExtTask: requestObj.valueForKey(CommonConstant.TAG_TASK) as! String)
                    }
                    
                }
            })
            { (operation,error) -> Void in
                
                print("Response String :- \(operation.responseString)")
                print("Error :- \(error)")
                
                if((self.delegate) != nil)
                {
                    let errorDict : NSMutableDictionary = NSMutableDictionary()
                    errorDict.setValue("1111", forKey: "code")
                    
                    if((requestObj.valueForKey(CommonConstant.TAG_EXTTASK)) != nil)
                    {
                        self.delegate?.dataRecievedFromServer(errorDict as NSDictionary, withExtTask: requestObj.valueForKey(CommonConstant.TAG_EXTTASK) as! String)
                    }
                    else if((requestObj.valueForKey(CommonConstant.TAG_TASK)) != nil)
                    {
                        self.delegate?.dataRecievedFromServer(errorDict as NSDictionary, withExtTask: requestObj.valueForKey(CommonConstant.TAG_TASK) as! String)
                    }
                }
        }
    }
    
    //Mark : For AutoLogin
    func autoLogin(requestObj1 : NSDictionary,arrImg : NSArray) -> Bool
    {
        let userDefault : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let dicReqData : NSDictionary!
        
        if let username : String = (userDefault.valueForKey(LoginConstant.TAG_USERNAME) as? String)
        {
            var deviceToken : NSString
            if let token : String = userDefault .valueForKey(CommonConstant.TAG_DEVICETOKEN) as? String
            {
                deviceToken = token
            }
            else
            {
                deviceToken = ""
            }
            
            let dicPostVariables : NSMutableDictionary = NSMutableDictionary()
            dicPostVariables.setValue(username, forKey: LoginConstant.TAG_USERNAME)
            dicPostVariables.setValue(userDefault.valueForKey(LoginConstant.TAG_PASSWORD), forKey: LoginConstant.TAG_PASSWORD)
            dicPostVariables.setValue(deviceToken, forKey:LoginConstant.TAG_DEVICETOKEN)
            dicPostVariables.setValue(LoginConstant.TAG_TYPE, forKey: LoginConstant.TAG_FIELD_TYPE)
            
            if (userDefault.valueForKey("isfbNewUser") as? String == "1")
            {
                dicPostVariables.setValue(userDefault.valueForKey("Str_FBLogin_REQ")?.valueForKey("password"), forKey: "password")
                dicPostVariables.setValue(userDefault.valueForKey("Str_FBLogin_REQ")?.valueForKey("bigpic"), forKey: "bigpic")
                dicPostVariables.setValue(userDefault.valueForKey("Str_FBLogin_REQ")?.valueForKey("regopt"), forKey: "regopt")
                dicPostVariables.setValue(userDefault.valueForKey("Str_FBLogin_REQ")?.valueForKey("email"), forKey: "email")
                dicPostVariables.setValue(userDefault.valueForKey("Str_FBLogin_REQ")?.valueForKey("fbid"), forKey: "fbid")
                dicReqData  = [CommonConstant.TAG_TASK : LoginConstant.TAG_TASK_FBLOGIN,CommonConstant.TAG_TASK_DATA : dicPostVariables]
            }
            else
            {
                dicReqData  = [CommonConstant.TAG_TASK : LoginConstant.TAG_TASK_LOGIN,CommonConstant.TAG_TASK_DATA : dicPostVariables]
            }
            
            
            let dicParam : NSDictionary = [CommonConstant.TAG_REQUEST_OBJ : dicReqData.JSONString()]
            print("Request Obj :- \(dicParam.JSONString())")
            
            print("Url :- \(CommonConstant.TAG_URL)")
            
            let manager =  AFHTTPRequestOperationManager()
            manager.requestSerializer.timeoutInterval = 120
            
            let sema :  dispatch_semaphore_t = dispatch_semaphore_create(0);
            
            manager.POST(CommonConstant.TAG_URL, parameters: dicParam,
                success:
                {
                    (operation : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
                    print("Response :- \(responseObject.JSONString())")
                    
                    if responseObject .valueForKey("code") as! String == "200"
                    {
                        if let userData = responseObject.objectForKey(JomSocial.TAG_FIELD_USERDATA) as? NSDictionary
                        {
                            ApplicationData.sharedInstance.currentUserData = userData
                        }
                    }
                    else if responseObject .valueForKey("code") as! String == "401"
                    {
                        FBSDKLoginManager().logOut()
                        let appDomain : NSString = NSBundle.mainBundle().bundleIdentifier!
                        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain as String)
                        
                        let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller : LoginViewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                        appDelegate.navigationController.pushViewController(controller, animated: true)
                        return
                    }
                    
                    if arrImg.count == 0
                    {
                        self.sendRequestToServer(requestObj1)
                    }
                    else
                    {
                        self.sendRequestToServerWithFile(requestObj1, arrImg: arrImg)
                    }
                },
                failure:
                {
                    (operation,error) -> Void in
                    
                    print("Response String :- \(operation.responseString)")
                    print("Error :- \(error)")
                    dispatch_semaphore_signal(sema)
                }
            )
        }
        else
        {
            let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let controller : LoginViewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
            appDelegate.navigationController.pushViewController(controller, animated: true)
            
        }
        userDefault.synchronize()
        return true
    }
    
    //Mark : Get the List Of Place From Addressed String
    func sendPlaceListRequestToServer(placeName : String)
    {
        let dicParameter : NSDictionary = NSDictionary()
        
        var urlStrGeocode : NSString = "https://maps.googleapis.com/maps/api/geocode/json?address=\(placeName)&sensor=false&key=\(CommonConstant.TAG_PLACEAPI_KEY)"
        urlStrGeocode = urlStrGeocode .stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        let manager =  AFHTTPRequestOperationManager()
        manager.requestSerializer.timeoutInterval = 120
        manager.POST(urlStrGeocode as String, parameters: dicParameter,
            success:
            {
                (operation : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
                
                print("Response :- \(responseObject.JSONString())")
                
                
                if (responseObject.valueForKey("status")?.lowercaseString) == "ok" || responseObject.valueForKey("status") as! String == "ZERO_RESULTS"
                {
                    if (self.delegate != nil)
                    {
                        self.delegate?.dataRecievedFromServer(responseObject as! NSDictionary, withExtTask:"")
                    }
                }
            },
            failure:
            {
                (operation,error) -> Void in
                
                print("Response String :- \(operation.responseString)")
                print("Error :- \(error)")
                
                if(self.delegate != nil)
                {
                    let errorDict : NSMutableDictionary = NSMutableDictionary()
                    errorDict.setValue("1111", forKey: "code")
                    
                    self.delegate?.dataRecievedFromServer(errorDict as NSDictionary, withExtTask:"")
                }
            }
        )
    }
    
    func sendPlaceListFromCordinateRequestToServer( lat : Double,lng : Double)
    {
        let dicParameter : NSDictionary = NSDictionary()
        
        var strURL : NSString = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(lat),\(lng)&sensor=false&key=\(CommonConstant.TAG_PLACEAPI_KEY)"
        strURL = strURL .stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        let manager =  AFHTTPRequestOperationManager()
        manager.requestSerializer.timeoutInterval = 120
        manager.POST(strURL as String, parameters: dicParameter,
            success:
            {
                (operation : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
                
                print("Response :- \(responseObject.JSONString())")
                
                
                if (responseObject.valueForKey("status")?.lowercaseString) == "ok" || responseObject.valueForKey("status") as! String == "ZERO_RESULTS" || responseObject.valueForKey("status") as! String == "REQUEST_DENIED"
                {
                    if (self.delegate != nil)
                    {
                        self.delegate?.dataRecievedFromServer(responseObject as! NSDictionary, withExtTask:"")
                    }
                }
            },
            failure:
            {
                (operation,error) -> Void in
                
                print("Response String :- \(operation.responseString)")
                print("Error :- \(error)")
                
                if(self.delegate != nil)
                {
                    let errorDict : NSMutableDictionary = NSMutableDictionary()
                    errorDict.setValue("1111", forKey: "code")
                    
                    self.delegate?.dataRecievedFromServer(errorDict as NSDictionary, withExtTask:"")
                }
            }
        )
    }
    
    //MARK: Method for Save notification count in local
    private func saveNotificationCount(responseObject : AnyObject)
    {
        if let dicNotification = responseObject.objectForKey(JomSocial.TAG_FIELD_NOTIFICATION)
        {
            let userDefault : NSUserDefaults = NSUserDefaults.standardUserDefaults()
            if (dicNotification as! NSDictionary).valueForKey(Notificaiton.TAG_FRIENDREQUEST) != nil
            {
                userDefault .setInteger((dicNotification as! NSDictionary).valueForKey(Notificaiton.TAG_FRIENDREQUEST) as! Int, forKey: Notificaiton.TAG_FRIENDREQUEST)
            }
            else{
                userDefault .setInteger(0, forKey: Notificaiton.TAG_FRIENDREQUEST)
            }
            
            if (dicNotification as! NSDictionary).valueForKey(Notificaiton.TAG_GENERAL) != nil
            {
                userDefault .setInteger((dicNotification as! NSDictionary).valueForKey(Notificaiton.TAG_GENERAL) as! Int, forKey: Notificaiton.TAG_GENERAL)
            }
            else{
                userDefault .setInteger(0, forKey: Notificaiton.TAG_GENERAL)
            }
            
            if (dicNotification as! NSDictionary).valueForKey(Notificaiton.TAG_MESSSAGE) != nil
            {
                userDefault .setInteger((dicNotification as! NSDictionary).valueForKey(Notificaiton.TAG_MESSSAGE) as! Int, forKey: Notificaiton.TAG_MESSSAGE)
            }
            else{
                userDefault .setInteger(0, forKey: Notificaiton.TAG_MESSSAGE)
            }
            
            userDefault.synchronize()
            
            NSNotificationCenter.defaultCenter().postNotificationName("ShowBagdeCount", object: nil)
        }
    }
}
