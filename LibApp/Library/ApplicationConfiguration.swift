//
//  ApplicationConfiguration.swift
//  WMA
//
//  Created by tasol on 1/13/16.
//  Copyright © 2016 tasol. All rights reserved.
//

import UIKit

class ApplicationConfiguration: NSObject
{
    static let sharderInstance = ApplicationConfiguration()
    
    override init()
    {
        super.init()
    }
    
    
    func storeApplicationconfigrationInLocalDatabase(responseData : NSDictionary)
    {
        let configuration : NSDictionary = responseData .valueForKey(GlobalConfigConstant.TAG_CONFIGURATION) as! NSDictionary
        
        // -------- Store Global Config and Extention Config into Application Data Global Variable  ----------------------------- //
        if (configuration .objectForKey(GlobalConfigConstant.TAG_GLOBAL_CONFIG) != nil)
        {
            ApplicationData.sharedInstance.globalConfig = configuration .objectForKey(GlobalConfigConstant.TAG_GLOBAL_CONFIG) as! NSDictionary
            
            self .storeGlobalAndExtentionConfigInDatabases(configuration.objectForKey(GlobalConfigConstant.TAG_GLOBAL_CONFIG) as! NSDictionary, configName: GlobalConfigConstant.TAG_GLOBAL_CONFIG)
        }
        
        
        if (configuration[GlobalConfigConstant.TAG_EXTENTION_CONFIG] != nil)
        {
            ApplicationData.sharedInstance.extentionConfig = configuration[GlobalConfigConstant.TAG_EXTENTION_CONFIG] as! NSDictionary
            self .storeGlobalAndExtentionConfigInDatabases(configuration[GlobalConfigConstant.TAG_EXTENTION_CONFIG] as! NSDictionary, configName:GlobalConfigConstant.TAG_EXTENTION_CONFIG)
        }
        
        // ------  Save Jomsocial and other Extention config in Appliocation data global  variable  ------------------------------ //
        
        if((configuration .objectForKey(GlobalConfigConstant.TAG_EXTENTION_CONFIG)?.objectForKey(GlobalConfigConstant.TAG_JOMSOCIAL)) != nil)
        {
            ApplicationData.sharedInstance.jomSocialConfig = configuration .objectForKey(GlobalConfigConstant.TAG_EXTENTION_CONFIG)!.objectForKey(GlobalConfigConstant.TAG_JOMSOCIAL) as! NSDictionary
        }
    
        if((configuration .objectForKey(GlobalConfigConstant.TAG_EXTENTION_CONFIG)?.objectForKey(GlobalConfigConstant.TAG_K2)) != nil)
        {
            ApplicationData.sharedInstance.k2Config = configuration .objectForKey(GlobalConfigConstant.TAG_EXTENTION_CONFIG)!.objectForKey(GlobalConfigConstant.TAG_K2) as! NSDictionary
        }
        
        let arrMode : NSArray = NSArray(array: configuration .objectForKey(GlobalConfigConstant.TAG_MODEDETAILS) as! NSArray)
        self .storeModeInLocalDatabase(arrMode)
        
        // --------  Store Menu Details in Local Database  ------------------------------------------------------------------------
        
        let arrMenu: NSArray = NSArray(array: configuration .objectForKey(GlobalConfigConstant.TAG_MENUS) as! NSArray)
        self .storeMenuDetailInLocalDatabase(arrMenu)
        
        // -------- Store Theme Details in Local Database  ------------------------------------------------------------------------
        let arrTheme : NSArray = NSArray(array: configuration .objectForKey(DatabaseConstant.TAG_THEME) as! NSArray)
        [self .storeThemeDetailsInLocalDatabase(arrTheme)]
    }
    
    
    func storeGlobalAndExtentionConfigInDatabases(configDetail : NSDictionary,configName : String)
    {
        let database : DatabaseHandler = DatabaseHandler.sharedInstance()
        
        let menutblExist : Int32 = database.CheckTableExist(DatabaseConstant.TAG_IJOOMER_CONFIG_TABLE) as Int32
        
        if menutblExist != 1
        {
            let createTable : String = "\(DatabaseConstant.QUERY_CREATE_TABLE) \(DatabaseConstant.TAG_IJOOMER_CONFIG_TABLE) (\(DatabaseConstant.TAG_CONFIG_NAME) TEXT PRIMARY KEY, \(DatabaseConstant.TAG_CONFIG_DATA) TEXT)"
            [database .CreateTable(createTable)]
        }
        
        let dicConfiguration : NSMutableDictionary = NSMutableDictionary()
        dicConfiguration .setValue(configName, forKey: DatabaseConstant.TAG_CONFIG_NAME)
        dicConfiguration .setValue(configDetail, forKey: DatabaseConstant.TAG_CONFIG_DATA)
        database.insertData(DatabaseConstant.TAG_IJOOMER_CONFIG_TABLE, keys: dicConfiguration.allKeys, values: dicConfiguration as [NSObject : AnyObject])
    }

    // Mark --- Store Mode(Smiles) in the Local Database -------------
    func storeModeInLocalDatabase(arrMode : NSArray)
    {
        let database : DatabaseHandler = DatabaseHandler.sharedInstance()
        
        let modeTableExist : Int32 = database.CheckTableExist(String(format: DatabaseConstant.TAG_MODE_TABLE))
        
        if modeTableExist != 1
        {
            let createTable : String = "\(DatabaseConstant.QUERY_CREATE_TABLE) \(DatabaseConstant.TAG_MODE_TABLE) (\(DatabaseConstant.TAG_MODE_ID) TEXT PRIMARY KEY, \(DatabaseConstant.TAG_MODE_TITLE) TEXT, \(DatabaseConstant.TAG_MODE_DESCRIPTION) TEXT, \(DatabaseConstant.TAG_MODE_IMAGE) TEXT)"
            [database .CreateTable(createTable)]
        }
        
        let arrModeKeys : NSArray = [DatabaseConstant.TAG_MODE_ID,DatabaseConstant.TAG_MODE_IMAGE,DatabaseConstant.TAG_MODE_DESCRIPTION,DatabaseConstant.TAG_MODE_TITLE]
        
        
        for item in arrMode
        {
            let modeDetail : NSDictionary = item as! NSDictionary
            database.insertData(DatabaseConstant.TAG_MODE_TABLE, keys: arrModeKeys as [AnyObject], values: modeDetail as [NSObject : AnyObject])
        }
       
    }
    
    // Mark --- Method for Get the Mode from Database
    func getAllModeFromDatabase() -> NSArray
    {
        return DatabaseHandler.sharedInstance().getDataFromLocalDatabase("\(DatabaseConstant.QUERY_SELECT_TABLE) \(DatabaseConstant.TAG_MODE_TABLE)")
    }
    
    // Mark ---  Store Menu Details in the local Database  ------------
    func storeMenuDetailInLocalDatabase(arrMenu : NSArray)
    {
        let database : DatabaseHandler = DatabaseHandler.sharedInstance()
        
        var menuTableExist: Int32 = database.CheckTableExist(String(format: DatabaseConstant.TAG_MENU_TABLE))
        var menuItemTableExist: Int32 = database.CheckTableExist(String(format: DatabaseConstant.TAG_MENU_ITEM_TEABLE))
        if menuTableExist == 1 {
            menuTableExist = database.DropTable(DatabaseConstant.TAG_MENU_TABLE)
        }
        if menuItemTableExist != 0 {
            menuItemTableExist = database.DropTable(DatabaseConstant.TAG_MENU_ITEM_TEABLE)
        }
        
        
        //Create a new menuTable..
        let createTable: String = "\(DatabaseConstant.QUERY_CREATE_TABLE) \(DatabaseConstant.TAG_MENU_TABLE) (\(DatabaseConstant.TAG_MENUID) INTEGER, \(DatabaseConstant.TAG_MENU_POSITION) INTEGER, \(DatabaseConstant.TAG_MENU_NAME) TEXT, \(DatabaseConstant.TAG_MENU_SCREENS) TEXT, \(DatabaseConstant.TAG_MENU_TYPE) TEXT)"
        database.CreateTable(createTable)
        
//        //Delete previous menu...
//        database.deleteData("\(DatabaseConstant.QUERY_DELETE_TABLE) \(DatabaseConstant.TAG_MENU_TABLE)")
        // ------------  Check Menu Item table  ------------ //
        let createMenuItemTable: String = "\(DatabaseConstant.QUERY_CREATE_TABLE) \(DatabaseConstant.TAG_MENU_ITEM_TEABLE) (\(DatabaseConstant.TAG_MENUID) INTEGER, \(DatabaseConstant.TAG_MENU_ITEM_ID) INTEGER, \(DatabaseConstant.TAG_MENU_ITEM_CAPTION) TEXT, \(DatabaseConstant.TAG_MENU_ITEM_DATA) TEXT, \(DatabaseConstant.TAG_MENU_ITEM_ITEMVIEW) TEXT ,\(DatabaseConstant.TAG_MENU_ITEM_ICON) TEXT,\(DatabaseConstant.TAG_MENU_ITEM_BANNER_IMAGE) TEXT)"
        database.CreateTable(createMenuItemTable)
        
//        //Delete previous menu...
//        database.deleteData("\(DatabaseConstant.QUERY_DELETE_TABLE) \(DatabaseConstant.TAG_MENU_ITEM_TEABLE)")
        
        // For all Menus
        
        
        for items : AnyObject in arrMenu
        {
            let menuDetail: NSDictionary = items as! NSDictionary
            
            let arrMenuDetailKeys : NSArray = [DatabaseConstant.TAG_MENUID,DatabaseConstant.TAG_MENU_POSITION,DatabaseConstant.TAG_MENU_NAME,DatabaseConstant.TAG_MENU_SCREENS,DatabaseConstant.TAG_MENU_TYPE]
            
            database.insertData(DatabaseConstant.TAG_MENU_TABLE, keys: arrMenuDetailKeys as [AnyObject], values: menuDetail as [NSObject : AnyObject])
            
            // Store Menu details into IjoomerMenu table }
            
            // ----------- Store Menu Item Details into IjoomerMenuItem Table  -------------
            
            let arrMenuItems: NSArray = menuDetail[DatabaseConstant.TAG_MENU_ITEM] as! NSArray
            
            
            for item: AnyObject in arrMenuItems
            {
                let menuItemDetails : NSMutableDictionary = NSMutableDictionary(dictionary: item as! [NSObject : AnyObject])
                
                let itemKeys : NSArray = [DatabaseConstant.TAG_MENUID,DatabaseConstant.TAG_MENU_ITEM_ID,DatabaseConstant.TAG_MENU_ITEM_ITEMVIEW,DatabaseConstant.TAG_MENU_ITEM_DATA,DatabaseConstant.TAG_MENU_ITEM_CAPTION,DatabaseConstant.TAG_MENU_ITEM_ICON,DatabaseConstant.TAG_MENU_ITEM_BANNER_IMAGE]
                
                menuItemDetails.setValue(menuDetail.valueForKey(DatabaseConstant.TAG_MENUID), forKey: DatabaseConstant.TAG_MENUID)
                
                database.insertData(DatabaseConstant.TAG_MENU_ITEM_TEABLE, keys: itemKeys as [AnyObject], values: menuItemDetails as [NSObject : AnyObject])
                
                //                 -- Store Menu Item Data into IjoomerMenuitem table with menu id
            }
        }
    }
    
    //---------- Store Theme Details in Local Database  -------------
    
    func storeThemeDetailsInLocalDatabase(arrTheme : NSArray)
    {
        var tableExist : Int32 = DatabaseHandler.sharedInstance().CheckTableExist(DatabaseConstant.TAG_APP_THEME_TABLE as String)
        
        if tableExist == 1
        {
            tableExist = DatabaseHandler.sharedInstance().DropTable(DatabaseConstant.TAG_APP_THEME_TABLE as String)
        }
        
        let strQuery : String = "\(DatabaseConstant.QUERY_CREATE_TABLE) \(DatabaseConstant.TAG_APP_THEME_TABLE) (\(DatabaseConstant.TAG_THEME_VIEWNAME) TEXT, \(DatabaseConstant.TAG_THEME_ICON) TEXT, \(DatabaseConstant.TAG_THEME_TAB) TEXT, \(DatabaseConstant.TAG_THEME_TAB_ACTIVE) TEXT, \(DatabaseConstant.TAG_THEME_TABPATH) TEXT, \(DatabaseConstant.TAG_THEME_TAB_ACTIVEPATH) TEXT, \(DatabaseConstant.TAG_THEME_ICONPATH) TEXT)"
        
        DatabaseHandler.sharedInstance().CreateTable(strQuery as String)
        
        DatabaseHandler.sharedInstance().deleteData("\(DatabaseConstant.QUERY_DELETE_TABLE) \(DatabaseConstant.TAG_APP_THEME_TABLE)")
        
        // ------  Parse theme detail from the array and store into local database  ------ //
        
        for item : AnyObject in arrTheme
        {
            let themeDetail : NSDictionary = item as! NSDictionary
            
            let tabimageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
            dispatch_async(tabimageQueue, { () -> Void in
                NSUtil.getImageDataFromURL(themeDetail .objectForKey(DatabaseConstant.TAG_THEME_TAB) != nil ? themeDetail .objectForKey(DatabaseConstant.TAG_THEME_TAB) as! String : "")
            })
            
            let tab_activeimageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
            dispatch_async(tab_activeimageQueue, { () -> Void in
                NSUtil.getImageDataFromURL(themeDetail .objectForKey(DatabaseConstant.TAG_THEME_TAB_ACTIVE) != nil ? themeDetail .objectForKey(DatabaseConstant.TAG_THEME_TAB_ACTIVE) as! String : "")
            })
            
            let iconimageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
            dispatch_async(iconimageQueue, { () -> Void in
                NSUtil.getImageDataFromURL( themeDetail.objectForKey(DatabaseConstant.TAG_THEME_ICON) != nil ? themeDetail.objectForKey(DatabaseConstant.TAG_THEME_ICON) as! String : "")
            })
            
            
            let arrKeys : NSArray = [DatabaseConstant.TAG_THEME_VIEWNAME,DatabaseConstant.TAG_THEME_ICON,DatabaseConstant.TAG_THEME_TAB,DatabaseConstant.TAG_THEME_TAB_ACTIVE,DatabaseConstant.TAG_THEME_TABPATH,DatabaseConstant.TAG_THEME_TAB_ACTIVEPATH,DatabaseConstant.TAG_THEME_ICONPATH]
            DatabaseHandler.sharedInstance().insertData(DatabaseConstant.TAG_APP_THEME_TABLE, keys: arrKeys as [AnyObject] , values: themeDetail as [NSObject : AnyObject])
            
        }
    }
    
    

    //  --------  Get All the menus Details from the local database  ----------------
    
    func getAllMenusFromDatabase() -> NSArray
    {
        let arrMenus : NSMutableArray = []
        
        let arrTmp : NSArray = [DatabaseHandler .sharedInstance().getDataFromLocalDatabase("\(DatabaseConstant.QUERY_SELECT_TABLE) \(DatabaseConstant.TAG_MENU_TABLE)")]
        
        // ---------  Get Menu Item for the individual manu and add them into menudetail dictionary --------
        for items : AnyObject in arrTmp[0] as! NSArray  // arrTmp
        {
            let menuDet : NSDictionary = items as! NSDictionary
            
            let meunuItem : NSDictionary = [ DatabaseConstant.TAG_MENU_ITEM : self.getMenuItemsForSelectedMenu(menuDet .valueForKey(DatabaseConstant.TAG_MENUID) as! String)]
            
            let menuDetails : NSMutableDictionary  = menuDet as! NSMutableDictionary
            menuDetails .addEntriesFromDictionary(meunuItem as [NSObject : AnyObject])
            arrMenus .addObject(menuDetails)
        }
        
        return [arrMenus]
    }
    
    // -----------  Get Menu ITems for selected menu by menu id ------------
    func getMenuItemsForSelectedMenu(menuid: String) -> NSArray
    {
        var arrMenuItem : NSArray!
        let sqlSelect: String = "\(DatabaseConstant.QUERY_SELECT_TABLE) \(DatabaseConstant.TAG_MENU_ITEM_TEABLE) WHERE \(DatabaseConstant.TAG_MENUID)=\(CInt(menuid)!)"
        arrMenuItem = DatabaseHandler.sharedInstance().getDataFromLocalDatabase(sqlSelect)
        return arrMenuItem
        
    }
    
    
    // ------ Get Theme Details from the Local database  ---------------------
    
    func getApplicationThemeDetailFromLocalDatabase() -> NSArray
    {
        var arrThemeDetail : NSArray!
        
        let sqlQuery : String = "\(DatabaseConstant.QUERY_SELECT_TABLE) \(DatabaseConstant.TAG_APP_THEME_TABLE)"
        
        arrThemeDetail = DatabaseHandler.sharedInstance().getDataFromLocalDatabase(sqlQuery as String)
        
        return arrThemeDetail
    }
    
    // ---------  Get ALl global,extention configuration from local database --------------
    func getAllConfigurationFromDatabase() -> NSArray
    {
        var arrConfiguration : NSArray!
        let sqlSelect: String = "\(DatabaseConstant.QUERY_SELECT_TABLE) \(DatabaseConstant.TAG_IJOOMER_CONFIG_TABLE)"
        
        arrConfiguration = DatabaseHandler.sharedInstance().getDataFromLocalDatabase(sqlSelect)
        
        return arrConfiguration
    }
    
    // ---------------   Get Home Menu List From local database for particular view and position  -----------------
    func getMenuListFromDatabase(menuPosition : Int32,forView strViewName: String) -> NSArray
    {
        let arrHomeMenus : NSMutableArray = []
        //SELECT * FROM Menus where menuposition = %d and screens like '#%@#';", menupos, screenname
        
        // ------------------- Query to obtain menu id from Ijooomer Menu Table using menuposition and screen name  ------------------
        
        let queryMenuId: String = "\(DatabaseConstant.QUERY_SELECT_TABLE) \(DatabaseConstant.TAG_MENU_TABLE) WHERE \(DatabaseConstant.TAG_MENU_POSITION)=\(menuPosition) AND \(DatabaseConstant.TAG_MENU_SCREENS) like '#\(strViewName)#'"
        
        print("Select query from menulist :\(queryMenuId)")
        
        let arrAllMenu = DatabaseHandler.sharedInstance().getDataFromLocalDatabase(queryMenuId as String)
        
        
        for items : AnyObject in arrAllMenu
        {
            // ------------------- Query to obtain menuItems from IjooomerMenuItem Table using MenuId  ------------------
            let menuDetail : NSDictionary = items as! NSDictionary
            let queryMenuItem: String = "\(DatabaseConstant.QUERY_SELECT_TABLE) \(DatabaseConstant.TAG_MENU_ITEM_TEABLE) WHERE \(DatabaseConstant.TAG_MENUID) = \(Int(menuDetail[DatabaseConstant.TAG_MENUID] as! NSNumber))"
            
            print("Select query from menulist :\(queryMenuItem)")
            
            let arrMenuItems : NSArray = DatabaseHandler.sharedInstance().getDataFromLocalDatabase(queryMenuItem) as NSArray
            
            for subItem : AnyObject in arrMenuItems
            {
                let menuItem : NSDictionary = subItem as! NSDictionary
                
                let queryThemeTable: String = "\(DatabaseConstant.QUERY_SELECT_TABLE)  \(DatabaseConstant.TAG_APP_THEME_TABLE) WHERE \(DatabaseConstant.TAG_THEME_VIEWNAME) ='\(menuItem[DatabaseConstant.TAG_MENU_ITEM_ITEMVIEW] as! String)' GROUP BY \(DatabaseConstant.TAG_THEME_VIEWNAME )"
                
                let arrThemeRecord : NSArray = [DatabaseHandler.sharedInstance().getDataFromLocalDatabase(queryThemeTable)]
                
                let menuDetail : NSDictionary = [
                    DatabaseConstant.TAG_MENUITEM_TABLE_DETAIL : menuItem,
                    DatabaseConstant.TAG_THEME_TABLE_DETAIL : arrThemeRecord.firstObject!
                ]
                
                if arrHomeMenus .containsObject(menuDetail) == false
                {
                    arrHomeMenus .addObject(menuDetail)
                }
                
            }
            
        }
        
        return arrHomeMenus
    }
    
    // ---------------   Get Home Menu List From local database for particular view and position  -----------------
    
    
    func getMenuListFromDatabaseForView(menuPosition : Int32,forView strViewName: String) -> NSArray
    {
        let arrHomeMenus : NSMutableArray = []
        //SELECT * FROM Menus where menuposition = %d and screens like '#%@#';", menupos, screenname
        
        // ------------------- Query to obtain menu id from Ijooomer Menu Table using menuposition and screen name  ------------------
        
        let queryMenuId: String = "\(DatabaseConstant.QUERY_SELECT_TABLE) \(DatabaseConstant.TAG_MENU_TABLE) WHERE \(DatabaseConstant.TAG_MENU_POSITION)=\(menuPosition) AND \(DatabaseConstant.TAG_MENU_NAME) like '#\(strViewName)#'"
        
        print("Select query from menulist :\(queryMenuId)")
        
        let arrAllMenu = DatabaseHandler.sharedInstance().getDataFromLocalDatabase(queryMenuId as String)
        
        
        for items : AnyObject in arrAllMenu
        {
            // ------------------- Query to obtain menuItems from IjooomerMenuItem Table using MenuId  ------------------
            let menuDetail : NSDictionary = items as! NSDictionary
            
            let mId : Int = Int(menuDetail[DatabaseConstant.TAG_MENUID] as! String)!
            
            let queryMenuItem: String = "\(DatabaseConstant.QUERY_SELECT_TABLE) \(DatabaseConstant.TAG_MENU_ITEM_TEABLE) WHERE \(DatabaseConstant.TAG_MENUID) = \(mId)"
            
            print("Select query from menulist :\(queryMenuItem)")
            
            let arrMenuItems : NSArray = DatabaseHandler.sharedInstance().getDataFromLocalDatabase(queryMenuItem) as NSArray
            
            for subItem : AnyObject in arrMenuItems
            {
                let menuItem : NSDictionary = subItem as! NSDictionary
                
                let queryThemeTable: String = "\(DatabaseConstant.QUERY_SELECT_TABLE)  \(DatabaseConstant.TAG_APP_THEME_TABLE) WHERE \(DatabaseConstant.TAG_THEME_VIEWNAME) ='\(menuItem[DatabaseConstant.TAG_MENU_ITEM_ITEMVIEW] as! String)' GROUP BY \(DatabaseConstant.TAG_THEME_VIEWNAME )"
                
                let arrThemeRecord : NSArray = [DatabaseHandler.sharedInstance().getDataFromLocalDatabase(queryThemeTable)]
                
                let menuDetail : NSDictionary = [
                    DatabaseConstant.TAG_MENUITEM_TABLE_DETAIL : menuItem,
                    DatabaseConstant.TAG_THEME_TABLE_DETAIL : arrThemeRecord.firstObject!
                ]
                
                if arrHomeMenus .containsObject(menuDetail) == false
                {
                    arrHomeMenus .addObject(menuDetail)
                }
                
            }
            
        }
        
        return arrHomeMenus
    }
    
    //---------------   Get Home Menu List From local database  -----------------
    func getMenuListFromDatabase(menuPosition : Int) -> NSArray
    {
        let arrHomeMenus : NSMutableArray = []
        // ------------------- Query to obtain menu id from Ijooomer Menu Table using menuposition  ------------------
        
        let queryMenuId: String = "\(DatabaseConstant.QUERY_SELECT_TABLE) \(DatabaseConstant.TAG_MENU_TABLE) WHERE \(DatabaseConstant.TAG_MENU_POSITION)=\(menuPosition)"
        
        let arrMenu : NSArray = DatabaseHandler.sharedInstance().getDataFromLocalDatabase(queryMenuId)
        
        let menuIdDetail : NSDictionary!
        if arrMenu.count > 0
        {
            menuIdDetail = arrMenu[0] as! NSDictionary
        }
        else {
            return []
        }
        // ------------------- Query to obtain menuItems from IjooomerMenuItem Table using MenuId  ------------------
        let queryMenuItem : String = "\(DatabaseConstant.QUERY_SELECT_TABLE) \(DatabaseConstant.TAG_MENU_ITEM_TEABLE) WHERE \(DatabaseConstant.TAG_MENUID)=\(Int(menuIdDetail .valueForKey(DatabaseConstant.TAG_MENUID) as! String)!)"
        
        let arrMenuItems = DatabaseHandler.sharedInstance().getDataFromLocalDatabase(queryMenuItem as String)
        
        for items : AnyObject in arrMenuItems
        {
            // ------------------- Query to obtain Theme Table Records from IjooomerTheme Table using viewname to get icon details for menu  ------------------
            let menuItem : NSDictionary = items as! NSDictionary
            
            let queryThemeTable: String = "\(DatabaseConstant.QUERY_SELECT_TABLE) \(DatabaseConstant.TAG_APP_THEME_TABLE) WHERE \(DatabaseConstant.TAG_THEME_VIEWNAME) ='\(menuItem[DatabaseConstant.TAG_MENU_ITEM_ITEMVIEW]!)'"
            
            let arrThemeRecord : NSArray = DatabaseHandler.sharedInstance().getDataFromLocalDatabase(queryThemeTable) as NSArray
            
            if arrThemeRecord.count > 0
            {
                let menuDetail : NSDictionary = [
                    DatabaseConstant.TAG_MENUITEM_TABLE_DETAIL : menuItem,
                    DatabaseConstant.TAG_THEME_TABLE_DETAIL : arrThemeRecord.firstObject!
                ]
                arrHomeMenus .addObject(menuDetail)
            }
            
        }
        return arrHomeMenus
    }
    
//    //---------------   Get Home Menu List From local database  -----------------
//    func getMenuListFromDatabase(menuPosition : Int) -> NSArray
//    {
//        let arrHomeMenus : NSMutableArray = []
//        // ------------------- Query to obtain menu id from Ijooomer Menu Table using menuposition  ------------------
//        
//        let queryMenuId: String = "\(DatabaseConstant.QUERY_SELECT_TABLE) \(DatabaseConstant.TAG_MENU_TABLE) WHERE \(DatabaseConstant.TAG_MENU_POSITION)=\(menuPosition)"
//        
//        let menuIdDetail : NSDictionary = DatabaseHandler.sharedInstance().getDataFromLocalDatabase(queryMenuId) .objectAtIndex(0) as! NSDictionary
//        
//        // ------------------- Query to obtain menuItems from IjooomerMenuItem Table using MenuId  ------------------
//        let queryMenuItem : String = "\(DatabaseConstant.QUERY_SELECT_TABLE) \(DatabaseConstant.TAG_MENU_ITEM_TEABLE) WHERE \(DatabaseConstant.TAG_MENUID)=\(Int(menuIdDetail .valueForKey(DatabaseConstant.TAG_MENUID) as! String))"
//        
//        let arrMenuItems = DatabaseHandler.sharedInstance().getDataFromLocalDatabase(queryMenuItem as String)
//        
//        for items : AnyObject in arrMenuItems
//        {
//            // ------------------- Query to obtain Theme Table Records from IjooomerTheme Table using viewname to get icon details for menu  ------------------
//            let menuItem : NSDictionary = items as! NSDictionary
//            
//            let queryThemeTable: String = "\(DatabaseConstant.QUERY_SELECT_TABLE) \(DatabaseConstant.TAG_APP_THEME_TABLE) WHERE \(DatabaseConstant.TAG_THEME_VIEWNAME) ='\(menuItem[DatabaseConstant.TAG_MENU_ITEM_ITEMVIEW])'"
//            
//            let arrThemeRecord : NSArray = DatabaseHandler.sharedInstance().getDataFromLocalDatabase(queryThemeTable) as NSArray
//            
//            let menuDetail : NSDictionary = [
//                DatabaseConstant.TAG_MENUITEM_TABLE_DETAIL : menuItem,
//                DatabaseConstant.TAG_THEME_TABLE_DETAIL : arrThemeRecord.firstObject!
//            ]
//            
//            arrHomeMenus .addObject(menuDetail)
//            
//        }
//        return arrHomeMenus
//    }
    
    
    //---------  Registration Step 2  ---------
    func getFullRegistrationFields(responseData : NSDictionary) -> NSArray
    {
        let arrRegistrationFields : NSMutableArray = []
        
        arrRegistrationFields .addObject(responseData .objectForKey(RegisterConstant.TAG_REGISTRATION_FULL)!)
        
        let fields : NSDictionary = responseData .objectForKey(RegisterConstant.TAG_REGISTRATION_FIELDS) as! NSDictionary
        let arrGroups : NSArray = fields .objectForKey(RegisterConstant.TAG_REGISTRATION_GROUP) as! NSArray
        
        for itemGroup : AnyObject in arrGroups
        {
            arrRegistrationFields .addObject(itemGroup as! NSDictionary)
        }
        
        return arrRegistrationFields
        
    }
    
    // ----------------- Get data plist file from server ------------------
    
    func getViewListFromDataPlistFile()-> NSArray
    {
        let dataDict : NSDictionary = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("Data", ofType: "plist")!)!
        
        let arrViewList : NSArray = dataDict .valueForKey(DatabaseConstant.TAG_VIEWLIST) as! NSArray
        
        return arrViewList
    }
}
