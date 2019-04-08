//
//  Constants.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 03/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import Foundation

class Constants {
    
    static let NO_IMG = "noImage"
    static let GO_TO_PLAYERVC_ID = "goToPlayerVC"
    
    // SINGELTON OF SONG INDEX
    var songIndex : Int

    static let shared = Constants(index: 0)
    
    private init(index : Int) {
        self.songIndex = index
    }

}
