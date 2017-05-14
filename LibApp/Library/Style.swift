//
//  Macros.swift
//  WMA
//
//  Created by tasol on 1/1/16.
//  Copyright (c) 2016 tasol. All rights reserved.
//

import Foundation
import UIKit

class Style
{
    func addShadowToView(shadowView : UIView)
    {
        shadowView.layer.cornerRadius = 3.0;
        shadowView.layer.shadowColor = HomeStyle.viewShadowColorInner
        shadowView.layer.shadowOpacity = 0.8;
        shadowView.layer.shadowRadius = 3.0;
        shadowView.layer.shadowOffset = CGSizeMake(-0.5, 0.5);
    }
    
    func addBorderToTextField(textField : UITextField)
    {
        textField.layer.borderWidth = TextFieldStyle.borderWidth
        textField.layer.borderColor = TextFieldStyle.borderColor.CGColor
        textField.backgroundColor = TextFieldStyle.backgroundColor
    }
    
    func setButtonStyle(button : UIButton,title : String)
    {
        button.backgroundColor = ButtonStyle.backgroundColor
        button.layer.cornerRadius = 2.0
        button .contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.titleLabel?.font = UIFont(name: FontStyle.fontName, size: Style().getfontSize(12.0))
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.setTitle(title, forState: .Normal)
        button.layer.shadowColor = ButtonStyle.shadowColor.CGColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowOpacity = 0.7
    }
    
    func setTextViewStyle(textView : UITextView)
    {
        textView.textColor = FontStyle.textColor
        textView.tintColor = FontStyle.textColor
        textView.font = UIFont(name: FontStyle.fontName, size: Style().getfontSize(12.0))
        textView.layer.borderWidth = TextFieldStyle.borderWidth
        textView.layer.borderColor = TextFieldStyle.borderColor.CGColor
        textView.backgroundColor = TextFieldStyle.backgroundColor
        textView.contentInset = UIEdgeInsetsMake(5, 5, 0, 0)
    }
    
    func isIPhone6Plus() -> Bool
    {
        if UIScreen.mainScreen().bounds.size.width == 414
        {
            return true
        }
        return false
    }
   
    func setTextFieldBorder(textField : UITextField)
    {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor(red: 186.0/255.0, green: 186.0/255.0, blue: 186.0/255.0, alpha: 1.0).CGColor
        textField.backgroundColor = TextFieldStyle.backgroundColor
    }

    func setLabelStyle(label : UILabel,TextSize fontSize : CGFloat,Font fontStyle : String,TextColor fontColor : UIColor)
    {
        label.textColor = fontColor
        label.font = UIFont(name: fontStyle, size: Style().getfontSize(fontSize))
    }
    
    func showAlert(Title title : String, Message msg : String)
    {
        let alert : UIAlertView = UIAlertView(title: title, message: msg, delegate: nil, cancelButtonTitle: "Ok")
        alert.show()
    }
    
    func getfontSize(size : CGFloat) -> CGFloat
    {
        let fontSize : CGFloat = UIScreen.mainScreen().bounds.size.width * (size / 320.0)
        return fontSize
    }
}

struct BackGroundStyle
{
    static var mainViewBgColor : UIColor = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1.0)
    static var activityBGColor : UIColor = UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1.0)
    static var containerViewBgColor : UIColor = UIColor.whiteColor()
    static var spinnerColor : UIColor = UIColor(red: 120.0/255.0, green: 191.0/255.0, blue: 94.0/255.0, alpha: 1.0)
    static var whiteColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.8)
    static var readMessageViewColor : UIColor = UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    static var greenBGColor : UIColor = UIColor(red: 120.0/255.0, green: 191.0/255.0, blue: 94.0/255.0, alpha: 1.0)
}

struct TextFieldStyle
{
    static var borderColor : UIColor = UIColor(red: 186.0/255.0, green: 186.0/255.0, blue: 186.0/255.0, alpha: 1.0)
    static var borderWidth : CGFloat = 1.0
    static var backgroundColor : UIColor = UIColor.whiteColor()
}

struct ButtonStyle
{
    static var backgroundColor : UIColor = UIColor(red: 120.0/255.0, green: 191.0/255.0, blue: 94.0/255.0, alpha: 1.0)
    static var shadowColor : UIColor = UIColor(red: 186.0/255.0, green: 186.0/255.0, blue: 186.0/255.0, alpha: 1.0)
}

struct FontStyle
{
    static var fontName : String = "MSReferenceSansSerif"
    static var fontBold : String = "MSReferenceSansSerif-Bold"
    
    static var MoodColor : UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    static var textColor : UIColor = UIColor(red: 56.0/255.0, green: 56.0/255.0, blue: 56.0/255.0, alpha: 1.0)
    static var linkColor : UIColor = UIColor(red: 120.0/255.0, green: 191.0/255.0, blue: 94.0/255.0, alpha: 1.0)
    static var textBlackColor : UIColor = UIColor.blackColor()
    static var textWhiteColor : UIColor = UIColor.whiteColor()
    static var textRedColor : UIColor = UIColor.redColor()
}

struct NavigationBarStyle
{
    static var topGradiantColorBg : UIColor = UIColor(red: 33.0/255.0, green: 33.0/255.0, blue: 33.0/255.0, alpha: 0.9)
    static var bottomGradiantColorBg : UIColor = UIColor(red: 56.0/255.0, green: 56.0/255.0, blue: 56.0/255.0, alpha: 1.0)
    
    static var iphone6PlusNavigationBarHeight : CGFloat = 64.0
    static var navigationBarHeigt   : CGFloat = 44.0
    static var bgImg : UIImage = UIImage(named: "wewe_topbar.png")!
    static var btnMenuBgImg : UIImage = UIImage(named: "wewe_topbar_menu_icon_2.png")!
    static var btnBackBgImg : UIImage = UIImage(named: "wewe_topbar_back_icon.png")!
    static var btnSearchBgImg : UIImage = UIImage(named: "wewe_topbar_search_icon.png")!
    static var btnTagBgImg  : UIImage = UIImage(named: "jom_tag_icon.png")!
    static var topBarLogo : UIImage = UIImage(named: "topbar_logo.png")!
    static var btnVMSwitchBgImg : UIImage = UIImage(named: "vm_market_icon.png")!
    static var btnHomeImg : UIImage = UIImage(named: "jomsocial_home.png")!
    
    // VR TopBar Menu Buttons
    static var btnJomSocialBgImg : UIImage = UIImage(named: "jom_social_icon.png")!
    static var btnRightMenuBgImg : UIImage = UIImage(named: "wewe_topbar_list_icon.png")!
    static var btnCartBGImg : UIImage = UIImage(named: "wewe_topbar_cart_icon.png")!
    static var btnNotificationBGImg : UIImage = UIImage(named: "wewe_topbar_notification.png")!
    
    static var textFieldTextColor : UIColor = UIColor(red: 91.0/255.0, green: 91.0/255.0, blue: 91.0/255.0, alpha: 1.0)
    static var textFieldBottomBorderColor : UIColor = UIColor(red: 63.0/255.0, green: 63.0/255.0, blue: 63.0/255.0, alpha: 1.0)
}

struct HomeStyle
{
    static var viewShadowColorInner = UIColor(red: 164.0/255.0, green: 164.0/255.0, blue: 164.0/255.0, alpha: 1.0).CGColor
}

struct SideMenuStyle
{
    static var tableBGColorForVR = UIColor(red: 226.0 / 255.0, green: 226.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
}

struct ProductDetailStyle
{
    static var viewBorderColor = UIColor(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 1.0)
}

struct EventListStyle
{
    static var subtitletextColor = UIColor(red: 86.0/255.0, green: 86.0/255.0, blue: 86.0/255.0, alpha: 1.0)
}

struct MessageThread
{
    static var rightViewColor = UIColor(red: 215.0/255.0, green: 226.0/255.0, blue: 211.0/255.0, alpha: 1.0)
    static var lableHeaderTextColor = UIColor(red: 121.0 / 255.0, green: 121.0 / 255.0, blue: 121.0 / 255.0, alpha: 1.0)
}

struct groupStyle
{
    static var titleViewColor = UIColor(red: 56.0/255.0, green: 56.0/255.0, blue: 56.0/255.0, alpha: 0.9)
    static var viewHeaderColor = UIColor(red: 186.0/255.0, green: 186.0/255.0, blue: 186.0/255.0, alpha: 1.0)
    static var imgSperatorColor = UIColor(red: 186.0/255.0, green: 186.0/255.0, blue: 186.0/255.0, alpha: 1.0)
    static var subtitletextColor = UIColor(red: 129.0/255.0, green: 129.0/255.0, blue: 129.0/255.0, alpha: 1.0)
    static var ownerBackground = UIColor(red: 66.0/255.0, green: 103.0/255.0, blue: 178.0/255.0, alpha: 1.0)
}
