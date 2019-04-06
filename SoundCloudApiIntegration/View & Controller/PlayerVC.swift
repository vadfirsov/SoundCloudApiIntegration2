//
//  PlayerVC.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 03/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

class PlayerVC: UIViewController {

    var songArray = [SongDetailsModel]()
    var imageDic = [String : UIImage?]()
    var songIndex = 0
    
    var myCollectionViewController: PlayerCollectionView!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let myCollectionViewController = segue.destination as? PlayerCollectionView {
            self.myCollectionViewController = myCollectionViewController
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCollectionViewController.songArray = songArray
        myCollectionViewController.imageDic = imageDic
        myCollectionViewController.songIndex = songIndex
    }
}
