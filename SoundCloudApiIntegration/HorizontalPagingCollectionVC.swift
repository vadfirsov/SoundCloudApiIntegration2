//
//  HorizontalPagingCollectionVC.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 04/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

//TAKEN AND MOPDIFIED FROM SHAI BALASSIANO'S ARTICLE https://medium.com/@shaibalassiano/tutorial-horizontal-uicollectionview-with-paging-9421b479ee94
class HorizontalPagingCollectionVC : UICollectionViewController {
    
    private var indexOfCellBeforeDragging = 0
    private var collectionViewFlowLayout : UICollectionViewFlowLayout {
        return collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewFlowLayout.minimumLineSpacing = 0
    }
    
    func calculateSectionInsert() -> CGFloat { //should be overriden
        return 100
    }
    
    private func configureCollectionViewLayoutItemSize() {
        let inset : CGFloat = calculateSectionInsert()
        //THE SPACING FROM LEFT AND RIGHT PARENT VIEW EDGES TO THE CELL
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        //THE DEFAULT SIZE TO USE FOR A CELL
        collectionViewFlowLayout.itemSize = CGSize(width: collectionViewFlowLayout.collectionView!.frame.size.width - inset * 2, height: collectionViewFlowLayout.collectionView!.frame.size.height)
    }
    
    //RETURNS THE INDEX OF THE CURRENT CELL IN THE DATA SOURCE ARRAY
    private func indexOfMajorCell() -> Int {
        //THE DEFAULT WIDTH TO USE FOR CELL
        let itemWidth = collectionViewFlowLayout.itemSize.width
        //THE POINT AT WHICH THE ORIGIN OF THE CONTENT VIEW IS OFFSET FROM THE ORIGIN OF THE SCROLL VIEW IS DEVIDED BY THE WIDTH OF THE CELL
        let proportionalOffSet = collectionViewFlowLayout.collectionView!.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffSet))
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let safeIndex = max(0, min(numberOfItems - 1, index))
        
        return safeIndex
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell()
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //STOP SCROLLVIEW SLIDING
        targetContentOffset.pointee = scrollView.contentOffset
        
        //CALCULATES HERE THE SCROLLVIEW SHOULD SNAP TO
        let indexOfMajorCell = self.indexOfMajorCell()
        
        //CALCULATES CONDITIONS
        let dataSourceCount = collectionView(collectionView!, numberOfItemsInSection: 0)
        let swipeVelocityThreshold : CGFloat = 0.5
        let hasEnoughVelocityToSlideToNextCell = indexOfCellBeforeDragging + 1 < dataSourceCount && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToPreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToNextCell || hasEnoughVelocityToSlideToPreviousCell)
        
        if didUseSwipeToSkipCell {
            
            //CHECKS TO WHICH INDEX TO SWIPR
            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToNextCell ? 1 : -1)
            
            let toValue = collectionViewFlowLayout.itemSize.width * CGFloat(snapToIndex)
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            //A BETTER WAY TO SCROLL TO A CELL
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
