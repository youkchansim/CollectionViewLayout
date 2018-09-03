//
//  CollectionViewController.swift
//  CollectionViewLayoutExample
//
//  Created by Naver on 2018. 8. 30..
//  Copyright © 2018년 CollectionViewLayout. All rights reserved.
//

import UIKit

enum CollectionViewLayoutType: String {
    
    case centerZoom
    
    var item: CollectionViewLayoutItem {
        let factory: Factory
        switch self {
        case .centerZoom: factory = CenterZoomLayoutFactory()
        }
        
        return factory.create()
    }
}

class CollectionViewController: UIViewController {
    
    static func create() -> CollectionViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
    }
    
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    @IBOutlet weak var verticalCollectionView: UICollectionView!
    
    var layoutType: CollectionViewLayoutType = .centerZoom
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let horizontalLayout = layoutType.item.horizontalLayout
        horizontalCollectionView.collectionViewLayout = horizontalLayout
        horizontalCollectionView.dataSource = self
        
        let verticalLayout = layoutType.item.verticalLayout
        verticalCollectionView.collectionViewLayout = verticalLayout
        verticalCollectionView.dataSource = self
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell
        
        return cell ?? CollectionViewCell()
    }
}

class CollectionViewCell: UICollectionViewCell {
    
}
