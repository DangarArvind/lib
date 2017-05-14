//
//  RearViewController.swift
//  Jumbletube
//
//  Created by Tops on 11/18/15.
//  Copyright © 2015 Tops. All rights reserved.
//

import UIKit

class RearViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var imgBG:UIImageView!
    @IBOutlet var viewMainDrawer:UIView!
    var arrryMenu = NSMutableArray()
    var arryService = NSMutableArray()
    @IBOutlet weak var lblAppName:UILabel!
    @IBOutlet weak var imgStatus:UIImageView!
    @IBOutlet weak var imgLogo:UIImageView!
    @IBOutlet var tblDrawer:UITableView!

    //var currentSelect:NSInteger!
    //MARK: VIEW CYCLE START
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTheme()
        
        // Do any additional setup after loading the view.
        tblDrawer.register(UINib(nibName: "SideBarCustomCell", bundle: nil), forCellReuseIdentifier: "SideBarCustomCell")
        
        arrryMenu = ["Appetizers","Soup","Salads","Burgers","Sanwiches","Desserts","Ice Cream"]
        
        
    }
    
    func setTheme()
    {
        viewMainDrawer.backgroundColor = StaticClass().colorWithHexString(hex: "f9d47d", alpha: 1.0)
        lblAppName.textColor = StaticClass().colorWithHexString(hex: "781515", alpha: 1.0)
    }
    
//    func getMenuData()
//    {
//    
//        let url = "token/index"
//        let param = NSMutableDictionary()
//        param.setValue(txtUserName.text, forKey: "username")
//        param.setValue(txtPassword.text, forKey: "password")
//        
//        APICall().callApiUsingPOST(urlPath: url as NSString, withParameter: param, withLoader: true, successBlock: { (responceData:AnyObject) in
//            
//            print("responce\(responceData)")
//          
//            
//            }, failureBlock: { (responceData) in
//                
//                self.showAlert(title: "Error", message: (responceData.value(forKey: "message")  as! String))
//        })
//        
//    }
//    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let rowToSelect:NSIndexPath = NSIndexPath(row: Global.currentSelect, section: 0);  //slecting 0th row with 0th section
        tblDrawer.selectRow(at: rowToSelect as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none);
        
    }
    
    
    func showAlert(title:String,message:String)
    {
        let alert = UIAlertController(title:title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLocalizaText()
//        dict.setValue(LocalizeHelper().localizedString(forKey: "SIDEBAR_Overview_Title"), forKey: "Title")
        
        
    }

    override func viewDidLayoutSubviews() {
       // tblview.tableFooterView?.frame = CGRect(x:0,y:0,width:320, height:60)
    }
    
    //MARK: CUSTOM FUNCTIOn
    func setLocalizaText() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrryMenu.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell:SideBarCustomCell  = tblDrawer.dequeueReusableCell(withIdentifier: "SideBarCustomCell") as! SideBarCustomCell
        
        cell.lblTitle.text = arrryMenu[indexPath.row] as?  String
        
        return cell
        
       
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        Global.currentSelect = indexPath.row
        
        /*if(indexPath.row == 0){
            let userprofileobj:UserPofileVC! = UserPofileVC(nibName:"UserPofileVC",bundle:nil)
            self.revealViewController().pushFrontViewController(userprofileobj, animated: true)
            
        }else if(indexPath.row == 1){
            let notificationobj:NotificationVC! = NotificationVC(nibName:"NotificationVC",bundle:nil)
            self.revealViewController().pushFrontViewController(notificationobj, animated: true)
        }else if(indexPath.row == 2){
            let messageobj:MessageVC! = MessageVC(nibName:"MessageVC",bundle:nil)
            self.revealViewController().pushFrontViewController(messageobj, animated: true)
        }else if(indexPath.row == 3){
            let photoobj:PhotoVC! = PhotoVC(nibName:"PhotoVC",bundle:nil)
            self.revealViewController().pushFrontViewController(photoobj, animated: true)
        }else if(indexPath.row == 4){
            let songsobj:SongsVC! = SongsVC(nibName:"SongsVC",bundle:nil)
            self.revealViewController().pushFrontViewController(songsobj, animated: true)
        }else if(indexPath.row == 5){
            let calenderobj:CalenderVC! = CalenderVC(nibName:"CalenderVC",bundle:nil)
            self.revealViewController().pushFrontViewController(calenderobj, animated: true)
        }
        */
    }
    
    //MARK: UIBUTTON ACTION
    @IBAction func btnLogoutClick (sender:UIButton) {
        if let _: AppDelegate = UIApplication.shared.delegate as? AppDelegate {
            //Global.appdel.UserLogOut()
        }
    }
    
   
    
    
    func loadViewNib(nibName: String) -> AnyObject {
        var nibs: [AnyObject] = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil) as! [AnyObject]
        if nibs.count > 0 {
            return nibs[0]
        }
        return "" as AnyObject as AnyObject
    }
    
    
}
