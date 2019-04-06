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
    
    private var collectionViewFlowLayout : UICollectionViewFlowLayout {
        return collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    let networkDelegate = NetworkManager()
    
    var songArray = [SongDetailsModel]()
    var imageDic = [String : UIImage?]()
    var songIndex = 0
    var isLoaded = false
    
    var player = AVPlayer()
    let BASE_URL = "https://api.soundcloud.com/tracks/"
    let CLIENT_ID_URL = "/stream?client_id=7447cc9b363c40c4bd203aef5f0410e6"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //SPACING BETWEEN EACH CELL
        collectionViewFlowLayout.minimumLineSpacing = 0
        //SETTING NETWORK DELEGATE TO SELF
        networkDelegate.networkDelegate = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let songID = String(songArray[songIndex].id)
        let url = URL(string: BASE_URL + songID + CLIENT_ID_URL)
        player = AVPlayer.init(url: url!)
        player.play()
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
    
    //MAKES THE CELL THE SIZE OF THE VIEW
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}

extension PlayerCollectionView : NetworkDelegate {
    func didDownloadSong(data: Data) {
        print("SONG HAS BEEN DOWLOADED")
    }
}


