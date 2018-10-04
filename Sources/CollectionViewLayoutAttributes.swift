//
//  CollectionViewLayoutAttributes.swift
//  CollectionViewLayout-iOS
//
//  Created by Naver on 02/10/2018.
//  Copyright © 2018 CollectionViewLayout. All rights reserved.
//

import UIKit

public class CollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    public var initialRect: CGRect = .zero
    
    override public func copy(with zone: NSZone?) -> Any {
        guard let copiedAttributes = super.copy(with: zone) as? CollectionViewLayoutAttributes else {
            return super.copy(with: zone)
        }
        
        copiedAttributes.initialRect = initialRect
        return copiedAttributes
    }
    
    override public func isEqual(_ object: Any?) -> Bool {
        guard let otherAttributes = object as? CollectionViewLayoutAttributes else {
            return false
        }
        
        if otherAttributes.initialRect != initialRect {
            return false
        }
        
        return super.isEqual(object)
    }
}
