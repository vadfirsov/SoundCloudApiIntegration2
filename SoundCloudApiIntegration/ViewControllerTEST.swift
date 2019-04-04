//
//  ViewControllerTEST.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 04/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

class ViewControllerTEST: UIViewController {


//    @IBOutlet weak var collectionView: UICollectionView!
//    
//    var songArray = [SongDetailsModel]()
//    var imageDic = [String : UIImage?]()
//    var songIndex = 0
//    
//    
//    var screenSize: CGRect!
//    var screenWidth: CGFloat!
//    var screenHeight: CGFloat!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print(songIndex)
//    }
//    
//    var testVC: SongPlayerCollectionView!
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let testVC = segue.destination as? SongPlayerCollectionView {
//            self.testVC = testVC
//        }
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        testVC.dataSource = [0, 1, 2, 3, 4, 5, 6]
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return songArray.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let viewControllerSize = self.view.frame.size
//        return viewControllerSize
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerVCCell.PLAYERVC_CELL_ID, for: indexPath) as? PlayerVCCell else { return UICollectionViewCell() }
//        
//        cell.songNameLabel.text = songArray[indexPath.row].title
//        cell.songImageView.image = imageDic[songArray[indexPath.row].title]!!
//        
//        return cell
//    }
}
