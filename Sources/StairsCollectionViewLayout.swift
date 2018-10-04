//
//  StairsCollectionViewLayout.swift
//  CollectionViewLayout-iOS
//
//  Created by Naver on 01/10/2018.
//  Copyright © 2018 CollectionViewLayout. All rights reserved.
//

import UIKit

public class StairsCollectionViewLayout: CollectionViewFlowLayout {
    
    enum Element: String {
        
        case cell
        
        var id: String {
            return self.rawValue
        }
        
        var kind: String {
            switch self {
            case .cell: return "Kind\(self.rawValue.capitalized)"
            }
        }
    }
    
    private var contentSize: CGSize = .zero
    private var cache: [Element: [IndexPath: UICollectionViewLayoutAttributes]] = [:]
    
    var margin: CGFloat = 100
    
    override public var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override public func prepare() {
        prepareCache()
        contentSize = .zero
        
        if scrollDirection == .horizontal {
            prepareForHorizontal()
        } else {
            prepareForVertical()
        }
    }
    
    private func prepareForHorizontal() {
        guard let collectionView = self.collectionView else { return }
        let inset = abs(collectionView.bounds.width - itemSize.width) / 2
        sectionInset.left = inset
        sectionInset.right = inset
        
        for section in 0..<collectionView.numberOfSections {
            var x: CGFloat = inset
            let y: CGFloat = (collectionView.bounds.height - itemSize.height) / 2
            
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                let attributes = CollectionViewLayoutAttributes(forCellWith: indexPath)
                
                var rect = attributes.frame
                rect.origin = CGPoint(x: x, y: y)
                rect.size = itemSize
                
                x += margin
                
                attributes.frame = rect
                attributes.initialRect = rect
                attributes.zIndex = collectionView.numberOfItems(inSection: section) - item
                
                contentSize.width = attributes.frame.maxX
                cache[.cell]?[indexPath] = attributes
            }
        }
        
        contentSize.width += inset
        contentSize.height = collectionView.bounds.height
    }
    
    private func prepareForVertical() {
        guard let collectionView = self.collectionView else { return }
        let inset = abs(collectionView.bounds.height - itemSize.height) / 2
        sectionInset.top = inset
        sectionInset.bottom = inset
        
        for section in 0..<collectionView.numberOfSections {
            let x: CGFloat = (collectionView.bounds.width - itemSize.width) / 2
            var y: CGFloat = inset
            
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                let attributes = CollectionViewLayoutAttributes(forCellWith: indexPath)
                
                var rect = attributes.frame
                rect.origin = CGPoint(x: x, y: y)
                rect.size = itemSize
                
                y += margin
                
                attributes.frame = rect
                attributes.initialRect = rect
                attributes.zIndex = collectionView.numberOfItems(inSection: section) - item
                
                contentSize.height = attributes.frame.maxY
                cache[.cell]?[indexPath] = attributes
            }
        }
        
        contentSize.height += inset
        contentSize.width = collectionView.bounds.width
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[.cell]?[indexPath]
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache
            .flatMap { $0.value.map { $0.value } }
            .compactMap {
                scrollDirection == .horizontal ? transformAttributesForHorizontal(attributes: $0) : transformAttributesForVertical(attributes: $0)
        }
    }
    
    override public func transformAttributesForHorizontal(attributes: UICollectionViewLayoutAttributes?) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = self.collectionView else { return nil }
        guard let attributes = attributes as? CollectionViewLayoutAttributes else { return nil }
        
        let collectionViewCenterX = collectionView.bounds.width / 2
        let x = attributes.center.x - collectionView.contentOffset.x
        
        if x < collectionViewCenterX {
            let value = abs(x - collectionViewCenterX)
            attributes.frame.origin.x -= value * 2
        }
        
        return attributes
    }
    
    override public func transformAttributesForVertical(attributes: UICollectionViewLayoutAttributes?) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = self.collectionView else { return nil }
        guard let attributes = attributes as? CollectionViewLayoutAttributes else { return nil }
        
        let collectionViewCenterY = collectionView.bounds.height / 2
        let y = attributes.center.y - collectionView.contentOffset.y
        
        if y < collectionViewCenterY {
            let value = abs(y - collectionViewCenterY)
            attributes.frame.origin.y -= value * 2
        }
        
        return attributes
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

extension StairsCollectionViewLayout {
    
    private func prepareCache() {
        cache.removeAll(keepingCapacity: true)
        cache[.cell] = [:]
    }
}
