//
//  SongCellViewModel.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 07/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

struct SongViewModel {
    
    let songTitle : String
    let artWorkUrlString : String?
    
    //DEPENDENCY INJECTION (DI)
    init(songDetails : Song) {
        self.songTitle = songDetails.title
//        if songDetails.artwork_url != nil {
//            self.imageView.loadImageUsignUrlString(urlString: songDetails.artwork_url!)
//        } else {
//            self.imageView.image = UIImage(named: Constants.NO_IMG)
//        }
        self.artWorkUrlString = songDetails.artwork_url
        
    }
    
}


