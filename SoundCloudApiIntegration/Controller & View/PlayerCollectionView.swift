//
//  CollectionVCtest.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 04/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerCollectionView : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    //TO-DO: ADD LOADER WHEN SONG LOADING
    
    //WHATS THE DIFFERENCE BETWEEN private var collectionViewFlowLayout = UICollectionViewFlowLayout() AND THIS?
    private var collectionViewFlowLayout : UICollectionViewFlowLayout {
        return collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    var songArray = [SongDetailsModel]()
    var imageDic = [String : UIImage?]()
    var songIndex = 0
    var isLoaded = false
    
    var indexShmindex = 0
    
    var playerDelegate = PlayerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToNextCell(i:)) , name: .nextButtonPressed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToPrevCell(i:)) , name: .prevButtonPressed, object: nil)


        //SPACING BETWEEN EACH CELL
        collectionViewFlowLayout.minimumLineSpacing = 0
        
    }
    
    
    // ------------------------- SETTING UP THE COLLECTION VIEW ----------------------------
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isLoaded == false {
            //DISPLAY THE VALUE IN THE INDEX ARRAY THAT WAS PRASSED + TOTAL VALUES IN THE INDEX TO ENABLE SCROLLING BACK FROM INDEX 0
            indexShmindex = songIndex + (songArray.count * 10)
            let indexToScrollTo = IndexPath(item: indexShmindex, section: 0)
            collectionView.scrollToItem(at: indexToScrollTo, at: .left, animated: false)
        }
        isLoaded = true
    }
    
    
    func calculateSectionInsert() -> CGFloat {
        return 40
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100000
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerVCCell.PLAYERVC_CELL_ID, for: indexPath) as? PlayerVCCell else { return UICollectionViewCell() }

        cell.songImage.image = imageDic[songArray[indexPath.row % imageDic.count].title]!!
        
        cell.setupImageDesign()
        return cell
    }
    
    //MAKES THE CELL THE SIZE OF THE VIEW
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    @objc func scrollToNextCell(i : Int){
        indexShmindex += 1
        let indexPathToScrollTo = IndexPath(row: indexShmindex, section: 0)
        collectionView.scrollToItem(at: indexPathToScrollTo, at: .centeredHorizontally, animated: true)

    }
    
    @objc func scrollToPrevCell(i : Int){
        indexShmindex -= 1
        let indexPathToScrollTo = IndexPath(row: indexShmindex, section: 0)
        collectionView.scrollToItem(at: indexPathToScrollTo, at: .centeredHorizontally, animated: true)
        
    }
}

extension Notification.Name {
    static let nextButtonPressed = Notification.Name(rawValue: "nextButtonPressed")
    static let prevButtonPressed = Notification.Name(rawValue: "prevButtonPressed")

}
