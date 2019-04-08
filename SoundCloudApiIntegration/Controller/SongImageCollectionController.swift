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
    func didScrollToNewIndex(indexScrolledTo : Int)
}

class SongImageCollectionController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //WHATS THE DIFFERENCE BETWEEN private var collectionViewFlowLayout = UICollectionViewFlowLayout() AND THIS?
    private var collectionViewFlowLayout : UICollectionViewFlowLayout {
        return collectionViewLayout as! UICollectionViewFlowLayout
    }
//    var pageControl = UIPageControl() WHATS DAT?
    var songs = [Song]()
    var songIndex = 0
    var isLoaded = false
    
    var scrollToIndex = 0
    
    var imageScrollDelegate : ImageScrollDelegate?
        
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
            //DISPLAY THE VALUE IN THE ELEMENT THAT WAS PRASSED + TOTAL VALUES IN THE INDEX TO ENABLE SCROLLING BACK FROM INDEX 0
            songIndex = songIndex + (songs.count * 100)
            scrollToIndex = songIndex
            let indexToScrollTo = IndexPath(item: songIndex, section: 0)
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
        let index = Int(x / view.frame.width) % songs.count
        imageScrollDelegate?.didScrollToNewIndex(indexScrolledTo : index)
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
        print(view.frame.width)
        let indexPathToScrollTo = IndexPath(row: scrollToIndex, section: 0)
        collectionView.scrollToItem(at: indexPathToScrollTo, at: .centeredHorizontally, animated: true)

    }
    @objc func scrollToPrevCell(){
        scrollToIndex -= 1
        let indexPathToScrollTo = IndexPath(row: scrollToIndex, section: 0)
        print(scrollToIndex)
        collectionView.scrollToItem(at: indexPathToScrollTo, at: .centeredHorizontally, animated: true)
    }
}


