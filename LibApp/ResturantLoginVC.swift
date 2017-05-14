//
//  ResturantLoginVC.swift
//  E-Menu
//
//  Created by Dipen on 22/11/16.
//  Copyright © 2016 Dipen. All rights reserved.
//

import UIKit
import SWRevealViewController


class ResturantLoginVC: UIViewController {

    @IBOutlet var viewSapretor:UIView!
    @IBOutlet var lblRegister:UILabel!
    @IBOutlet var txtUserName:UITextField!
    @IBOutlet var txtPassword:UITextField!
    @IBOutlet var btnLogin:UIButton!
    @IBOutlet var btnLanguage:UIButton!
    @IBOutlet var lblWelcome:UILabel!
    
    var RearVC:RearViewController!
    var mainRevealController:SWRevealViewController!
    var nav:UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        // Do any additional setup after loading the view.
    }
    
    
    func setTheme() {
        viewSapretor.backgroundColor = StaticClass().colorWithHexString(hex: "#f9d47d", alpha: 1.0)
        lblRegister.textColor = StaticClass().colorWithHexString(hex: "#f9d47d", alpha: 1.0)
        let placeholder = NSAttributedString(string: "USERNAME", attributes: [NSForegroundColorAttributeName : StaticClass().colorWithHexString(hex: "#781515", alpha: 1.0)])
        let paddingView = UIView(frame:CGRect(x: 0, y: 0, width: 80, height: 90))
        txtUserName.leftView = paddingView;
        txtUserName.leftViewMode = UITextFieldViewMode.always
        txtUserName.attributedPlaceholder = placeholder
        let paddingViewPass = UIView(frame:CGRect(x: 0, y: 0, width: 80, height: 90))
        txtPassword.leftView=paddingViewPass;
        txtPassword.leftViewMode = UITextFieldViewMode.always
       // txtPassword.attributedPlaceholder = placeholder
        txtPassword.placeholder = "******"
        
    }
    
    
    @IBAction func btnLoginPress(_ sender:UIButton)
    {
        
        
        if txtUserName.text == ""
        {
            self.showAlert(title: "", message: "Enter User Name")
        }
        else if txtPassword.text == ""
        {
            self.showAlert(title: "", message: "Enter Password")
        }
        else
        {
            let url = "token/index"
            let param = NSMutableDictionary()
            param.setValue(txtUserName.text, forKey: "username")
            param.setValue(txtPassword.text, forKey: "password")
            
            APICall().callApiUsingPOST(urlPath: url as NSString, withParameter: param, withLoader: true, successBlock: { (responceData:AnyObject) in
                
                print("responce\(responceData)")
                    let userDefault : UserDefaults = UserDefaults.standard
                    userDefault.setValue(responceData.value(forKey: "token"), forKey: "token")
                    userDefault.synchronize()
                    print(userDefault.value(forKey: "token"))
//                    self.RearVC = RearViewController(nibName:"RearViewController",bundle:nil)
//                    self.nav = UINavigationController(rootViewController: self.RearVC!)
//                    self.nav?.navigationBar.isHidden = true;
//                    let homeobj = HomeVC(nibName: "HomeVC", bundle: nil)
//                    Global.currentSelect = 0; //select dashboard automatically.
//                    let nav1 = UINavigationController(rootViewController: homeobj)
//                    nav1.navigationBar.isHidden = true
//                    self.mainRevealController = SWRevealViewController.init(rearViewController: self.nav, frontViewController: nav1)
//                    self.mainRevealController.rearViewRevealWidth = 375;
                
                let tableList = TableListViewController(nibName: "TableListViewController", bundle: nil)
                    self.navigationController?.pushViewController(tableList, animated: true)

                
                }, failureBlock: { (responceData) in
                    
                    self.showAlert(title: "Error", message: (responceData.value(forKey: "message")  as! String))
            })
    }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func showAlert(title:String,message:String)
    {
    let alert = UIAlertController(title:title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
    }

}
