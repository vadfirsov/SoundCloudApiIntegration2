//
//  CollectionVCtest.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 04/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

class SongPlayerCollectionView : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var collectionViewFlowLayout : UICollectionViewFlowLayout {
        return collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    var songArray = [SongDetailsModel]()
    var imageDic = [String : UIImage?]()
    var songIndex = 0
    var isLoaded = false
    var someNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewFlowLayout.minimumLineSpacing = 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isLoaded == false {
            //DISPLAY THE VALUE IN THE INDEX ARRAY THAT WAS PRASSED + TOTAL VALUES IN THE INDEX TO ENABLE SCROLLING BACK FROM INDEX 0
            let indexToScrollTo = IndexPath(item: songIndex + (songArray.count * 10), section: 0)
            collectionView.scrollToItem(at: indexToScrollTo, at: .left, animated: false)
        }
        isLoaded = true
    }
    
    func calculateSectionInsert() -> CGFloat {
        return 40
    }
    
    private func configureCollectionViewLayoutItemSize() {
        let inset : CGFloat = calculateSectionInsert()
        //THE SPACING FROM LEFT AND RIGHT PARENT VIEW EDGES TO THE CELL
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        //THE DEFAULT SIZE TO USE FOR A CELL
        collectionViewFlowLayout.itemSize = CGSize(width: collectionViewFlowLayout.collectionView!.frame.size.width - inset * 2, height: collectionViewFlowLayout.collectionView!.frame.size.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100000
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerVCCell.PLAYERVC_CELL_ID, for: indexPath) as? PlayerVCCell else { return UICollectionViewCell() }

            cell.songNameLabel.text = songArray[indexPath.row % songArray.count].title
            cell.songImage.image = imageDic[songArray[indexPath.row % imageDic.count].title]!!
        
            cell.setupImageDesign()
                return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}


