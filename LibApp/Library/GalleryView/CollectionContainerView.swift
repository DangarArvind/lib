//
//  CollectionContainerView.swift
//  GelleryView
//
//  Created by tasol on 1/7/16.
//  Copyright © 2016 tasol. All rights reserved.
//

import UIKit

protocol CollectionContainerViewDelegate
{
    func selectedCell(cellData : NSDictionary , indextPath : NSIndexPath)
    func btnShopNowPressed(sender : UIButton)
}

class CollectionContainerView: UIView,UICollectionViewDataSource,UICollectionViewDelegate
{
    var arrCollectionData : NSArray!
    var collectionView : UICollectionView!
    
    let height : CGFloat = UIScreen.mainScreen().bounds.size.width * (170.0/320.0)
    var delegate : CollectionContainerViewDelegate?
    
    //    override init(frame: CGRect)
    //    {
    //        super.init(frame: frame)
    //
    //
    //    }
    
    init()
    {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: height))
        
        let flowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal
        flowLayout.itemSize = CGSize(width: height * (93.33/170.0), height: height - 20)
        
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.scrollDirection = .Horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y:0, width: UIScreen.mainScreen().bounds.size.width, height: height), collectionViewLayout: flowLayout)
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView.scrollEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        self.collectionView .registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        self.addSubview(collectionView)
        self.backgroundColor = UIColor.clearColor()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setCollectionData(collectionData : NSArray)
    {
        arrCollectionData = collectionData
        collectionView .setContentOffset(CGPoint.zero, animated: false)
        collectionView .reloadData()
    }
    
    //Collection View Delegate Method
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCollectionData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell : CollectionViewCell = collectionView .dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        
        
        let cellData : NSDictionary = arrCollectionData .objectAtIndex(indexPath.row) as! NSDictionary
        
        let imgURL : String = cellData.objectForKey(ProductListConstant.TAG_IMAGES)?.objectForKey(ProductListConstant.TAG_MAIN)?.objectForKey(ProductListConstant.TAG_FULL)?.valueForKey(ProductListConstant.TAG_URL) as! String
        
        NSUtil.getImageForView(cell.imageProductItem, fromURL: imgURL, alterText: nil)
        
        cell.lblProductItem.text =  (cellData.valueForKey(ProductListConstant.TAG_NAME) as? String)?.html2String

        
        if cellData.objectForKey(ProductListConstant.TAG_PRICE)?.valueForKey(ProductDetailConstant.TAG_ASKPRICE) as! Int == 0
        {
            let salesPrize : NSDictionary = cellData.objectForKey(ProductListConstant.TAG_PRICE)?.objectForKey(ProductListConstant.TAG_SALES_PRICE) as! NSDictionary
            let productPrize : String = salesPrize.objectForKey(ProductListConstant.TAG_PRICE)?.valueForKey(ProductListConstant.TAG_FORMATTED) as! String
            cell.lblProductPrice.text = productPrize
            cell.btnShopNowProduct.setTitle("Shop Now", forState: UIControlState.Normal)
            cell.lblProductPrice.hidden = false
        }
        else
        {
            cell.lblProductPrice.hidden = true
            cell.lblProductPrice.text = ""
            cell.btnShopNowProduct.setTitle("Ask Price", forState: UIControlState.Normal)
        }
        
        cell.setTheme()
        cell.btnShopNowProduct.addTarget(self, action: "btnShopPressed:", forControlEvents: .TouchUpInside)
        cell.btnShopNowProduct.tag = indexPath.row
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let dicCellData : NSDictionary = arrCollectionData[indexPath.row] as! NSDictionary
        if (delegate != nil)
        {
            delegate! .selectedCell(dicCellData,indextPath: indexPath)
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10,10 )
        // top, left, bottom, right
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
//        let width: CGFloat = CGRectGetWidth(self.collectionView.frame) / 3.0
        
        return CGSizeMake(height * (93.33/170.0), height - 20)
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10.0
    }
    

    func btnShopPressed(sender:UIButton)
    {
        if(delegate != nil)
        {
            delegate?.btnShopNowPressed(sender)
        }
    }
    
}
