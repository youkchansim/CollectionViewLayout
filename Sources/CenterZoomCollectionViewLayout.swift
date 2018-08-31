//
//  CenterZoomCollectionViewLayout.swift
//  CollectionViewLayoutExample
//
//  Created by Naver on 2018. 8. 30..
//  Copyright © 2018년 CollectionViewLayout. All rights reserved.
//

import UIKit

public class CenterZoomCollectionViewLayout: CollectionViewFlowLayout {
    
    public var minimumScaleFactor: CGFloat = 0.8
    
    override public func prepare() {
        super.prepare()
        guard let collectionView = self.collectionView else { return }
        
        if scrollDirection == .horizontal {
            let inset = abs(collectionView.bounds.width - itemSize.width) / 2
            sectionInset.left = inset
            sectionInset.right = inset
        } else {
            let inset = abs(collectionView.bounds.height - itemSize.height) / 2
            sectionInset.top = inset
            sectionInset.bottom = inset
        }
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
    }
    
    override public func transformAttributesForHorizontal(attributes: UICollectionViewLayoutAttributes?) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = self.collectionView else { return attributes }
        guard let attributes = super.transformAttributesForHorizontal(attributes: attributes) else { return nil }

        let centerX = collectionView.bounds.width / 2
        let attributesCenterX = attributes.center.x - collectionView.contentOffset.x
        let standardArea = collectionView.bounds.width
        let distance = abs(centerX - attributesCenterX)
        
        let scaleFactor = max(minimumScaleFactor, min(1, 1 - (distance / (standardArea > 0 ? standardArea : 1))))
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scaleFactor, scaleFactor, 1)
        return attributes
    }
    
    override public func transformAttributesForVertical(attributes: UICollectionViewLayoutAttributes?) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = self.collectionView else { return attributes }
        guard let attributes = super.transformAttributesForVertical(attributes: attributes) else { return nil }
        let centerY = collectionView.bounds.height / 2
        let attributesCenterY = attributes.center.y - collectionView.contentOffset.y
        let standardArea = collectionView.bounds.height
        let distance = abs(centerY - attributesCenterY)
        
        let scaleFactor = max(minimumScaleFactor, min(1, 1 - (distance / (standardArea > 0 ? standardArea : 1))))
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scaleFactor, scaleFactor, 1)
        return attributes
    }
}
