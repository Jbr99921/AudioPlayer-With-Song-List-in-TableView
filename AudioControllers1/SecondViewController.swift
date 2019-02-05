//
//  SecondViewController.swift
//  AudioControllers1
//
//  Created by JigneshRajora on 22/11/18.
//  Copyright © 2018 JigneshRajora. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var songSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = songs[currentSong]
        
        songSlider.maximumValue = Float(audioPlayer.duration)
        songSlider.value = 0.0
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
            audioPlayer.play()
    }
    func playSong(thisOne:String)
    {
        do
        {
            let audioPath = Bundle.main.path(forResource: thisOne, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
        }
        catch
        {
            print ("ERROR")
        }
    }
    @IBAction func play(_ sender: Any)
    {
         if audioStuffed == true && audioPlayer.isPlaying == false
//        if audioStuffed == true && audioPlayer.isPlaying == false
        {
           audioPlayer.prepareToPlay()
            songSlider.maximumValue = Float(audioPlayer.duration)
            songSlider.value = 0.0
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
            audioPlayer.play()
            print(songSlider.value)
        }
}
    @objc func updateTime(_ timer: Timer) {
        songSlider.value = Float(audioPlayer.currentTime)
    }    
    @IBAction func pause(_ sender: Any)
    {
        if audioStuffed == true && audioPlayer.isPlaying
        {
            audioPlayer.pause()
          //  audioPlayer.currentTime = TimeInterval(songSlider.value)
            print(songSlider.value)
        }
    }
    @IBAction func prev(_ sender: Any)
    {
        if currentSong != 0 && audioStuffed == true
        {
            playSong(thisOne: songs[currentSong-1])
            currentSong -= 1
            label.text = songs[currentSong]
        }
        else
        {
            print("Error")
        }
    }
    @IBAction func next(_ sender: Any)
    {
        if currentSong < songs.count-1 && audioStuffed == true
        {
            playSong(thisOne: songs[currentSong+1])
            currentSong += 1
            label.text = songs[currentSong]
        }
        else
        {
            print("Error")
        }
    }
    @IBAction func SlideSongPosition(_ sender: UISlider) {
        audioPlayer.currentTime = TimeInterval(songSlider.value)
        print(audioPlayer.currentTime)
    }
}

