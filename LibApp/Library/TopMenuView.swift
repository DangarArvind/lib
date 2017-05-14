//
//  TopMenuView.swift
//  WMA
//
//  Created by tasol on 2/3/16.
//  Copyright © 2016 tasol. All rights reserved.
//

import UIKit

protocol TopMenuViewDelegate
{
    func topMenuOptionSelected(selectedBtnIndext : Int,selectedMenuTag : Int)
}

class TopMenuView: UIView,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate
{
    var delegate : TopMenuViewDelegate!
    var arrMenuItem : NSArray!
    var tblMenu : UITableView!
    var tapGesture : UITapGestureRecognizer!
    var menuView : UIView!
    
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }

    init(frame : CGRect,menuItem : NSArray)
    {
        super.init(frame : frame)
        arrMenuItem = menuItem
        self.setTheme()
    }
    
    func setTheme()
    {
        self.backgroundColor = UIColor.clearColor()

        tapGesture = UITapGestureRecognizer(target: self, action: "tapGestureHandle:")
        tapGesture.delegate = self
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    
    
        let menuWidth : CGFloat = UIScreen.mainScreen().bounds.size.width * (180.0/320.0)
        let rowHeight : CGFloat = UIScreen.mainScreen().bounds.size.width * (30.0/320.0)
        
        if arrMenuItem.count <= 6
        {
            menuView = UIView(frame: CGRect(x: UIScreen.mainScreen().bounds.size.width-menuWidth, y: 5, width: menuWidth, height: (CGFloat(arrMenuItem.count) * rowHeight) + 10))
        }
        else
        {
            menuView = UIView(frame: CGRect(x: UIScreen.mainScreen().bounds.size.width-menuWidth, y: 5, width: menuWidth, height: (6 * rowHeight) + 10))
        }
        
        if Style().isIPhone6Plus()
        {
            menuView.frame.origin.y =  NavigationBarStyle.iphone6PlusNavigationBarHeight
        }
        else
        {
            menuView.frame.origin.y = NavigationBarStyle.navigationBarHeigt
        }
        
        self.addSubview(menuView)
        menuView.backgroundColor = BackGroundStyle.activityBGColor
        
        tblMenu = UITableView(frame: CGRect(x: 5, y: 5, width: menuView.frame.size.width-10, height: menuView.frame.size.height-10), style: UITableViewStyle.Plain)
        tblMenu.registerClass(UITableViewCell.self, forCellReuseIdentifier: "tableViewcell")
        tblMenu .backgroundColor = UIColor.clearColor()
        tblMenu.separatorStyle = .None
        tblMenu.delegate = self
        tblMenu.dataSource = self
        
        if arrMenuItem.count > 6
        {
            tblMenu.scrollEnabled = true
        }
        else{
            tblMenu.scrollEnabled = false
        }
        
        menuView .addSubview(tblMenu)
        tblMenu.reloadData()
        
        menuView.clipsToBounds = true
        menuView.layer.cornerRadius = 2.0
    }
    
    //Mark : UIGestureRecognizer Delegate Method
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        if touch.view!.isDescendantOfView(tblMenu)
        {
            return false
        }
        return true
    }
    
    // TapGesture Handle Method
    func tapGestureHandle(gesture : UITapGestureRecognizer)
    {
        self.removeFromSuperview()
    }
    
    
    // TableView Delegate and DataSource Method
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuItem.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("tableViewcell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.clearColor()
        cell.contentView .backgroundColor = UIColor.clearColor()
        
        let menuItem : NavigationBarMenuItem = arrMenuItem.objectAtIndex(indexPath.row) as! NavigationBarMenuItem
        
        cell.textLabel?.text = menuItem.menuName
        cell.textLabel?.font = UIFont(name: FontStyle.fontName, size: Style().getfontSize(12.0))
        cell.textLabel?.textColor = FontStyle.textColor
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UIScreen.mainScreen().bounds.size.width * (30.0/320.0)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
        if (delegate != nil)
        {
            let menuItem : NavigationBarMenuItem = arrMenuItem.objectAtIndex(indexPath.row) as! NavigationBarMenuItem
            delegate .topMenuOptionSelected(indexPath.row, selectedMenuTag: menuItem.menuTag)
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
