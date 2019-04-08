//
//  PlayerVC.swift
//  SoundCloudApiIntegration
//
//  Created by VADIM FIRSOV on 03/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit


class PlayerController: UIViewController {

    var songViewModel = [SongViewModel]()
    var songArray = [Song]()
    var songIndex = 0
    
    let pauseString = "PAUSE"
    let playString = "PLAY"
    
    var networkManager = NetworkManager()

    var player = PlayerModel()
    
    var dasdsad : SongImageCollectionController?

    var timer = Timer()
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var playPauseOutlet: UIButton!
    @IBOutlet weak var sliderOutlet: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        dasdsad.songIndex = songIndex
//        dasdsad.songs = songArray
//        dasdsad.imageScrollDelegate = self
//        NotificationCenter.default.addObserver(self, selector: #selector(someFunc), name: .scrolledToNextSong, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setupSlider), name: .songDidDownload, object: nil)
        networkManager.networkDelegate = player
        songNameLabel.text = songArray[songIndex].title
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //DOWNLOAD AND PLAY THE SONG FROM URL
        networkManager.getSong(songID: String(songArray[songIndex].id))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //STOPS AND DEALLOC THE SONG WHEN EXITING THE VC
        player.stopAndDealloc()
        //DEALLOC THE TIMER
        timer.invalidate()
        
        networkManager.task?.cancel()
    }
    
    //PASSING RELEVANT INFO TO COLLECTION VIEW TO PRESENT THE IMAGE COLLECTION VIEW
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destinatiocVC = segue.destination as? SongImageCollectionController else { return }
        dasdsad = segue.destination as? SongImageCollectionController
        dasdsad?.songs = songArray
        dasdsad?.songIndex = songIndex
        dasdsad?.imageScrollDelegate = self
        
        
        
    }
    
    // ---------------------------------- PLAYER BUTTONS -------------------------------------

    @IBAction func nextButton(_ sender: UIButton) {
        //CANCEL THE DOWNLOAD IF IT WASNT COMPLETED YET

        networkManager.task?.cancel()
        timer.invalidate()
        //CALCULATES THE NEW SONG INDEX
        songIndex = player.getNewSongIndex(isNextPressed: true, songCount: songArray.count, songIndex: songIndex)
        //SETS NEW SONG NAME LABEL, IMAGE AND STARTS STREAMING THE SONG
        setNewSong(withNotificationName: .nextButtonPressed, andSongIndex: songIndex)
    }
    
    @IBAction func prevButton(_ sender: UIButton) {
        //CANCEL THE DOWNLOAD IF IT WASNT COMPLETED YET
        networkManager.task?.cancel()
        //STOPS THE TIMER
        timer.invalidate()
        //CALCULATES THE NEW SONG INDEX
        songIndex = player.getNewSongIndex(isNextPressed: false, songCount: songArray.count, songIndex: songIndex)
        //SETS NEW SONG NAME LABEL, IMAGE AND STARTS STREAMING THE SONG
        setNewSong(withNotificationName: .prevButtonPressed, andSongIndex: songIndex)
    }
    
    
    @IBAction func playePauseButton(_ sender: UIButton) {
       
        if player.audioPlayer != nil && !player.audioPlayer!.isPlaying {
            player.audioPlayer?.play()
            playPauseOutlet.setTitle(pauseString, for: .normal)
        } else {
            player.audioPlayer?.pause()
            playPauseOutlet.setTitle(playString, for: .normal)
        }
    }

    
    func setNewSong(withNotificationName notificationName : Notification.Name, andSongIndex songIndex : Int) {
        //SET NEW SONG LABEL
        songNameLabel.text = songArray[songIndex].title
        //START STREAMING NEW SONG
        networkManager.getSong(songID: String(songArray[songIndex].id))
        //SENDS NOTIFICATION TO COLLECTIONVIEW TO SCROLL
        NotificationCenter.default.post(name: notificationName, object: nil)
        
        playPauseOutlet.setTitle(pauseString, for: .normal)
    }
    
    // ---------------------------------- SLIDER -------------------------------------
    
    //START SLIDING THE SLIDER
    @IBAction func sliderTouchDown(_ sender: UISlider) {
        player.audioPlayer?.pause()
    }
    //END SLIDING THE SLIDER
    @IBAction func sliderTouchUpInside(_ sender: UISlider) {
        player.audioPlayer?.currentTime = Double(sliderOutlet.value)
        player.audioPlayer?.play()
    }
    
    @objc func setupSlider() {
        DispatchQueue.main.sync {
            if player.audioPlayer != nil {
                let songDuration = Float(player.audioPlayer!.duration)
                sliderOutlet.value = 0.0
                sliderOutlet.maximumValue = songDuration
                StartSliderUpdateTimer()
            }
        }
    }
    
    func songEnded() {
            //CANCEL THE DOWNLOAD IF IT WASNT COMPLETED YET
            networkManager.task?.cancel()
            //STOPS THE TIMER
            timer.invalidate()
            //CALCULATES THE NEW SONG INDEX
            songIndex = player.getNewSongIndex(isNextPressed: false, songCount: songArray.count, songIndex: self.songIndex)
            //SETS NEW SONG NAME LABEL, IMAGE AND STARTS STREAMING THE SONG
            self.setNewSong(withNotificationName: .prevButtonPressed, andSongIndex: self.songIndex)
            return
    }
    
    func StartSliderUpdateTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            if self.player.audioPlayer != nil {
                if self.player.audioPlayer!.currentTime >= self.player.audioPlayer!.duration - 1.0 {
                    self.songEnded()
                }
                if self.player.audioPlayer != nil {
                    self.sliderOutlet.value = Float(self.player.audioPlayer!.currentTime)
                }
            }
        })
    }
}

extension PlayerController : ImageScrollDelegate {
    func didScrollToNewIndex(indexScrolledTo: Int) {
        let indexToScrollTo = indexScrolledTo
        player.audioPlayer = nil
        networkManager.task?.cancel()
        timer.invalidate()
        songNameLabel.text = songArray[indexToScrollTo].title
        //START STREAMING NEW SONG
        networkManager.getSong(songID: String(songArray[indexToScrollTo].id))
        playPauseOutlet.setTitle(pauseString, for: .normal)
    }
}



