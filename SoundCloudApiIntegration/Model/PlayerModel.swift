//
//  SongPlayer.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 06/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import Foundation
import AVFoundation

class PlayerModel {
    
    //SET TO OPTIONAL IN ORDER TO DEALLOC WHEN WANT TO STOP PLAYING
    var audioPlayer : AVAudioPlayer?
    
    private let BASE_URL = "https://api.soundcloud.com/tracks/"
    private let CLIENT_ID_URL = "/stream?client_id=7447cc9b363c40c4bd203aef5f0410e6"
    
    // BECAUSE PAUSE FUNC JUST MAKES THE RATE 0.0
    func stopAndDealloc() {
        audioPlayer = nil
    }
    
    func getNewSongIndex(isNextPressed : Bool, songCount : Int, songIndex : Int) -> Int {
        
        stopAndDealloc()
        var plusOrMinus = 0
        var indexToGoTo = songIndex
        
        plusOrMinus = isNextPressed ? 1 : -1

        if songIndex == songCount - 1 && isNextPressed {
            indexToGoTo = 0
            return indexToGoTo

        } else if songIndex == 0 && !isNextPressed {
            indexToGoTo = songCount - 1
            return indexToGoTo

        } else {
            indexToGoTo += plusOrMinus
        }
        return indexToGoTo
    }
}

extension PlayerModel : NetworkDelegate {
    func downloadCompleted(data: Data) {
        let data = data
        do {
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer?.play()
            NotificationCenter.default.post(name: .songDidDownload, object: nil)
        } catch {
            print("Unable to make audioPlayer in Player class : \(error)")
        }
    }
}
