//
//  NetworkManager.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 02/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import Foundation
//protocol

class NetworkManager {
    
    let URL_STRING = "https://api.soundcloud.com/tracks?"
    let API_KEY = "client_id=7447cc9b363c40c4bd203aef5f0410e6"
    let SONG_NAME = "&q=Eminem"
    
    
    func fetchSongArray() {
        let url = URL(string: URL_STRING + API_KEY + SONG_NAME)
//        let requestURL = URLRequest(url: url!) whats the difference??
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            
            
        }
        
        
        
    }
    
}
