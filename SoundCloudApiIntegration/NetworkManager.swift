//
//  NetworkManager.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 02/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

class NetworkManager {
    
    let URL_STRING = "https://api.soundcloud.com/tracks?client_id=7447cc9b363c40c4bd203aef5f0410e6&q="
    let DEMI_SONG_NAME = "eminem"
    
    var songArray = [SongDetailsModel]()
    
    func fetchSongArray() {
        let url = URL(string: URL_STRING + DEMI_SONG_NAME)
//        let requestURL = URLRequest(url: url!) whats the difference??
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decodedValues = try JSONDecoder().decode([SongDetailsModel].self, from: data)
                self.songArray = decodedValues
            } catch {
                print("error acured decoding : \(error)")
            }
            self.fetchSongImages()

            for i in self.songArray.indices {
                print(self.songArray[i].title)
            }
        }.resume()
        
    }
    
    func fetchSongImages() {
        var imageArr = [String : UIImage?]()
        DispatchQueue.main.async {
            for i in self.songArray.indices {
                if (self.songArray[i].artwork_url != nil) {
                    imageArr[self.songArray[i].title] = UIImage(named: self.songArray[i].artwork_url!)
                } else {
                    imageArr[self.songArray[i].title] = nil
                }
            }
        }
    }
}
