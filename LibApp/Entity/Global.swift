//
//  Global.swift
//  SwiftDemo
//
//  Created by TopsTech on 02/03/2015.
//  Copyright (c) 2015 tops. All rights reserved.


struct Global {

    // API base Url
    //static let g_APIBaseURL = "http://assetenterprises.com/testing/live/"
    static var g_APIBaseURL = "http://spaarg.com/beta/e_menu/api/"
    static let appdel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    static let aryChild:NSMutableArray = NSMutableArray()
    static let aryRelation:NSMutableArray = NSMutableArray()
    static var currentSelect:Int = 1
    //Instagram
    static let ScreenWidth  =  UIScreen.main.bounds.size.width
    static let Screenheight =  UIScreen.main.bounds.size.height
    static let JWTSecratekey =  "f25a2fc72690b780b2a14e140ef6a9e0"

    struct customFont {
        //        Open Sans
        //        == NotoSans-BoldItalic
        //        == NotoSans-Bold
        //        == NotoSans
        static let Avenir_Heavy = "Avenir-Heavy"
        static let Avenir_Oblique = "Avenir-Oblique"
        static let Avenir_Black = "Avenir-Black"
        static let Avenir_Book = "Avenir-Book"
        static let Avenir_BlackOblique = "Avenir-BlackOblique"
        static let Avenir_HeavyOblique = "Avenir-HeavyOblique"
        static let Avenir_Light = "Avenir-Light"
        static let Avenir_MediumOblique = "Avenir-MediumOblique"
        static let Avenir_Medium = "Avenir-Medium"
        static let Avenir_LightOblique = "Avenir-LightOblique"
        static let Avenir_Roman = "Avenir-Roman"
        static let Avenir_BookOblique = "Avenir-BookOblique"

    }
    
    struct g_UserData {
        static let USERaddress = "address"
        static let USERchange_pwd_status = "change_pwd_status"
        static let USERcontact_no = "contact_no"
        static let USERdate_of_birth = "date_of_birth"
        static let USERemail = "email"
        static let USERfirst_name = "first_name"
        static let USERgender = "gender"
        static let USERlast_name = "last_name"
        static let USERlogin_id = "login_id" //
        static let USERtemplogin_id = "Templogin_id" //
        static let USERparent_id = "parent_id"
        static let USERprofile_photo = "profile_photo"
        static let USERname = "Username"
        static let USERtype = "UserType"
        static let USERpassword_changed = "password_changed"

        
        static let USERRelation = "Relation"
        static let USERadmin_id = "admin_id"
        static let USERLang = "languageId"
    }
    
    struct g_UserDefaultKey {
        static let latitude    = "latitude"
        static let longitude   = "longitude"
        static let DeviceToken = "DeviceToken"
        static let address     = "address"
        static let IS_USERLOGIN     = "USER_LOGIN"
        static let city     = "City"
    }
    
    struct directoryPath {
        static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        static let Tmp = NSTemporaryDirectory()
    }
    
    //Device Compatibility
    struct is_Device {
        static let _iPhone = (UIDevice.current.model as NSString).isEqual(to: "iPhone") ? true : false
        static let _iPad = (UIDevice.current.model as NSString).isEqual(to: "iPad") ? true : false
        static let _iPod = (UIDevice.current.model as NSString).isEqual(to: "iPod touch") ? true : false

    }
    //IOS Version Compatibility
    struct is_Ios {
        static let _9 = ((UIDevice.current.systemVersion as NSString).floatValue >= 9.0) ? true : false
        static let _8 = ((UIDevice.current.systemVersion as NSString).floatValue >= 8.0 && (UIDevice.current.systemVersion as NSString).floatValue < 9.0) ? true : false
        static let _7 = ((UIDevice.current.systemVersion as NSString).floatValue >= 7.0 && (UIDevice.current.systemVersion as NSString).floatValue < 8.0) ? true : false
        static let _6 = ((UIDevice.current.systemVersion as NSString).floatValue <= 6.0 ) ? true : false
    }
    
    //Display Size Compatibility
    struct is_Iphone {
        static let _6p = (UIScreen.main.bounds.size.height >= 736.0 ) ? true : false
        static let _6 = (UIScreen.main.bounds.size.height <= 667.0 && UIScreen.main.bounds.size.height > 568.0) ? true : false
        static let _5 = (UIScreen.main.bounds.size.height <= 568.0 && UIScreen.main.bounds.size.height > 480.0) ? true : false
        static let _4 = (UIScreen.main.bounds.size.height <= 480.0) ? true : false
    }
    
   
    struct   local {
        static let LocalDocument = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
}

