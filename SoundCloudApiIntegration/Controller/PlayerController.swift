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
    let nextBtnString = "▷"
    let prevBtnString = "◁"
    
    var networkManager = NetworkManager()
    var player = PlayerModel()
    var imageCollectionView : ImageCollectionController?

    var timer = Timer()
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var prevButtonOutlet: UIButton!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var playPauseOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Constants.shared.songIndex = songIndex
        setupButtonOutletDesign(forButton: prevButtonOutlet, andTitle: prevBtnString)
        setupButtonOutletDesign(forButton: nextButtonOutlet, andTitle: nextBtnString)
        setupButtonOutletDesign(forButton: playPauseOutlet, andTitle: pauseString)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setupSlider), name: .songDidDownload, object: nil)
        networkManager.networkDelegate = player
        songNameLabel.text = songArray[Constants.shared.songIndex].title
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //DOWNLOAD AND PLAY THE SONG FROM URL
        networkManager.getSong(songID: String(songArray[Constants.shared.songIndex].id))
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
        imageCollectionView = segue.destination as? ImageCollectionController
        imageCollectionView?.songs = songArray
//        imageCollectionView?.songIndex = Constants.index //TO DO!!
        imageCollectionView?.imageScrollDelegate = self
    }
    
    // ---------------------------------- PLAYER BUTTONS -------------------------------------

    @IBAction func nextButton(_ sender: UIButton) {
        //CALCULATES THE NEW SONG INDEX
        Constants.shared.songIndex = player.getNewSongIndex(isNextPressed: true, songCount: songArray.count, songIndex: Constants.shared.songIndex)
        //SENDS NOTIFICATION TO COLLECTIONVIEW TO SCROLL
        NotificationCenter.default.post(name: .nextButtonPressed, object: nil)
        //SETS NEW SONG NAME LABEL, IMAGE AND STARTS STREAMING THE SONG
        setNewSong(withSongIndex: Constants.shared.songIndex)
    }
    
    @IBAction func prevButton(_ sender: UIButton) {
        //CALCULATES THE NEW SONG INDEX
        Constants.shared.songIndex = player.getNewSongIndex(isNextPressed: true, songCount: songArray.count, songIndex: Constants.shared.songIndex)
        //SENDS NOTIFICATION TO COLLECTIONVIEW TO SCROLL
        NotificationCenter.default.post(name: .prevButtonPressed, object: nil)
        //SETS NEW SONG NAME LABEL, IMAGE AND STARTS STREAMING THE SONG
        setNewSong(withSongIndex: Constants.shared.songIndex)
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

    func setNewSong(withSongIndex songIndex : Int) {
        //CANCEL THE DOWNLOAD IF IT WASNT COMPLETED YET
        networkManager.task?.cancel()
        //STOPS THE TIMER
        timer.invalidate()
        //SET NEW SONG LABEL
        songNameLabel.text = songArray[Constants.shared.songIndex].title
        //START STREAMING NEW SONG
        networkManager.getSong(songID: String(songArray[Constants.shared.songIndex].id))
        //SETS NEW SONG NAME
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
    
    func StartSliderUpdateTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            if self.player.audioPlayer != nil {
                if self.player.audioPlayer!.currentTime >= self.player.audioPlayer!.duration - 1.0 {
                    self.SongEnded()
                }
                if self.player.audioPlayer != nil {
                    self.sliderOutlet.value = Float(self.player.audioPlayer!.currentTime)
                }
            }
        })
    }
    
    func SongEnded() {
        //CALCULATES THE NEW SONG INDEX
        Constants.shared.songIndex = player.getNewSongIndex(isNextPressed: true, songCount: songArray.count, songIndex: Constants.shared.songIndex)
        //SENDS NOTIFICATION TO COLLECTIONVIEW TO SCROLL
        NotificationCenter.default.post(name: .prevButtonPressed, object: nil)
        //SETS NEW SONG NAME LABEL, IMAGE AND STARTS STREAMING THE SONG
        setNewSong(withSongIndex: Constants.shared.songIndex)
    }
    
    func setupButtonOutletDesign(forButton button : UIButton, andTitle title : String) {
    
        button.layer.borderWidth = 2
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = button.frame.height/8
        button.clipsToBounds = true
        
        button.setTitle(title, for: .normal)
    }
}

extension PlayerController : ImageScrollDelegate {
    func didScrollToNewImage() {
        player.audioPlayer = nil
        setNewSong(withSongIndex: Constants.shared.songIndex)
    }
}



