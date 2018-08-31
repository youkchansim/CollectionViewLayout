//
//  CollectionViewLayout.swift
//  CollectionViewLayout
//
//  Created by Chansim Youk on {TODAY}.
//  Copyright © 2018 CollectionViewLayout. All rights reserved.
//

import UIKit

public class CollectionViewLayout: UICollectionViewLayout {
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesList = super.layoutAttributesForElements(in: rect)
        return attributesList?.compactMap(transformAttributes)
    }
    
    public func transformAttributes(attributes: UICollectionViewLayoutAttributes?) -> UICollectionViewLayoutAttributes? {
        return attributes
    }
}

public class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesList = super.layoutAttributesForElements(in: rect)
        return attributesList?.filter { $0.frame.intersects(rect) }.compactMap(transformAttributes)
    }
    
    func transformAttributes(attributes: UICollectionViewLayoutAttributes?) -> UICollectionViewLayoutAttributes? {
        return scrollDirection == .horizontal ? transformAttributesForHorizontal(attributes: attributes) : transformAttributesForVertical(attributes: attributes)
    }
    
    public func transformAttributesForHorizontal(attributes: UICollectionViewLayoutAttributes?) -> UICollectionViewLayoutAttributes? {
        return attributes
    }
    
    public func transformAttributesForVertical(attributes: UICollectionViewLayoutAttributes?) -> UICollectionViewLayoutAttributes? {
        return attributes
    }
}
