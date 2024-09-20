//
//  CrayonCollectionViewCell.swift
//  CrayonShinChan
//
//  Created by Adam Chen on 2024/9/19.
//

import UIKit

class CrayonCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "\(CrayonCollectionViewCell.self)"
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        guard let crayonlayoutAttributes = layoutAttributes as? CrayonCollectionViewLayoutAttributes else { return }
        self.layer.anchorPoint = crayonlayoutAttributes.anchorPoint
        self.center.y += (crayonlayoutAttributes.anchorPoint.y - 0.5) * CGRectGetHeight(self.bounds)
    }
}
