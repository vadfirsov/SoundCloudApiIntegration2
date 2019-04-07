//
//  MainVCCell.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 02/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

class SongCellView: UITableViewCell {
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songImageView: UIImageView!
    
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    
    var songViewModel : SongViewModel! {
        didSet {
            showLoader()
            songNameLabel.text = songViewModel.songTitle
            if songViewModel.artWorkUrlString != nil {
                songImageView.loadImageUsignUrlString(urlString: songViewModel.artWorkUrlString!)
                hideLoader()
            } else {
                songImageView.image = UIImage(named: Constants.NO_IMG)
                hideLoader()
            }
            setupImageDesign()
        }
    }
    
    static let CELL_ID = "MainVCCell"

    func showLoader(){
        loaderView.isHidden = false
        loaderView.startAnimating()
    }
    
    func hideLoader(){
        loaderView.isHidden = true
        loaderView.stopAnimating()
    }
    
    func setupImageDesign() {
        songImageView.layer.borderWidth = 2
        songImageView.layer.masksToBounds = false
        songImageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        songImageView.layer.cornerRadius = songImageView.frame.height/8
        songImageView.clipsToBounds = true
    }
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
