//
//  CollectionVCtest.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 04/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

class SongPlayerCollectionView : HorizontalPagingCollectionVC {
    
    var dataSource = [0, 1, 2, 3, 4, 5, 6] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func calculateSectionInsert() -> CGFloat {
        return 40
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: PlayerVCCell.PLAYERVC_CELL_ID, for: indexPath)
    }
    
}
