//
//  CrayonCollectionViewLayout.swift
//  CrayonShinChan
//
//  Created by Adam Chen on 2024/9/19.
//

import UIKit

class CrayonCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    // 1
    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    var angle: CGFloat = 0 {
        // 2
        didSet {
            zIndex = Int(angle * 1000000)
            transform = CGAffineTransformMakeRotation(angle)
        }
    }
    // 3
    override func copy(with zone: NSZone? = nil) -> Any {
        let copiedAttributes: CrayonCollectionViewLayoutAttributes =
        super.copy(with: zone) as! CrayonCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
    }
}

class CrayonCollectionViewLayout: UICollectionViewLayout {

    //let itemSize = CGSize(width: 267, height: 383)
    let itemSize = CGSize(width: 267, height: 445)
    
    var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItems(inSection: 0) > 0 ?
        -CGFloat(collectionView!.numberOfItems(inSection: 0) - 1) * anglePerItem : 0
    }
    
    var angle: CGFloat {
      return angleAtExtreme * collectionView!.contentOffset.x / (collectionViewContentSize.width -
        CGRectGetWidth(collectionView!.bounds))
    }
    
    var radius: CGFloat = 800 {
        didSet {
            invalidateLayout()
        }
    }
    
    var anglePerItem: CGFloat {
        return atan(itemSize.width / radius)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: CGFloat(collectionView!.numberOfItems(inSection: 0)) * itemSize.width,
                      height: CGRectGetHeight(collectionView!.bounds))
    }
    
    override class var layoutAttributesClass: AnyClass {
        return CrayonCollectionViewLayoutAttributes.self
    }
    
    var attributesList = [CrayonCollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        
        let centerX = collectionView!.contentOffset.x + (CGRectGetWidth(collectionView!.bounds) / 2.0)
        let anchorPointY = ((itemSize.height / 2.0) + radius) / itemSize.height
        attributesList = (0..<collectionView!.numberOfItems(inSection: 0)).map { (i)
            -> CrayonCollectionViewLayoutAttributes in
            // 1
            let attributes = CrayonCollectionViewLayoutAttributes(forCellWith: IndexPath(row: i, section: 0))
            attributes.size = self.itemSize
            // 2
            attributes.center = CGPoint(x: centerX, y: CGRectGetMidY(self.collectionView!.bounds))
            // 3
            attributes.angle = self.angle + (self.anglePerItem * CGFloat(i))
            
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
            return attributes
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesList[indexPath.row]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
