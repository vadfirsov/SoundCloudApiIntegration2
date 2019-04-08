//
//  PlayerVCCell.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 03/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

class SongImageCellView: UICollectionViewCell {
    
    @IBOutlet weak var songImage: UIImageView!

    var song : Song! {
        didSet {
            if song.artwork_url != nil {
                songImage.loadImageUsignUrlString(urlString: song.artwork_url!)
            } else {
                songImage.image = UIImage(named: Constants.NO_IMG)
            }
            setupImageDesign()
        }
    }
    
    static let PLAYERVC_CELL_ID = "playerVCCell"
    
    func setupImageDesign() {
        songImage.layer.borderWidth = 2
        songImage.layer.masksToBounds = false
        songImage.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        songImage.layer.cornerRadius = songImage.frame.height/8
        songImage.clipsToBounds = true
    }
}
