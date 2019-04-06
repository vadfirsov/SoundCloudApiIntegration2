//
//  SongPlayer.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 06/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import Foundation
import AVFoundation

class Player {
    
    //SET TO OPTIONAL IN ORDER TO DEALLOC WHEN WANT TO STOP PLAYING
    var player : AVPlayer?
    
    private let BASE_URL = "https://api.soundcloud.com/tracks/"
    private let CLIENT_ID_URL = "/stream?client_id=7447cc9b363c40c4bd203aef5f0410e6"
    
    func startStreamingWithSongID(songID : Int) {
        
        let url = URL(string: BASE_URL + String(songID) + CLIENT_ID_URL)
        player = AVPlayer(url: url!)
        player!.play()
    }
    
    // BECAUSE PAUSE FUNC JUST MAKES THE RATE 0.0
    func stopAndDealloc() {
        player = nil
    }
}
