//
//  StaticClass.swift
//  SwiftDemo
//
//  Created by TopsTech on 02/03/2015.
//  Copyright (c) 2015 tops. All rights reserved.
//

import UIKit
import AJNotificationView
import NotificationCenter
class StaticClass {
    
    static let sharedInstance: StaticClass = { StaticClass() }()
    
    
    // MARK: - Save to NSUserdefault
    func saveToUserDefaults (value: AnyObject?, forKey key: NSString) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key as String)
        defaults.synchronize()
    }
    
    func retriveFromUserDefaults (key: NSString) -> AnyObject? {
        let defaults = UserDefaults.standard
        if(defaults.value(forKey: key as String) != nil){
            print(defaults.value(forKey: key as String))
        }else{
            return "" as AnyObject?
        }
        
        return defaults.value(forKey: key as String) as AnyObject?
    }
    
    // MARK: - Validation
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailText = NSPredicate(format:"SELF MATCHES [c]%@",emailRegex)
        return (emailText.evaluate(with: email))
    }
    
    func showAlert(title:String,message:String,controller:UIViewController)
    {
        let alert = UIAlertController(title:title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
    
//    func notification(color:String,message:String){
//        
//        var type:AJNotificationType = AJNotificationTypeGreen
//        if(color == "Red"){
//            type = AJNotificationTypeRed
//        }else if(color == "Green"){
//            type = AJNotificationTypeGreen
//        }
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        
//       AJNotificationView.showNotice(in: appDelegate.window, type: type, title: message, linedBackground: AJLinedBackgroundTypeStatic, hideAfter: 3, offset: 00, delay: 0.5) { () -> Void in
//        
//        }
    
 //   }
   
    /*func removeTimeFromDate (date: NSDate) -> NSDate {
        let calendarObj: NSCalendar = NSCalendar.autoupdatingCurrentCalendar()
        
        let dateComponentsObj = calendarObj.components([.NSDayCalendarUnit, .NSMonthCalendarUnit, .NSYearCalendarUnit] , fromDate: date)
        dateComponentsObj.hour = 00
        dateComponentsObj.minute = 00
        dateComponentsObj.second = 00
        
        return calendarObj.dateFromComponents(dateComponentsObj)! as NSDate
    }
    
    func getMonthFromDate (date: NSDate) -> Int {
        let components = NSCalendar.currentCalendar().components([.Hour, .Minute, .Month, .Year, .Day], fromDate: date)
        return components.month as Int
    }
    
    func getYearFromDate (date: NSDate) -> NSInteger {
        let components = NSCalendar.currentCalendar().components([.Hour, .Minute, .Month, .Year, .Day], fromDate: date)
        return components.year as NSInteger
    }
    */
    // MARK: - General Methods
    func removeNull (str:String) -> String {
        if (str == "<null>" || str == "(null)" || str == "N/A" || str == "n/a" || str.isEmpty) {
            return ""
        } else {
            return str
        }
    }
    
    func setPrefixHttp (str:NSString) -> NSString {
        if (str == "" || str .hasPrefix("http://") || str .hasPrefix("https://")) {
            return str
        } else {
            let http:NSString = "http://"
            return http.appending(str as String) as NSString
        }
    }
    
    func isconnectedToNetwork() -> Bool {
       /* let reachability = Reachability.reachabilityForInternetConnection()
        
        if !reachability.isReachable() {
            AlertView().showAlertWithOKButton(self.setLocalizeText("keyInternetConnectionError"), withType: AJNotificationTypeRed)
        }
        
        return reachability.isReachable()*/
        return true
    }
    
        
    func getUIColorFromRBG (R rVal: CGFloat, G gVal: CGFloat, B bVal: CGFloat) -> UIColor {
        return UIColor(red: rVal/255.0, green: gVal/255.0, blue: bVal/255.0, alpha: 1.0)
    }
    
    func getUIColorFromRBGAlpha (R rVal: CGFloat, G gVal: CGFloat, B bVal: CGFloat, Alpha alpha: CGFloat) -> UIColor {
        return UIColor(red: rVal/255.0, green: gVal/255.0, blue: bVal/255.0, alpha: alpha)
    }
    
    func getSizeFromString (str: NSString, stringWidth width: CGFloat, fontname font: UIFont, minimumHeight minHeight: CGFloat) -> CGSize {
        
        let height: CGFloat = 100000
        let labelBounds: CGRect = str.boundingRect(with: CGSize(width: width, height: height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil) as CGRect
        
        if(labelBounds.size.height < minHeight) {
            return CGSize(width:CGFloat(ceilf(Float(labelBounds.size.width))), height: minHeight)
        }
        
        return CGSize(width:CGFloat(ceilf(Float(labelBounds.size.width))),height: CGFloat(ceilf(Float(labelBounds.size.height))))
    }
    
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func loadFromNibNamed(nibNamed: String) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: Bundle.main
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: "\(Global.local.LocalDocument)/MyFolder/\(path)")
        if image == nil {
            print("missing image at: \(path)")
        }
        print("Loading image from path: \(path)") // this is just for you to see the path in case you want to go to the directory, using Finder.
        return image
    }
    
    func colorWithHexString (hex:String,alpha:CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
        
    }
   
    
    func getSideBarWidth()->CGFloat{
            return 365
    }
    
    func get2DecimalPoint(percent:Double) -> Double {
        let numberOfPlaces = 2.0
        let multiplier = pow(10.0, numberOfPlaces)
        let num = percent
        let roundPer = round(Double(percent) * Double(multiplier)) / Double(multiplier)
        return roundPer;
    }
    
    func addShadowToView(shadowView : UIView)
    {
        shadowView.layer.cornerRadius = 3.0;
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.9;
        shadowView.layer.shadowRadius = 3.0;
        shadowView.layer.shadowOffset = CGSize(width: -0.5, height: 0.5)
    }

    struct HomeStyle
    {
        static var viewShadowColorInner = UIColor(red: 164.0/255.0, green: 164.0/255.0, blue: 164.0/255.0, alpha: 1.0).cgColor
    }
       
}


