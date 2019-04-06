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
    
    var myCollectionViewController: PlayerCollectionView!

    var player = Player()
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var playPauseOutlet: UIButton!
    
    @IBOutlet weak var sliderOutlet: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        songNameLabel.text = songArray[songIndex].title
        
        //PASSING RELEVANT INFO TO COLLECTION VIEW TO PRESENT THE SONG IMAGES
        myCollectionViewController.songArray = songArray
        myCollectionViewController.imageDic = imageDic
        myCollectionViewController.songIndex = songIndex
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //STARTS STREAMING THE SONG FROM URL
        player.startStreamingWithSongID(songID: songArray[songIndex].id)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //STOPS AND DEALLOC THE SONG WHEN EXITING THE VC
        player.stopAndDealloc()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let myCollectionViewController = segue.destination as? PlayerCollectionView {
            self.myCollectionViewController = myCollectionViewController
        }
    }
    
    
    @IBAction func nextButton(_ sender: UIButton) {
        //CALCULATES THE NEW SONG INDEX
        songIndex = player.getNewSongIndex(isNextPressed: true, songCount: songArray.count, songIndex: songIndex)
        //SETS NEW SONG NAME LABEL, IMAGE AND STARTS STREAMING THE SONG
        setNewSong(withNotificationName: .nextButtonPressed, andSongIndex: songIndex)
    }
    
    @IBAction func prevButton(_ sender: UIButton) {
        //CALCULATES THE NEW SONG INDEX
        songIndex = player.getNewSongIndex(isNextPressed: false, songCount: songArray.count, songIndex: songIndex)
        //SETS NEW SONG NAME LABEL, IMAGE AND STARTS STREAMING THE SONG
        setNewSong(withNotificationName: .prevButtonPressed, andSongIndex: songIndex)
    }
    
    
    @IBAction func playePauseButton(_ sender: UIButton) {
        if player.player?.rate == 0 {
            player.player?.play()
            playPauseOutlet.setTitle(pauseString, for: .normal)
        } else {
            player.player?.pause()
            playPauseOutlet.setTitle(playString, for: .normal)
        }
    }
    //START SLIDING THE SLIDER
    @IBAction func sliderTouchDown(_ sender: UISlider) {
        print("touch down")
    }
    //END SLIDING THE SLIDER
    @IBAction func sliderTouchUpInside(_ sender: UISlider) {
        print("touch up inside")
    }
    
    
    
    func setNewSong(withNotificationName notificationName : Notification.Name, andSongIndex songIndex : Int) {
        //SET NEW SONG LABEL
        songNameLabel.text = songArray[songIndex].title
        //START STREAMING NEW SONG
        player.startStreamingWithSongID(songID: songArray[songIndex].id)
        //SENDS NOTIFICATION TO COLLECTIONVIEW TO SCROLL
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
}
