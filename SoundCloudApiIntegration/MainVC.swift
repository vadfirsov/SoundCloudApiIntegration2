//
//  ViewController.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 02/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    //TO-DO: MAKE LOADING ICONS ON EACH IMAGE
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var songImageArray = [String : UIImage?]()
    var songArray = [SongDetailsModel]()
    var searchedText = ""
    let networkDelegate = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkDelegate.networkDelegate = self
    }
    // SEARCHBAR SET UP AND SEARCH
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchedText = searchBar.text {

            tableView.reloadData()
            networkDelegate.fetchSongArray(songName: searchedText)
        }
    }
    
    // TABLE VIEW SET UP AND CELLS
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainVCCell.CELL_ID, for: indexPath) as? MainVCCell else { return UITableViewCell() }
        cell.showLoader()
        cell.songNameLabel.text = songArray[indexPath.row].title
        
        //REMOVING THE PREVIOUS IMAGE THAT THE CELL HELD
        cell.imageView?.image = nil
        
        if songImageArray[songArray[indexPath.row].title] != nil {
            cell.imageView?.image = songImageArray[songArray[indexPath.row].title]!!
            cell.hideLoader()
        }
        
        return cell
        
    }
}

extension MainVC : NetworkDelegate {
    func receivedSongArray(songArr: [SongDetailsModel]) {
        songArray = songArr
        DispatchQueue.main.sync {
            tableView.reloadData()
        }
    }
    
    func receivedSongImages(imageDic: [String : UIImage?]) {
        songImageArray = imageDic
        tableView.reloadData()
        for i in 0..<songImageArray.count {
            if songImageArray[songArray[i].title] == nil {
                songImageArray[songArray[i].title] = UIImage(named: Constants.NO_IMG)
            }
        }
    }
}
