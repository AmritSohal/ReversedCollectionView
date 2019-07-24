//
//  InvertedStackLayout.swift
//  Reverse CollectionView
//
//  Created by amritpal singh on 22/07/19.
//  Copyright © 2019 amritpal singh. All rights reserved.
//

import Foundation
import UIKit
import Darwin

class InvertedStackLayout: UICollectionViewLayout {
    
    //
    let cellHeight: CGFloat = 100.00 // Your cell height here...
    let cellWidth: CGFloat = 100.00
    let numberItemPerRow = 3
    
    var currentX:CGFloat = 0.0
    var currentY: CGFloat = 0.0
    
    override func prepare() {
        super.prepare()
    }
    
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttrs = [UICollectionViewLayoutAttributes]()
        
        if let collectionView = self.collectionView {
            for section in 0 ..< collectionView.numberOfSections {
                if let numberOfSectionItems = numberOfItemsInSection(section) {
                    for item in 0 ..< numberOfSectionItems {
                        let indexPath = IndexPath(item: item, section: section)
                        let layoutAttr = layoutAttributesForItem(at: indexPath)
                        
                        if let layoutAttr = layoutAttr, layoutAttr.frame.intersects(rect) {
                            layoutAttrs.append(layoutAttr)
                        }
                    }
                }
            }
        }
        return layoutAttrs
    }
    
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let layoutAttr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        
        if(currentY == 0.0)
        {
            currentX = ((insets + cellWidth) * CGFloat(numberItemPerRow - 1)) + insets
            currentY = ((insets + cellHeight) * CGFloat(NumOfItemsInColumn - 1)) + insets
        }
            
        else if (indexPath.row % numberItemPerRow == 0)
        {
            currentX = ((insets + cellWidth) * CGFloat(numberItemPerRow - 1)) + insets
            currentY = currentY - (cellHeight + insets)
        }
            
        else
        {
            currentX = currentX - (cellWidth + insets)
        }
        
        layoutAttr.frame = CGRect( x: currentX, y: currentY, width: cellWidth, height: cellHeight)
        
        return layoutAttr
    }
    
    
    
    
    var insets:CGFloat{
        get
        {
            if let viewWidth = self.collectionView?.bounds.width
            {
                return (viewWidth - (cellWidth * CGFloat(numberItemPerRow))) / CGFloat(numberItemPerRow + 1)
            }
            return 10.0
        }
    }
    
    
    
    
    var NumOfItemsInColumn:Int
    {
        get {
            var rawCount:Double = 15.0
            
            if let totalCellCount = collectionView?.numberOfItems(inSection: 0)
            {
                rawCount = (Double(totalCellCount) / Double(numberItemPerRow));
            }
            
            let count:Int = Int(ceil(rawCount))
            return count
        }
    }
    
    
    
    
    func numberOfItemsInSection(_ section: Int) -> Int? {
        if let collectionView = self.collectionView,
            let numSectionItems = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: section)
        {
            return numSectionItems
        }
        
        return 0
    }
    
    
    
    
    override var collectionViewContentSize: CGSize {
        get {
            var height: CGFloat = 0.0
            var bounds = CGRect.zero
            
            if let collectionView = self.collectionView {
                
                bounds = collectionView.bounds
                height =  CGFloat(NumOfItemsInColumn / numberItemPerRow) * (cellHeight + insets )
            }
            return CGSize(width: bounds.width, height: height)
        }
    }
    
    
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if let oldBounds = self.collectionView?.bounds,
            oldBounds.width != newBounds.width || oldBounds.height != newBounds.height
        {
            return true
        }
        
        return false
    }
}
