//
//  Extensions.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 07/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let nextButtonPressed = Notification.Name(rawValue: "nextButtonPressed")
    static let prevButtonPressed = Notification.Name(rawValue: "prevButtonPressed")
    static let songDidDownload = Notification.Name(rawValue: "songDidDownload")
}

extension UIImageView {
    
    func loadImageUsignUrlString(urlString : String) {
        image = nil
        //LOADING IMAGES ASYNCHRONIOUSLY TO CELL
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                print("error : \(error!)")
                return
            }
            DispatchQueue.main.async(execute: {
                self.image = UIImage(data: data!)
            })
            }.resume()
    }
}


