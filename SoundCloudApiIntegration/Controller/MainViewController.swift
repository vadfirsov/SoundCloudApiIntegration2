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
    
    var songViewModels = [SongViewModel]()
    var songArray = [Song]()
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
        return songViewModels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.GO_TO_PLAYERVC_ID, sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongCellView.CELL_ID, for: indexPath) as? SongCellView else { return UITableViewCell() }
        cell.songViewModel = songViewModels[indexPath.row]
        if indexPath.row % 2 != 0  {
            cell.backgroundColor = #colorLiteral(red: 0.3179571629, green: 0.4158534408, blue: 0.4780644774, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.2848196328, green: 0.3723941445, blue: 0.4290009737, alpha: 1)
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? PlayerController else { return }
        // INDEX SINFLETON = SELECTED ROW INDEX
        Constants.shared.songIndex = tableView.indexPathForSelectedRow!.row
        
        if segue.identifier == Constants.GO_TO_PLAYERVC_ID {
            destinationVC.songArray = songArray
        }
    }
}

extension MainViewController : NetworkDelegate {
    func receivedSongArray(songArr: [Song]) {
        songArray = songArr
        songViewModels = songArr.map { return SongViewModel(songDetails: $0) }
        DispatchQueue.main.sync {
            tableView.reloadData()
        }
    } 
}
