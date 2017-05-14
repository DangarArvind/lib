//
//  SideBarServiceCell.swift
//  E-Menu
//
//  Created by Krishna on 30/11/16.
//  Copyright © 2016 Dipen. All rights reserved.
//

import UIKit

class SideBarServiceCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblLeft: UILabel!
    @IBOutlet weak var imgIcon:UIImageView!
    @IBOutlet weak var bgview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblLeft.backgroundColor = StaticClass().colorWithHexString(hex: "f9d47d", alpha: 1.0)
        lblTitle.textColor = StaticClass().colorWithHexString(hex: "781515", alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        if(selected == true){
            lblLeft.isHidden = false
        }else{
            lblLeft.isHidden = true
        }
    }
    
}
