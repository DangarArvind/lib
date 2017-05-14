//
//  CustomNavigation.swift
//  WMA
//
//  Created by tasol on 1/7/16.
//  Copyright © 2016 tasol. All rights reserved.
//

import UIKit

/**
 This is protocol of CustomNavigation Bar.
 
 ## Method ##
 1. TopBarMenuOptionSelected = this method is used for get the selected option's of Top Navigation bar menu
 2. perFormSearch = This method is used for perform search on respective view controller
 3. searchStatus = This method is for get the Status of Search to hide or show search bar in navigation bar
*/
@objc protocol CustomNavigationDelegate
{
    optional func TopBarMenuOptionSelected(menuIndex : Int)
    optional func perFormSearch(keyword : String)
    optional func searchStatus(isSearching : Bool)
}

/**
 This class is for create custom navigation bar.
*/
class CustomNavigation: UIView, UITextFieldDelegate,TopMenuViewDelegate,UIAlertViewDelegate,weweDataProviderDelegate
{
    var delegate : CustomNavigationDelegate!
    var txtSearch : UITextField!
    var imgFullBg : UIImageView!
    var btnMenu : UIButton!
    var btnBack : UIButton!
    var btnSearch : UIButton!
    
    //MARK: Button Show only in Virtual Mart
    var btnCart : UIButton!
    var btnRightMenu : UIButton!
    var btnJomSocial : UIButton!
    var cartCountBg : UIImageView!
    var lblcartCount : UILabel!
    
    var titleLable : UILabel!
    var rightSideButton : UIButton!
    var topBarIcon : UIImageView!
    
    var arrTopBar : NSArray!
    var rightTopMenuView : TopMenuView!
    var viewName : Int!
    
    //MARK: Jomsocial
    var btnVMSwitch : UIButton!
    var btnTag : UIButton!
    var btnSort : UIButton!
    var sortButtonWidthConstraint : NSLayoutConstraint!
    var rightSideButtonWidthConstraint : NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init()
    {
        if (Style().isIPhone6Plus())
        {
            super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: NavigationBarStyle.iphone6PlusNavigationBarHeight))
        }
        else
        {
            super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: NavigationBarStyle.navigationBarHeigt))
        }
        
        self .setTheme()
    }
    
    /**
     This method is used for set the default theme of navigation view
    */
    func setTheme()
    {
        self.backgroundColor = UIColor.clearColor()
        imgFullBg = UIImageView()
        imgFullBg.backgroundColor = NavigationBarStyle.topGradiantColorBg
        //        imgFullBg.image = NavigationBarStyle.bgImg
        self .addSubview(imgFullBg)
        
        
        imgFullBg.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints(
            [
                NSLayoutConstraint(item: imgFullBg, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: imgFullBg, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: imgFullBg, attribute: .Trailing , relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: imgFullBg, attribute: .Bottom , relatedBy: .Equal, toItem: self, attribute: .Bottom , multiplier: 1.0, constant: 0)
            ])
        
        
        btnMenu = UIButton()
        btnMenu.setImage(NavigationBarStyle.btnMenuBgImg, forState: .Normal)
        btnMenu.contentHorizontalAlignment = .Center
        btnMenu.contentVerticalAlignment   = .Center
        
        btnBack = UIButton()
        btnBack.setImage(NavigationBarStyle.btnBackBgImg, forState: .Normal)
        btnBack.contentHorizontalAlignment = .Center
        btnBack.contentVerticalAlignment   = .Center
        btnBack.addTarget(self, action: "btnBackPressed", forControlEvents: .TouchUpInside)
    }
    
    //MARK: Commont Navigation Methods
    /**
    This method used for show the Title on Navigation bar at Left Side 
    
    ## Parameters ##
    1. title = Caption String which need to show on navigation bar
    */
    func showTitle(title : String)
    {
        titleLable = UILabel()
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLable)
        
        let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let arrController : NSArray = (appDelegate.navigationController.viewControllers)
        
        let totoalController : Int = arrController.count
        let lastIndex : Int = totoalController - 2

        if(arrController[lastIndex + 1] .isKindOfClass(PaymentViewcontroller))
        {
            self .addConstraints(
                [
                    NSLayoutConstraint(item: titleLable, attribute: .Leading, relatedBy: .Equal, toItem: btnMenu, attribute: .Trailing, multiplier: 1.0, constant: -10.0),
                    NSLayoutConstraint(item: titleLable, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                    NSLayoutConstraint(item: titleLable, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.75, constant: 1.0)
                ])
        }
        else
        {
            self .addConstraints(
                [
                    NSLayoutConstraint(item: titleLable, attribute: .Leading, relatedBy: .Equal, toItem: btnMenu, attribute: .Trailing, multiplier: 1.0, constant: 5.0),
                    NSLayoutConstraint(item: titleLable, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                    NSLayoutConstraint(item: titleLable, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.75, constant: 1.0)
                ])
        }
        
        titleLable.text = title
        titleLable.font = UIFont(name: FontStyle.fontName, size: Style().getfontSize(15.0))
        titleLable.numberOfLines = 2
        titleLable.textColor = UIColor.whiteColor()
        titleLable .sizeToFit()
    }
    
    /**
     This method is used for show the Logo in custom navigation bar at left side
    */
    func showTopBarLogo()
    {
        topBarIcon = UIImageView()
        topBarIcon.image = NavigationBarStyle.topBarLogo
        self.addSubview(topBarIcon)
        
        topBarIcon.translatesAutoresizingMaskIntoConstraints = false
        
        self .addConstraints(
            [
                NSLayoutConstraint(item: topBarIcon, attribute: .Leading, relatedBy: .Equal, toItem: btnMenu, attribute: .Trailing, multiplier: 1.0, constant: 5.0),
                NSLayoutConstraint(item: topBarIcon, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
            ])
    }
    
    /**
     This method is used for add the button on right side of navigation bar with title
     ## Parameter ##
     1. title = Caption which show with button
    */
    func showRightSideButton(title : String)
    {
        rightSideButton = UIButton()
        rightSideButton.setTitle(title, forState: .Normal)
        rightSideButton.titleLabel?.font = UIFont(name: FontStyle.fontName, size: Style().getfontSize(12.0))
        rightSideButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        rightSideButton.userInteractionEnabled = true
        
        self.addSubview(rightSideButton)
        
        rightSideButton.translatesAutoresizingMaskIntoConstraints = false
        rightSideButton.setContentHuggingPriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        rightSideButton.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        
        self.addConstraints(
            [
                NSLayoutConstraint(item: rightSideButton, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: rightSideButton, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: -10.0)
            ])
        
        self.layoutIfNeeded()
        
        rightSideButtonWidthConstraint = NSLayoutConstraint(item: rightSideButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: rightSideButton.frame .size .width)
        
        rightSideButton.addConstraint(rightSideButtonWidthConstraint)
    }
    
    /**
     This method is used for show the Menu button at left side for launch the side menu.
     This method will show menu button or back button as per controller's stack in navigation controller.
    */
    func addMenuButton()
    {
        self.addSubview(btnMenu)
        
        btnMenu.translatesAutoresizingMaskIntoConstraints = false
        //btnMenu's Constraint
        self.addConstraints(
            [
                NSLayoutConstraint(item: btnMenu, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: btnMenu, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 5.0),
                NSLayoutConstraint(item: btnMenu, attribute: .Width , relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 30.0/320.0, constant: 0),
                NSLayoutConstraint(item: btnMenu, attribute: .Height , relatedBy: .Equal, toItem: btnMenu, attribute: .Width , multiplier: 1.0, constant: 0)
            ])
        
        
        self.addSubview(btnBack)
        //btnBack's Constraint
        btnBack.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(
            [
                NSLayoutConstraint(item: btnBack, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: btnBack, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 5.0),
                NSLayoutConstraint(item: btnBack, attribute: .Width , relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 30.0/320.0, constant: 0),
                NSLayoutConstraint(item: btnBack, attribute: .Height , relatedBy: .Equal, toItem: btnBack, attribute: .Width , multiplier: 1.0, constant: 0)
            ])
        
        self.sendSubviewToBack(imgFullBg)
        
        let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let arrController : NSArray = (appDelegate.navigationController.viewControllers)
        
        let totoalController : Int = arrController.count
        let lastIndex : Int = totoalController - 2
        
        if (totoalController == 1)
        {
            btnBack.hidden = true
            btnMenu.hidden = false
        }
        else if(arrController[lastIndex] .isKindOfClass(LaunchViewController))
        {
            btnBack.hidden = true
            btnMenu.hidden = false
        }
        else if(arrController[lastIndex + 1] .isKindOfClass(PaymentViewcontroller))
        {
            btnBack.hidden = true
            btnMenu.hidden = true
        }
        else
        {
            btnMenu.hidden = true
            btnBack.hidden = false
        }
        
    }
    
    // Mark : Method to Open Side Drawer
    func btnMenuPressed()
    {
        parentViewController?.view.endEditing(true)
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    // Mark : Method For Add Top Menu on RightSide
    /**
    This method is used for Add Top Menu button to right side of navigation bar.
    */
    func addRightTopMenu(arrOption : NSArray)
    {
        arrTopBar = arrOption
        
        btnRightMenu = UIButton()
        btnRightMenu.setImage(NavigationBarStyle.btnRightMenuBgImg, forState: .Normal)
        btnRightMenu.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        self.btnRightMenu.addTarget(self, action: "btnRightMenuPressed:", forControlEvents: .TouchUpInside)
        self.addSubview(btnRightMenu)
        btnRightMenu.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints(
            [
                NSLayoutConstraint(item: btnRightMenu, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: btnRightMenu, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: btnRightMenu, attribute: .Width , relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 22.0/320.0, constant: 0),
                NSLayoutConstraint(item: btnRightMenu, attribute: .Height , relatedBy: .Equal, toItem: btnRightMenu, attribute: .Width , multiplier: 1.0, constant: 0)
            ])
        
        rightTopMenuView = TopMenuView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height), menuItem: arrOption)
        rightTopMenuView.hidden = true
        rightTopMenuView.delegate = self
    }
    
    // Mark : Method for back
    func btnBackPressed()
    {
        parentViewController?.view.endEditing(true)
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.navigationController .popViewControllerAnimated(true)
    }
    
    
    //MARK: VM Navigation Methods
    //Method For AddButton of VirtualMart Component
    /**
    This method is used to show the Custom navigation according to Virtula mart Commponent.
    */
    func addVirtulMartButton()
    {
        viewName = TopBarViewName.VirtualMartView.rawValue
        
        btnRightMenu = UIButton()
        btnRightMenu.setImage(NavigationBarStyle.btnRightMenuBgImg, forState: .Normal)
        btnRightMenu.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        self.btnRightMenu.addTarget(self, action: "btnRightMenuPressed:", forControlEvents: .TouchUpInside)
        
        btnCart = UIButton()
        btnCart.setImage(NavigationBarStyle.btnCartBGImg, forState: .Normal)
        btnCart.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        btnCart.addTarget(self, action: "btnCartPressed:", forControlEvents: .TouchUpInside)
        
        
        cartCountBg = UIImageView()
        cartCountBg.frame = CGRect(x: btnCart.frame.origin.x + (btnCart.frame.size.width-10), y: btnCart.frame.origin.y-8, width: 16, height: 16)
        cartCountBg.clipsToBounds = true
        cartCountBg.layer.cornerRadius = 8
        cartCountBg.backgroundColor = BackGroundStyle.greenBGColor
        
        lblcartCount = UILabel()
        lblcartCount.frame = cartCountBg.frame
        lblcartCount.font = UIFont(name: FontStyle.fontName, size: Style().getfontSize(8.0))
        lblcartCount.textColor = UIColor.whiteColor()
        lblcartCount.textAlignment = .Center
        
        
        btnSearch = UIButton()
        btnSearch.setImage(NavigationBarStyle.btnSearchBgImg, forState: .Normal)
        btnSearch.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        btnSearch .addTarget(self, action: "btnVirtualMarkSearchPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        btnSearch .hidden = false
        
        
        //btnRightMenu's Constraint
        self.addSubview(btnRightMenu)
        btnRightMenu.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints(
            [
                NSLayoutConstraint(item: btnRightMenu, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: btnRightMenu, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: -5.0),
                NSLayoutConstraint(item: btnRightMenu, attribute: .Width , relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 30.0/320.0, constant: 0),
                NSLayoutConstraint(item: btnRightMenu, attribute: .Height , relatedBy: .Equal, toItem: btnRightMenu, attribute: .Width , multiplier: 1.0, constant: 0)
            ])
        
        //btnCart's Constraint
        self.addSubview(btnCart)
        btnCart.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints(
            [
                NSLayoutConstraint(item: btnCart, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: btnCart, attribute: .Trailing, relatedBy: .Equal, toItem: btnRightMenu, attribute: .Leading, multiplier: 1.0, constant: -5),
                NSLayoutConstraint(item: btnCart, attribute: .Width , relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 30.0/320.0, constant: 0),
                NSLayoutConstraint(item: btnCart, attribute: .Height , relatedBy: .Equal, toItem: btnCart, attribute: .Width , multiplier: 1.0, constant: 0)
            ])
        
        self.addSubview(btnSearch)
        btnSearch.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints(
            [
                NSLayoutConstraint(item: btnSearch, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: btnSearch, attribute: .Trailing, relatedBy: .Equal, toItem: btnCart, attribute: .Leading, multiplier: 1.0, constant: -5),
                NSLayoutConstraint(item: btnSearch, attribute: .Width , relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 30.0/320.0, constant: 0),
                NSLayoutConstraint(item: btnSearch, attribute: .Height , relatedBy: .Equal, toItem: btnSearch, attribute: .Width , multiplier: 1.0, constant: 0)
            ])
        
        self.sendSubviewToBack(imgFullBg)
        
        let cartCount : Int = (VirtualMartDataProvider.sharedInstance.getCartProduct() as NSMutableArray).count
        if cartCount != 0
        {
            lblcartCount.text = "\(cartCount)"
            
            //cartCountBg Constraint
            self.addSubview(cartCountBg)
            cartCountBg.translatesAutoresizingMaskIntoConstraints = false
            self.addConstraints(
                [
                    NSLayoutConstraint(item: cartCountBg, attribute: .Bottom, relatedBy: .Equal, toItem: btnCart, attribute: .Top, multiplier: 1.0, constant: 12),
                    NSLayoutConstraint(item: cartCountBg, attribute: .Trailing, relatedBy: .Equal, toItem: btnCart, attribute: .Trailing, multiplier: 1.0, constant: 5),
                    NSLayoutConstraint(item: cartCountBg, attribute: .Width , relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: 16.0),
                    NSLayoutConstraint(item: cartCountBg, attribute: .Height , relatedBy: .Equal, toItem: nil, attribute: .Width , multiplier: 1.0, constant: 16.0)
                ])
            
            self.addSubview(lblcartCount)
            lblcartCount.translatesAutoresizingMaskIntoConstraints = false
            self.addConstraints(
                [
                    NSLayoutConstraint(item: lblcartCount, attribute: .CenterX, relatedBy: .Equal, toItem: cartCountBg, attribute: .CenterX, multiplier: 1.0, constant: 0.0),
                    NSLayoutConstraint(item: lblcartCount, attribute: .CenterY, relatedBy: .Equal, toItem: cartCountBg, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
                ])
        }
        
        
        let arrMenuTitle : NSMutableArray = []
        arrTopBar = ApplicationConfiguration.sharderInstance.getMenuListFromDatabaseForView(MenuPosition.VRTOPMENUBARPOSITION, forView: MenuViewName.TOPBARVIRTUALMART) as NSArray
        let userDefault : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        for item in arrTopBar
        {
            let dicMenuDetail : NSDictionary = item as! NSDictionary
            
            let dicDetail : NSDictionary = dicMenuDetail.objectForKey(DatabaseConstant.TAG_MENUITEM_TABLE_DETAIL) as! NSDictionary
            
            if userDefault.valueForKey(LoginConstant.IS_LOGGEDIN) != nil
            {
                if dicDetail.valueForKey(DatabaseConstant.TAG_MENU_ITEM_CAPTION) as! String == "Login" && userDefault.valueForKey(LoginConstant.IS_LOGGEDIN) as? Bool == true
                {
                    arrMenuTitle.addObject(NavigationBarMenuItem(MenuName: "Logout", MenuTag: Int(dicDetail.valueForKey(DatabaseConstant.TAG_MENU_ITEM_ID) as! String)!))
                }
                else
                {
                    arrMenuTitle.addObject(NavigationBarMenuItem(MenuName: dicDetail.valueForKey(DatabaseConstant.TAG_MENU_ITEM_CAPTION) as! String, MenuTag: Int(dicDetail.valueForKey(DatabaseConstant.TAG_MENU_ITEM_ID) as! String)!))
                }
            }
            else
            {
                arrMenuTitle.addObject(NavigationBarMenuItem(MenuName: dicDetail.valueForKey(DatabaseConstant.TAG_MENU_ITEM_CAPTION) as! String, MenuTag: Int(dicDetail.valueForKey(DatabaseConstant.TAG_MENU_ITEM_ID) as! String)!))
            }
        }
        
        rightTopMenuView = TopMenuView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height), menuItem: arrMenuTitle)
        rightTopMenuView.hidden = true
        rightTopMenuView.delegate = self
    }
    
    // Method for add Jomsocial Switch Button in VM
    /**
    This method is for add the Button for Switch to Jom Social Commonet from Virtul Mart
    */
    func showJomSocialSwitch()
    {
        btnJomSocial = UIButton()
        btnJomSocial.setImage(NavigationBarStyle.btnJomSocialBgImg, forState: .Normal)
        btnJomSocial.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        
        self.addSubview(btnJomSocial)
        
        btnJomSocial.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints(
            [
                NSLayoutConstraint(item: btnJomSocial, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: btnJomSocial, attribute: .Trailing, relatedBy: .Equal, toItem: btnSearch, attribute: .Leading, multiplier: 1.0, constant: -5),
                NSLayoutConstraint(item: btnJomSocial, attribute: .Width , relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 30.0/320.0, constant: 0),
                NSLayoutConstraint(item: btnJomSocial, attribute: .Height , relatedBy: .Equal, toItem: btnJomSocial, attribute: .Width , multiplier: 1.0, constant: 0)
            ])
    }
    
    //Method for reload the top Right menu options
    /**
    This method is used to Reload the Top Menu option.
    */
    func reloadRightTopMenuOption()
    {
        let arrMenuTitle : NSMutableArray = []
        arrTopBar = ApplicationConfiguration.sharderInstance.getMenuListFromDatabaseForView(MenuPosition.VRTOPMENUBARPOSITION, forView: MenuViewName.TOPBARVIRTUALMART) as NSArray
        
        let userDefault : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        for item in arrTopBar
        {
            let dicMenuDetail : NSDictionary = item as! NSDictionary
            
            let dicDetail : NSDictionary = dicMenuDetail.objectForKey(DatabaseConstant.TAG_MENUITEM_TABLE_DETAIL) as! NSDictionary
            
            if userDefault.valueForKey(LoginConstant.IS_LOGGEDIN) != nil
            {
                if dicDetail.valueForKey(DatabaseConstant.TAG_MENU_ITEM_CAPTION) as! String == "Login" && userDefault.valueForKey(LoginConstant.IS_LOGGEDIN) as? Bool == true
                {
                    arrMenuTitle.addObject(NavigationBarMenuItem(MenuName: "Logout", MenuTag: Int(dicDetail.valueForKey(DatabaseConstant.TAG_MENU_ITEM_ID) as! String)!))
                }
                else
                {
                    arrMenuTitle.addObject(NavigationBarMenuItem(MenuName: dicDetail.valueForKey(DatabaseConstant.TAG_MENU_ITEM_CAPTION) as! String, MenuTag: Int(dicDetail.valueForKey(DatabaseConstant.TAG_MENU_ITEM_ID) as! String)!))
                }
            }
            else
            {
                arrMenuTitle.addObject(NavigationBarMenuItem(MenuName: dicDetail.valueForKey(DatabaseConstant.TAG_MENU_ITEM_CAPTION) as! String, MenuTag: Int(dicDetail.valueForKey(DatabaseConstant.TAG_MENU_ITEM_ID) as! String)!))
            }
        }
        
        rightTopMenuView.arrMenuItem = arrMenuTitle
        rightTopMenuView.tblMenu.reloadData()
    }
    
    func btnRightMenuPressed(sender : UIButton)
    {
        if arrTopBar.count > 0
        {
            rightTopMenuView.hidden = false
            parentViewController?.view.addSubview(rightTopMenuView)
        }
    }
    
    //Method for Update the Cart Count
    func updateCartCount()
    {
        let cartCount : Int = ApplicationData.sharedInstance.cartCount
        if cartCount != 0
        {
            if cartCountBg.superview == nil
            {
                self.addSubview(cartCountBg)
                cartCountBg.translatesAutoresizingMaskIntoConstraints = false
                self.addConstraints(
                    [
                        NSLayoutConstraint(item: cartCountBg, attribute: .Bottom, relatedBy: .Equal, toItem: btnCart, attribute: .Top, multiplier: 1.0, constant: 12),
                        NSLayoutConstraint(item: cartCountBg, attribute: .Trailing, relatedBy: .Equal, toItem: btnCart, attribute: .Trailing, multiplier: 1.0, constant: 5),
                        NSLayoutConstraint(item: cartCountBg, attribute: .Width , relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: 16.0),
                        NSLayoutConstraint(item: cartCountBg, attribute: .Height , relatedBy: .Equal, toItem: nil, attribute: .Width , multiplier: 1.0, constant: 16.0)
                    ])
                
                self.addSubview(lblcartCount)
                lblcartCount.translatesAutoresizingMaskIntoConstraints = false
                self.addConstraints(
                    [
                        NSLayoutConstraint(item: lblcartCount, attribute: .CenterX, relatedBy: .Equal, toItem: cartCountBg, attribute: .CenterX, multiplier: 1.0, constant: 0.0),
                        NSLayoutConstraint(item: lblcartCount, attribute: .CenterY, relatedBy: .Equal, toItem: cartCountBg, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
                    ])
            }
            lblcartCount.text = "\(cartCount)"
        }
        else
        {
            cartCountBg.removeFromSuperview()
            lblcartCount.removeFromSuperview()
        }
    }
    
    // Method for hide the CartButton
    func hideCartButton()
    {
        lblcartCount.hidden = true
        btnCart.hidden = true
        cartCountBg.hidden = true
        
        btnSearch.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints(
            [
                NSLayoutConstraint(item: btnSearch, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: btnSearch, attribute: .Trailing, relatedBy: .Equal, toItem: btnRightMenu, attribute: .Leading, multiplier: 1.0, constant: -5.0),
                NSLayoutConstraint(item: btnSearch, attribute: .Width , relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 30.0/320.0, constant: 0),
                NSLayoutConstraint(item: btnSearch, attribute: .Height , relatedBy: .Equal, toItem: btnSearch, attribute: .Width , multiplier: 1.0, constant: 0)
            ])
        
    }
    
    // Mark : Method for open cart
    /**
    This is action method of button Cart for launch the Cart from navigation bar
    */
    func btnCartPressed(sender : UIButton)
    {
        parentViewController?.view.endEditing(true)
        let storyboard : UIStoryboard = UIStoryboard(name: "vm_Main", bundle: nil)
        let controller : CartViewController = storyboard.instantiateViewControllerWithIdentifier("CartViewController") as! CartViewController
        controller.isPaymentDone = false
        let arr : NSArray = NSArray(object: controller)
        
        let navigationController : UINavigationController = parentViewController!.mm_drawerController.centerViewController as! UINavigationController
        navigationController.viewControllers = arr as! [UIViewController]
        navigationController.navigationBarHidden = true
        navigationController .popToRootViewControllerAnimated(true)
    }
    
    //MARK: JomSocial Navigation Methods
    /**
    This method is used for add the sort button at right side of navigation in Jom Social Component.
    */
    func showSortButton()
    {
        btnSort = UIButton()
        btnSort.userInteractionEnabled = true
        btnSort .setImage(UIImage(named: "wewe_topbar_sort_icon.png"), forState: .Normal)
       
        self.addSubview(btnSort)
        btnSort.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints(
            [
                NSLayoutConstraint(item: btnSort, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: btnSort, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .TrailingMargin, multiplier: 1.0, constant: 5.0),
                NSLayoutConstraint(item: btnSort, attribute: .Height, relatedBy: .Equal, toItem: btnSort, attribute: .Width, multiplier: 1.0, constant: 0.0)
            ])
        
        
        sortButtonWidthConstraint = NSLayoutConstraint(item: btnSort, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: 30.0)
        sortButtonWidthConstraint.constant = UIScreen.mainScreen().bounds.size.width * (30.0/320.0)
        sortButtonWidthConstraint.identifier = "Hello"
        self.addConstraint(sortButtonWidthConstraint)
    }
    
    /// This method is for hide the Sort button form navigation bar
    func hideSortButton()
    {
        btnSort.hidden = true
        btnSort .setImage(UIImage(named: ""), forState: .Normal)
        sortButtonWidthConstraint.constant = 0
        
    }
    
    /// This method is for show the sort button from navigation bar
    func unhideSortButton()
    {
        btnSort.hidden = false
        sortButtonWidthConstraint.constant = UIScreen.mainScreen().bounds.size.width * (30.0/320.0)
        btnSort .setImage(UIImage(named: "wewe_topbar_sort_icon.png"), forState: .Normal)
    }
    
    //MARK: VirtualMart Search Button Pressed
    /// This is action method of search button in Virtul Mart for Open Search View in VM
    func btnVirtualMarkSearchPressed(sender : UIButton)
    {
        let storyboard : UIStoryboard = UIStoryboard(name: "vm_Main", bundle: nil)
        let controller : SearchViewController = storyboard.instantiateViewControllerWithIdentifier("SearchViewController") as! SearchViewController
        
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.navigationController.pushViewController(controller, animated: true)
        
    }
    
    // Mark : JomSocial Search Button Pressed
    /// This is action method of Search Button for Jom Social Commponet
    func btnJomSocialSearchPressed(sender : UIButton)
    {
        if txtSearch.text == ""
        {
            if self.txtSearch.hidden
            {
                self.txtSearch.alpha = 0
                UIView.animateWithDuration(1.0, animations:
                    {
                        self.txtSearch.alpha = 1
                        self.txtSearch.hidden = false
                        self.bringSubviewToFront(self.txtSearch)
                        if self.titleLable != nil
                        {
                            self.titleLable.hidden = true
                        }
                        
                        if self.topBarIcon != nil
                        {
                            self.topBarIcon.hidden = true
                        }
                        self.txtSearch.becomeFirstResponder()
                        
                        if (self.delegate != nil)
                        {
                            self.delegate .searchStatus!(true)
                        }
                    }, completion: { finished in
                        
                })
            }
            else
            {
                UIView.animateWithDuration(1.0, animations:
                    {
                        self.txtSearch.alpha = 0.0
                        self.txtSearch.resignFirstResponder()
                    }, completion: { finished in
                        
                        self.txtSearch.hidden = true
                        if self.titleLable != nil
                        {
                            self.titleLable.hidden = false
                        }
                        
                        if self.topBarIcon != nil
                        {
                            self.topBarIcon.hidden = false
                        }
                        
                        if (self.delegate != nil)
                        {
                            self.delegate .searchStatus!(false)
                        }
                })
            }
        }
        else
        {
            if (delegate != nil)
            {
                delegate .perFormSearch!(txtSearch.text!)
            }
        }
    }
    
    // Mark : Method to Show Tag Button
    /// This method is for add The Tag Button on Navigation bar in Jom Social Commponet for Launch list of Taged user
    func showTagButton(isRightSideButton : Bool)
    {
        btnTag = UIButton()
        btnTag .setImage(NavigationBarStyle.btnTagBgImg, forState: .Normal)
        btnTag .contentHorizontalAlignment = .Center
        
        self.addSubview(btnTag)
        btnTag.translatesAutoresizingMaskIntoConstraints = false
        
        if isRightSideButton == true
        {
            self.addConstraints(
                [
                    NSLayoutConstraint(item: btnTag, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                    NSLayoutConstraint(item: btnTag, attribute: .Trailing, relatedBy: .Equal, toItem: btnRightMenu, attribute: .Leading, multiplier: 1.0, constant: 5.0)
                ])
        }
        else
        {
            self.addConstraints(
                [
                    NSLayoutConstraint(item: btnTag, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                    NSLayoutConstraint(item: btnTag, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: -5.0)
                ])
        }
    }
    
    //MARK: Method to Show Search Button
    /**
    This method is used for show the search bar in navigation bar
    */
    func showSearchBar(rightButton : UIButton,isRightSidebtn : Bool,textFieldCaption : String)
    {
        btnSearch = UIButton()
        btnSearch.setImage(NavigationBarStyle.btnSearchBgImg, forState: .Normal)
        btnSearch.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        btnSearch .addTarget(self, action: "btnJomSocialSearchPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        btnSearch .hidden = true
        
        self.addSubview(btnSearch)
        btnSearch.translatesAutoresizingMaskIntoConstraints = false
        
        
        if isRightSidebtn == true
        {
            self.addConstraints(
                [
                    NSLayoutConstraint(item: btnSearch, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                    NSLayoutConstraint(item: btnSearch, attribute: .Trailing, relatedBy: .Equal, toItem: rightButton, attribute: .Leading, multiplier: 1.0, constant: -3.0),
                    NSLayoutConstraint(item: btnSearch, attribute: .Width , relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 30.0/320.0, constant: 0),
                    NSLayoutConstraint(item: btnSearch, attribute: .Height , relatedBy: .Equal, toItem: btnSearch, attribute: .Width , multiplier: 1.0, constant: 0)
                ])
        }
        else
        {
            self.addConstraints(
                [
                    NSLayoutConstraint(item: btnSearch, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                    NSLayoutConstraint(item: btnSearch, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: -5.0),
                    NSLayoutConstraint(item: btnSearch, attribute: .Width , relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 30.0/320.0, constant: 0),
                    NSLayoutConstraint(item: btnSearch, attribute: .Height , relatedBy: .Equal, toItem: btnSearch, attribute: .Width , multiplier: 1.0, constant: 0)
                ])
        }
    
        
        txtSearch = UITextField()
        txtSearch.frame = CGRect(x: btnSearch.frame.origin.x + btnSearch.frame.size.width, y: (btnSearch.frame.origin.y + btnSearch.frame.size.height) - 25 , width:UIScreen.mainScreen().bounds.size.width - (btnSearch.frame.origin.x + btnSearch.frame.size.width + 10) , height: 25)
        txtSearch.delegate = self
        txtSearch.borderStyle = .None
        txtSearch.textColor = FontStyle.textWhiteColor
        txtSearch.font = UIFont(name: FontStyle.fontName, size: Style().getfontSize(12.0))
        txtSearch.tintColor = FontStyle.textWhiteColor
        txtSearch.clearButtonMode = .WhileEditing
        txtSearch.hidden = true
        txtSearch.placeholder = textFieldCaption
        NSUtil.addPaddingOnTextField(txtSearch)
        
        let txtSearchBottomBorder : CALayer = CALayer()
        txtSearchBottomBorder.frame = CGRect(x: 0, y: txtSearch.frame.size.height-1, width: txtSearch.frame.size.width, height: 1.0)
        txtSearchBottomBorder.backgroundColor = UIColor.whiteColor().CGColor
        txtSearch.layer .addSublayer(txtSearchBottomBorder)
        self.addSubview(txtSearch)
        
        txtSearch.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints(
            [
                NSLayoutConstraint(item: txtSearch, attribute: .Leading, relatedBy: .Equal, toItem: btnMenu, attribute: .Trailing, multiplier: 1.0, constant: 5.0),
                NSLayoutConstraint(item: txtSearch, attribute: .Trailing, relatedBy: .Equal, toItem: btnSearch, attribute: .Leading, multiplier: 1.0, constant: -5.0),
                NSLayoutConstraint(item: txtSearch, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 25.0/44.0, constant: 0.0),
                NSLayoutConstraint(item: txtSearch, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
            ])
    }
    
    //MARK: Method for hide the SearchBar
    /**
    This method is used for hide the SearchBar from Navigation Bar
    */
    func hideSearchBar()
    {
        
        if txtSearch != nil
        {
            self.txtSearch.text = ""
            self.txtSearch.alpha = 0.0
            txtSearch.hidden = true
        }
        
        if titleLable != nil
        {
            titleLable.hidden = false
        }
        
        if topBarIcon != nil
        {
            topBarIcon.hidden = false
        }
        
        
        if (delegate != nil)
        {
            delegate .searchStatus!(false)
        }
    }
    
    //MARK: Method for Hide the SearchButton
    /// This method is used for hide the Search Button on Navigation Bar
    func hideSearchButton()
    {
        if (btnSearch != nil)
        {
            btnSearch.hidden = true
        }
    }
    
    /// This method is used for show the Search Button on Navigation Bar
    func showSearchButton()
    {
        if(btnSearch != nil)
        {
            btnSearch.hidden = false
        }
    }
    
    /// This method is used for show VirtulMart Switch button on Navigation Bar
    func showVMSwitch()
    {
        btnVMSwitch = UIButton()
        btnVMSwitch.setImage(NavigationBarStyle.btnVMSwitchBgImg, forState: .Normal)
        btnVMSwitch.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        
        self.addSubview(btnVMSwitch)
        
        btnVMSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints(
            [
                NSLayoutConstraint(item: btnVMSwitch, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: btnVMSwitch, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: -5),
                NSLayoutConstraint(item: btnVMSwitch, attribute: .Width , relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 30.0/320.0, constant: 0),
                NSLayoutConstraint(item: btnVMSwitch, attribute: .Height , relatedBy: .Equal, toItem: btnVMSwitch, attribute: .Width , multiplier: 1.0, constant: 0)
            ])
    }
    
    func showHome()
    {
        btnVMSwitch = UIButton()
        btnVMSwitch.setImage(NavigationBarStyle.btnHomeImg, forState: .Normal)
        btnVMSwitch.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        
        self.addSubview(btnVMSwitch)
        
        btnVMSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints(
            [
                NSLayoutConstraint(item: btnVMSwitch, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: btnVMSwitch, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: -5),
                NSLayoutConstraint(item: btnVMSwitch, attribute: .Width , relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 30.0/320.0, constant: 0),
                NSLayoutConstraint(item: btnVMSwitch, attribute: .Height , relatedBy: .Equal, toItem: btnVMSwitch, attribute: .Width , multiplier: 1.0, constant: 0)
            ])
    }

    
    //MARK: TextField Delegate Method
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField .resignFirstResponder()
        
        if textField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == ""
        {
            self.hideSearchBar()
        }
        return true
    }
    
    //MARK: Top Bar Menu Delegate Method
    func topMenuOptionSelected(selectedBtnIndext: Int, selectedMenuTag: Int)
    {
        switch(viewName)
        {
        case TopBarViewName.AlbumDetailView.rawValue :
            if (delegate != nil)
            {
                delegate .TopBarMenuOptionSelected!(selectedMenuTag)
            }
            break
        case TopBarViewName.VideoDetailView.rawValue :
            if (delegate != nil)
            {
                delegate .TopBarMenuOptionSelected!(selectedMenuTag)
            }
            break
        case TopBarViewName.ProfileView.rawValue :
            if (delegate != nil)
            {
                delegate .TopBarMenuOptionSelected!(selectedMenuTag)
            }
            break
        case TopBarViewName.GroupDetailView.rawValue :
            if (delegate != nil)
            {
                delegate .TopBarMenuOptionSelected!(selectedMenuTag)
            }
            break
            
        case TopBarViewName.EventDetailView.rawValue :
            if (delegate != nil)
            {
                delegate .TopBarMenuOptionSelected!(selectedMenuTag)
            }
            break
        case TopBarViewName.InviteFriendView.rawValue :
            if (delegate != nil)
            {
                delegate .TopBarMenuOptionSelected!(selectedMenuTag)
            }
            break
        case TopBarViewName.DiscussionDetailView.rawValue :
            if (delegate != nil)
            {
                delegate .TopBarMenuOptionSelected!(selectedMenuTag)
            }
            break
        case TopBarViewName.AnnouncementDetailView.rawValue :
            if (delegate != nil)
            {
                delegate .TopBarMenuOptionSelected!(selectedMenuTag)
            }
            break
        case TopBarViewName.FriendSearchView.rawValue :
            if (delegate != nil)
            {
                delegate .TopBarMenuOptionSelected!(selectedMenuTag)
            }
            break
        case TopBarViewName.VirtualMartView.rawValue :
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let menuDetail : NSDictionary = (arrTopBar.objectAtIndex(selectedBtnIndext).objectForKey("ThemeDetails") as! NSArray).objectAtIndex(0) as! NSDictionary
            
            let userDefault : NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            if( arrTopBar.objectAtIndex(selectedBtnIndext).objectForKey("MenuItemsDetails")?.valueForKey(DatabaseConstant.TAG_MENU_ITEM_CAPTION) as! String == "Login" && userDefault.valueForKey(LoginConstant.IS_LOGGEDIN) as? Bool == true )
            {
                let logoutAlert : UIAlertView = UIAlertView(title: "", message: "Are you sure to Logout?", delegate: self, cancelButtonTitle: "NO", otherButtonTitles: "YES")
                logoutAlert.show()
            }
            else
            {
                let arrViewList : NSArray = ApplicationConfiguration.sharderInstance.getViewListFromDataPlistFile()
                
                for item in arrViewList
                {
                    let viewDetail : NSDictionary = item as! NSDictionary
                    
                    let className : NSString = viewDetail .allKeys.first as! String
                    let arrViewDetail : NSArray = viewDetail.objectForKey(className) as! NSArray
                    
                    let viewName : String = menuDetail .valueForKey(DatabaseConstant.TAG_THEME_VIEWNAME) as! String
                    
                    if viewName == arrViewDetail.objectAtIndex(1) as! String
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: arrViewDetail.lastObject as! String, bundle: nil)
                        let controller = storyBoard .instantiateViewControllerWithIdentifier(className as String)
                        
                        if className == "LoginViewController"
                        {
                            appDelegate.navigationController.pushViewController(controller, animated: true)
                        }
                        else
                        {
                            if parentViewController!.isKindOfClass(controller.classForCoder)
                            {
                                print("Same class")
                            }
                            else
                            {
                                let arr : NSArray = NSArray(object: controller)
                                
                                let navigationController : UINavigationController = parentViewController!.mm_drawerController.centerViewController as! UINavigationController
                                navigationController.viewControllers = arr as! [UIViewController]
                                navigationController.navigationBarHidden = true
                                navigationController .popToRootViewControllerAnimated(true)
                            }
                        }
                    }
                }
            }
            break
        default :
            
            break
        }
        rightTopMenuView.removeFromSuperview()
    }
    
    //MARK: UIAlertView Delegate Method
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if buttonIndex == alertView.cancelButtonIndex
        {
            alertView .dismissWithClickedButtonIndex(buttonIndex, animated: true)
        }
        else
        {
            for subView in (parentViewController?.view.subviews)!
            {
                if let spinner = subView as? UIActivityIndicatorView
                {
                    parentViewController?.view.userInteractionEnabled = false
                    spinner.startAnimating()
                }
            }
            
            weweDataProvider.sharedInstanceWithDelegate(self).processLogout()
        }
    }
    
    //Mark : weweDataProviderDelegate Method
    func dataRecievedFromServer(responseData: NSDictionary, withExtTask task: NSString)
    {
        if task == LoginConstant.TAG_TASK_LOGOUT
        {
            if(responseData .valueForKey(CommonConstant.TAG_CODE) as! String == "200")
            {
                FBSDKLoginManager().logOut()
                let appDomain : NSString = NSBundle.mainBundle().bundleIdentifier!
                NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain as String)
                ApplicationData.sharedInstance.cartCount = 0

                if viewName != TopBarViewName.VirtualMartView.rawValue
                {
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller : LoginViewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                    parentViewController?.navigationController?.pushViewController(controller, animated: true)
                }
                else if viewName == TopBarViewName.VirtualMartView.rawValue
                {
                    let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    let storyboard : UIStoryboard = UIStoryboard(name: "vm_Main", bundle: nil)
                    
                    let controller : VR_HomeViewController = storyboard.instantiateViewControllerWithIdentifier("VR_HomeViewController") as! VR_HomeViewController
                    
                    let arr : NSArray = NSArray(object: controller)
                    let navigationController : UINavigationController = appDelegate.navigationController
                    navigationController.viewControllers = arr as! [UIViewController]
                    navigationController.navigationBarHidden = true
                    navigationController .popToRootViewControllerAnimated(true)
                }
                
                self.reloadRightTopMenuOption()
            }
            else if(responseData.valueForKey(CommonConstant.TAG_CODE) as! String == "204")
            {
                
            }
            else if(responseData.valueForKey(CommonConstant.TAG_CODE) as! String == "1111")
            {
                let connectionAlert : UIAlertView = UIAlertView(title: "Alert", message: "Network connection lost.", delegate: nil, cancelButtonTitle: "Ok")
                connectionAlert.show()
            }
            else
            {
                ErrorHandler().hasError(responseData)
            }
        }
        
        for subView in (parentViewController?.view.subviews)!
        {
            if let spinner = subView as? UIActivityIndicatorView
            {
                parentViewController?.view.userInteractionEnabled = true
                spinner.stopAnimating()
            }
        }
    }
    
}
