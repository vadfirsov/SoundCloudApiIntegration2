//
//  PlayerVC.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 03/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

class PlayerVC: UIViewController {

    var songArray = [SongDetailsModel]()
    var imageDic = [String : UIImage?]()
    var songIndex = 0
    
    var playController = PlayerController()
    
    @IBOutlet weak var playPauseOutlet: UIButton!
    
    @IBAction func nextButton(_ sender: UIButton) {
    }
    @IBAction func prevButton(_ sender: UIButton) {
    }
    @IBAction func playePauseButton(_ sender: UIButton) {
        if playController.player?.rate == 0 {
            playController.player?.play()
            playPauseOutlet.setTitle("PAUSE", for: .normal)
        } else {
            playController.player?.pause()
            playPauseOutlet.setTitle("PLAY", for: .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //STARTS STREAMING THE SONG FROM URL
        playController.startStreamingWithSongID(songID: songArray[songIndex].id)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //STOPS AND DEALLOC THE SONG WHEN EXITING THE VC
        playController.stopAndDealloc()
    }
    
    var myCollectionViewController: PlayerCollectionView!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let myCollectionViewController = segue.destination as? PlayerCollectionView {
            self.myCollectionViewController = myCollectionViewController
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCollectionViewController.songArray = songArray
        myCollectionViewController.imageDic = imageDic
        myCollectionViewController.songIndex = songIndex
    }
}
