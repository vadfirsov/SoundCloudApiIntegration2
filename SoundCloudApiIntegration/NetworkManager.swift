//
//  NetworkManager.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 02/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

protocol NetworkDelegate {
    func receivedSongImages(imageDic : [String : UIImage?])
    func receivedSongArray(songArr : [SongDetailsModel])
    //TO-DO: NEED TO HANDLE ERROR DELEGATE
//    func receivedError(error : Error)
}

class NetworkManager {
    
    var networkDelegate : NetworkDelegate?
    
    let URL_STRING = "https://api.soundcloud.com/tracks?client_id=7447cc9b363c40c4bd203aef5f0410e6&q="
//    let DEMI_SONG_NAME = "eminem"
    
    var songArray = [SongDetailsModel]()
    
    func fetchSongArray(songName : String) {
        let url = URL(string: URL_STRING + songName)
//        let requestURL = URLRequest(url: url!) whats the difference??
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decodedValues = try JSONDecoder().decode([SongDetailsModel].self, from: data)
                self.songArray = decodedValues
            } catch {
                print("error acured decoding : \(error)")
                //TO-DO: NEED TO HANDLE ERROR DELEGATE
//                self.networkDelegate?.receivedError(error: <#T##Error#>)
            }
            self.networkDelegate?.receivedSongArray(songArr: self.songArray)
            self.downloadSongImagesAndTitle()

        }.resume()

    }
    //DOWNLOADING THE IMAGES (PUTTING THE LABELS IN THE CELLS FIRST AND AFTER THE DOWNLOAD IS FINISHED PUTING THE IMAGE)
    //TO-DO: DOWNLOAD AND PUT IMAGE EACH IN A TIME AND ADD LOADING ICON
    func downloadSongImagesAndTitle() {
        var imageArr = [String : UIImage?]()
        DispatchQueue.main.async {
            for i in self.songArray.indices {
                if (self.songArray[i].artwork_url != nil) {
                    do {
                        let imageUrl = URL(string: self.songArray[i].artwork_url!)
                        let data = try Data(contentsOf: imageUrl!)
                        imageArr[self.songArray[i].title] = UIImage(data: data)
                    } catch let err {
                        print ("Error : \(err.localizedDescription)")
                    }
                } else {
                    imageArr[self.songArray[i].title] = nil
                }
            }
            self.networkDelegate?.receivedSongImages(imageDic: imageArr)
        }
    }
}
