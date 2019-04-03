//
//  ViewController.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 02/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let network = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network.fetchSongArray()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainVCCell.CELL_ID, for: indexPath) as? MainVCCell else { return UITableViewCell() }
        cell.songNameLabel.text = "lol just for now thoooooooooooooo"
        return cell
    }


}

