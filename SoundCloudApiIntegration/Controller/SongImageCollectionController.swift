//
//  CollectionVCtest.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 04/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit
import AVFoundation

protocol ImageScrollDelegate {
    func didScrollToNewImage()
}

class ImageCollectionController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var collectionViewFlowLayout : UICollectionViewFlowLayout {
        return collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    var imageScrollDelegate : ImageScrollDelegate?
    var songs = [Song]()
    var scrollToIndex = 0
    var isLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToNextCell) , name: .nextButtonPressed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToPrevCell) , name: .prevButtonPressed, object: nil)

        //SPACING BETWEEN EACH CELL
        collectionViewFlowLayout.minimumLineSpacing = 0
    }
    
    // ------------------------- SETTING UP THE COLLECTION VIEW ----------------------------
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isLoaded == false {
            print(Constants.shared.songIndex)
            //DISPLAY THE VALUE IN THE ELEMENT THAT WAS PRASSED + TOTAL VALUES IN THE INDEX TO ENABLE SCROLLING BACK FROM INDEX 0
            scrollToIndex = Constants.shared.songIndex + (songs.count * 100)
            let indexToScrollTo = IndexPath(item: scrollToIndex, section: 0)
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
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //GETTING THE NEXT SONG INDEX
        let x = targetContentOffset.pointee.x
        Constants.shared.songIndex = Int(x / view.frame.width) % songs.count
        scrollToIndex = Int(x / view.frame.width)
        imageScrollDelegate?.didScrollToNewImage()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SongImageCellView.PLAYERVC_CELL_ID, for: indexPath) as? SongImageCellView else { return UICollectionViewCell() }
        //MODULE MAKES IT POSSIBLE TO SCROLL "FOREVER" TO EACH DIRECTION
        let index = indexPath.row % songs.count
        cell.song = songs[index]
        return cell
    }
    
    //MAKES THE CELL THE SIZE OF THE VIEW
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    //NOTIFICATION OBSORVER FUNCS
    @objc func scrollToNextCell(){
        scrollToIndex += 1

        let indexPathToScrollTo = IndexPath(row: scrollToIndex, section: 0)
        collectionView.scrollToItem(at: indexPathToScrollTo, at: .centeredHorizontally, animated: true)
    }
    
    @objc func scrollToPrevCell(){
        scrollToIndex -= 1

        let indexPathToScrollTo = IndexPath(row: scrollToIndex, section: 0)
        collectionView.scrollToItem(at: indexPathToScrollTo, at: .centeredHorizontally, animated: true)
    }
}


