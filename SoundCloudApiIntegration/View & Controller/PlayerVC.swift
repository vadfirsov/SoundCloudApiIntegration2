//
//  PlayerVC.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 03/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

class PlayerVC: UIViewController {

    var myCollectionViewController: SongPlayerCollectionView!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let myCollectionViewController = segue.destination as? SongPlayerCollectionView {
            self.myCollectionViewController = myCollectionViewController
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        myCollectionViewController.dataSource = [0, 1, 2, 3, 4, 5, 6]
    }
}
