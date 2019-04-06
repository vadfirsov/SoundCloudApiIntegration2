//
//  PlayerVC.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 03/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit


class PlayerView: UIViewController {

    var songArray = [SongDetailsModel]()
    var imageDic = [String : UIImage?]()
    var songIndex = 0
    
    let pauseString = "PAUSE"
    let playString = "PLAY"
    
    
    var playController = Player()
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var playPauseOutlet: UIButton!

    @IBAction func nextButton(_ sender: UIButton) {
        songIndex += 1
        playController.stopAndDealloc()
        if songIndex == songArray.count {
            songIndex = 0
        }
        songNameLabel.text = songArray[songIndex].title
        playController.startStreamingWithSongID(songID: songArray[songIndex].id)
        NotificationCenter.default.post(name: .nextButtonPressed, object: nil)
    }
    
    @IBAction func prevButton(_ sender: UIButton) {
        songIndex -= 1
    }
    
    @IBAction func playePauseButton(_ sender: UIButton) {
        if playController.player?.rate == 0 {
            playController.player?.play()
            playPauseOutlet.setTitle(playString, for: .normal)
        } else {
            playController.player?.pause()
            playPauseOutlet.setTitle(pauseString, for: .normal)
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //STARTS STREAMING THE SONG FROM URL
        playController.startStreamingWithSongID(songID: songArray[songIndex].id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songNameLabel.text = songArray[songIndex].title
        
        myCollectionViewController.songArray = songArray
        myCollectionViewController.imageDic = imageDic
        myCollectionViewController.songIndex = songIndex
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
}
