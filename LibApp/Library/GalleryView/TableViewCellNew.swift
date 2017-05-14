//
//  TableViewCellNew.swift
//  GelleryView
//
//  Created by tasol on 1/7/16.
//  Copyright © 2016 tasol. All rights reserved.
//

import UIKit

protocol TableViewCellNewDelegate
{
    func selectedCell(cellData : NSDictionary , indextPath : NSIndexPath)
    func btnShopNowPressed(sender : UIButton)
}

class TableViewCellNew: UITableViewCell,CollectionContainerViewDelegate
{
    
    var collectionView : CollectionContainerView!
    var delegate : TableViewCellNewDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        collectionView = CollectionContainerView()
        collectionView.delegate = self
        self.contentView .addSubview(collectionView!)
    }


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setCollectionData(collectionData : NSArray)
    {
        self.collectionView!.setCollectionData(collectionData)
    }
    
    
    // CollectionContainerViewDelegate Method
    func selectedCell(cellData: NSDictionary, indextPath: NSIndexPath) {
        if((delegate) != nil)
        {
            delegate .selectedCell(cellData, indextPath: indextPath)
        }
    }
    
    func btnShopNowPressed(sender: UIButton)
    {
            if(delegate != nil)
            {
                delegate?.btnShopNowPressed(sender)
            }
    }
    
}
