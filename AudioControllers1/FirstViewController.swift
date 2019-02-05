//
//  FirstViewController.swift
//  AudioControllers1
//
//  Created by JigneshRajora on 22/11/18.
//  Copyright © 2018 JigneshRajora. All rights reserved.
//

import UIKit
import AVFoundation

var audioPlayer = AVAudioPlayer()
var songs:[String] = []
var currentSong = 0

var audioStuffed = false

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
        
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        gettingSongNames()
    }
    func gettingSongNames()
    {
        let folderURL = URL(fileURLWithPath:Bundle.main.resourcePath!)
        do
        {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            print(songPath)
            for song in songPath
            {
                var mySong = song.absoluteString
               print(mySong)
                if mySong.contains(".mp3")
                {
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count-1]
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    songs.append(mySong)
                    print(songs)
                }
            }
            
            myTableView.reloadData()
        }
        catch
        {
            print ("ERROR")
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return songs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TblCell
        cell.LblSongName.text = songs[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        do
        {
            let audioPath = Bundle.main.path(forResource: songs[indexPath.row], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
           currentSong = indexPath.row
            audioStuffed = true
        }
        catch
        {
            print ("ERROR")
        }
    }
}
