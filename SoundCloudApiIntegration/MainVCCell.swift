//
//  MainVCCell.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 02/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

class MainVCCell: UITableViewCell {
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songImageView: UIImageView!
    
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    
    static let CELL_ID = "MainVCCell"

    func showLoader(){
        loaderView.isHidden = false
        loaderView.startAnimating()
    }
    
    func hideLoader(){
        loaderView.isHidden = true
        loaderView.stopAnimating()
    }
    
}
