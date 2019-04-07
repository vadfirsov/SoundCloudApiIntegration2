//
//  ViewController.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 02/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var songImageArray = [String : UIImage?]()
    var songArray = [SongDetailsModel]()
    var searchedText = ""
    let networkDelegate = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkDelegate.networkDelegate = self
        //just for now for testing
        networkDelegate.fetchSongArray(songName: "eminem")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.GO_TO_PLAYERVC_ID, sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongCellView.CELL_ID, for: indexPath) as? SongCellView else { return UITableViewCell() }
        cell.showLoader()
        cell.songNameLabel.text = songArray[indexPath.row].title
        
        //REMOVING THE PREVIOUS IMAGE THAT THE CELL HELD
        cell.songImageView?.image = nil
        
        if songImageArray[songArray[indexPath.row].title] != nil {
            cell.songImageView?.image = songImageArray[songArray[indexPath.row].title]!!
            cell.hideLoader()
        }
        
        cell.setupImageDesign()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? PlayerController else { return }
        let indexPath = tableView.indexPathForSelectedRow
        
        if segue.identifier == Constants.GO_TO_PLAYERVC_ID {
            destinationVC.songArray = songArray
            destinationVC.imageDic = songImageArray
            // PASSES THE INDEX WHICH TO SHOW IN PLAYER VC
            destinationVC.songIndex = indexPath!.row
        }
    }
}

extension MainViewController : NetworkDelegate {
    
    func receivedSongArray(songArr: [SongDetailsModel]) {
        songArray = songArr
        DispatchQueue.main.sync {
            tableView.reloadData()
        }
    }
    
    func receivedSongImages(imageDic: [String : UIImage?]) {
//        songImageArray = imageDic
//        self.tableView.reloadData()
//
//        for i in 0..<songImageArray.count {
//            if songImageArray[songArray[i].title] == nil {
//                songImageArray[songArray[i].title] = UIImage(named: Constants.NO_IMG)
//            }
//        }
    }
    
    
}
