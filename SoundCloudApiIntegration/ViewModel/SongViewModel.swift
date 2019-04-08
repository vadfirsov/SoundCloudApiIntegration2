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
        self.artWorkUrlString = songDetails.artwork_url
    
    }
}


