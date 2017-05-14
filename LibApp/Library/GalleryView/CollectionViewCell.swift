//
//  CollectionViewCell.swift
//  GelleryView
//
//  Created by tasol on 1/7/16.
//  Copyright © 2016 tasol. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var btnShopNowProduct: UIButton!
    @IBOutlet weak var lblProductItem: UILabel!
    @IBOutlet weak var imageProductItem: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init (frame : CGRect)
    {
        super.init(frame : frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setTheme()
    {
        btnShopNowProduct.backgroundColor = UIColor.clearColor()
        btnShopNowProduct.setTitleColor(FontStyle.linkColor, forState: .Normal)
        btnShopNowProduct.titleLabel?.font = UIFont(name: FontStyle.fontName, size: Style().getfontSize(7.0))
        btnShopNowProduct.setTitle("Shop Now", forState: .Normal)
        
        lblProductItem.font = UIFont(name: FontStyle.fontName, size: Style().getfontSize(8.0))
        lblProductItem.textColor = FontStyle.textColor
        
        lblProductPrice.font = UIFont(name: FontStyle.fontName, size: Style().getfontSize(8.0))
        lblProductPrice.textColor = FontStyle.textColor
        
        Style().addShadowToView(self)
    }
    
 }
