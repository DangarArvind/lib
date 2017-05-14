//
//  APICall.swift
//  AvailabilityManager_Freelancer
//
//  Created by TopsTech on 04/03/2015.
//  Copyright (c) 2015 tops. All rights reserved.
//

import UIKit
import Foundation
import AFNetworking

@objc(community)
class APICall :NSObject {

    static let sharedAPICall: APICall = { APICall() }()

    
    func callApiUsingGET (urlPath: NSString, withLoader showLoader: Bool, successBlock success:@escaping (_ responceData:AnyObject)->Void) {

        if(showLoader){
            AppDelegate().startSpinerWithOverlay(overlay: true)
        }

        let manager = AFHTTPRequestOperationManager()
        let emptyDic = [String: String]()
        let urlPath1 = Global.g_APIBaseURL + (urlPath as String)
        
        let operation = manager.get(urlPath1, parameters: emptyDic, success: { (operations:AFHTTPRequestOperation, responseObject:Any) in
            if(showLoader) {
                AppDelegate().stopSpiner()
            }
            success(responseObject as AnyObject)
        }) { (operations:AFHTTPRequestOperation?, error:Error) in
            if(showLoader) {
                AppDelegate().stopSpiner()
            }
            print(error, terminator: "")
        }
        operation!.start()
        
    }
    
    func callApiUsingWithFixURLGET (urlPath: NSString, withLoader showLoader: Bool, successBlock success:@escaping (_ responceData:AnyObject)->Void) {
        
        if(showLoader){
            AppDelegate().startSpinerWithOverlay(overlay: true)
        }
        let manager = AFHTTPRequestOperationManager()
        let emptyDic = [String: String]()
        let urlPath1 = (urlPath as String)
        let operation = manager.get(urlPath1, parameters: emptyDic, success: { (operations:AFHTTPRequestOperation, responseObject:Any) in
            if(showLoader) {
                AppDelegate().stopSpiner()
            }
            success(responseObject as AnyObject)
        }) { (operations:AFHTTPRequestOperation?, error:Error) in
            if(showLoader) {
                AppDelegate().stopSpiner()
            }
            print(error, terminator: "")
        }
        operation!.start()

        
        
        
    }
    
    func callApiUsingGETWithDict (urlPath: NSString,withParameter dictData: NSMutableDictionary, withLoader showLoader: Bool, successBlock success:@escaping (_ responceData:AnyObject)->Void) {
        if(showLoader){
            AppDelegate().startSpinerWithOverlay(overlay: true)
        }
        
        //add language
        dictData.setValue(StaticClass().retriveFromUserDefaults(key: Global.g_UserData.USERLang as NSString), forKey: "lang")
        let manager = AFHTTPRequestOperationManager()
        let urlPath1 = Global.g_APIBaseURL + (urlPath as String)
        
        let operation = manager.get(urlPath1, parameters: dictData, success: { (operations:AFHTTPRequestOperation, responseObject:Any) in
            if(showLoader) {
                AppDelegate().stopSpiner()
            }
            success(responseObject as AnyObject)
        }) { (operations:AFHTTPRequestOperation?, error:Error) in
            if(showLoader) {
                AppDelegate().stopSpiner()
            }
            print(error, terminator: "")
        }
        operation!.start()
        
    }
    
    
    func callApiUsingPOST (urlPath: NSString, withParameter dictData: NSMutableDictionary, withLoader showLoader: Bool, successBlock success:@escaping (_ responceData:AnyObject)->Void, failureBlock failure:@escaping (_ responceData:AnyObject)->Void) {
        
        if(showLoader){
            AppDelegate().startSpinerWithOverlay(overlay: true)
        }
        //add language
        //dictData.setValue("f25a2fc72690b780b2a14e140ef6a9e0", forKey: "secret")

        let urlPath1 = Global.g_APIBaseURL + (urlPath as String)
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: JSONSerialization.ReadingOptions.allowFragments) as AFJSONResponseSerializer
        manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json", "text/html", "text/plain", "text/json", "text/javascript", "audio/wav") as Set<NSObject>
        manager.post(urlPath1, parameters: dictData, success: { (operation:AFHTTPRequestOperation, responseObject:Any) in
            if(showLoader) {
                AppDelegate().stopSpiner()
            }
            //convert resposeObject to nsdictonary
            let dict:NSDictionary = responseObject as! NSDictionary
            let code = dict["error"]!
            var codetInt = Int()
            
            if code is Int
            {
                codetInt = code as! Int
            }
            else
            {
                codetInt = Int(code as! String)!
            }

                if(codetInt == 200){
                    success(dict as AnyObject)
                }else{
                    failure(dict as AnyObject)
                }
            
        }) { (operation:AFHTTPRequestOperation?, error:Error) in
            if(showLoader) {
                AppDelegate().stopSpiner()
            }
            print(error, terminator: "")
             failure(error as AnyObject)
        }
    
    }
    
}

