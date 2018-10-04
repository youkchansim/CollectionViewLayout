//
//  Factory.swift
//  CollectionViewLayoutExample
//
//  Created by Naver on 2018. 8. 31..
//  Copyright © 2018년 CollectionViewLayout. All rights reserved.
//

import UIKit

struct CollectionViewLayoutItem {
    
    let verticalLayout: UICollectionViewLayout
    let horizontalLayout: UICollectionViewLayout
}

protocol Factory {
    
    func create() -> CollectionViewLayoutItem
}

struct CenterZoomLayoutFactory: Factory {
    
    func create() -> CollectionViewLayoutItem {
        let horizontalLayout = LinearCenterZoomCollectionViewLayout()
        horizontalLayout.scrollDirection = .horizontal
        horizontalLayout.minimumInteritemSpacing = 10
        horizontalLayout.minimumLineSpacing = 10
        horizontalLayout.itemSize = CGSize(width: 300, height: 200)
        
        let verticalLayout = LinearCenterZoomCollectionViewLayout()
        verticalLayout.scrollDirection = .vertical
        verticalLayout.minimumInteritemSpacing = 10
        verticalLayout.minimumLineSpacing = 10
        verticalLayout.itemSize = CGSize(width: 200, height: 300)
        
        return CollectionViewLayoutItem(verticalLayout: verticalLayout, horizontalLayout: horizontalLayout)
    }
}

struct StairsCollectionViewLayoutFactory: Factory {
    
    func create() -> CollectionViewLayoutItem {
        let horizontalLayout = StairsCollectionViewLayout()
        horizontalLayout.scrollDirection = .horizontal
        horizontalLayout.margin = 50
        horizontalLayout.itemSize = CGSize(width: 150, height: 250)
        
        let verticalLayout = StairsCollectionViewLayout()
        verticalLayout.scrollDirection = .vertical
        verticalLayout.margin = 50
        verticalLayout.itemSize = CGSize(width: 300, height: 200)
        
        return CollectionViewLayoutItem(verticalLayout: verticalLayout, horizontalLayout: horizontalLayout)
    }
}
