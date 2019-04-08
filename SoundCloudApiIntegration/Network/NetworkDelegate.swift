//
//  NetworkDelegate.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 05/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

protocol NetworkDelegate {
    func receivedSongArray(songArr : [Song])
    func downloadCompleted(data : Data)
    //TO-DO: NEED TO HANDLE ERROR DELEGATE
    //    func receivedError(error : Error)
}

//MAKING THE FUNCS OPTIONAL
extension NetworkDelegate {
    func receivedSongArray(songArr : [Song]) {
    }
    
    func downloadCompleted(data : Data) {
    }
}


