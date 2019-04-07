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
    @IBOutlet weak var songNameLabel: UILabel!
    
    static let PLAYERVC_CELL_ID = "playerVCCell"
    
    func setupImageDesign() {
        songImage.layer.borderWidth = 2
        songImage.layer.masksToBounds = false
        songImage.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        songImage.layer.cornerRadius = songImage.frame.height/8
        songImage.clipsToBounds = true
    }
}
