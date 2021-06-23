//
//  PlayingViewController.swift
//  UIKit Nano
//
//  Created by Willian Magnum Albeche on 23/06/21.
//

import UIKit
import AVFoundation

class PlayingViewController: UIViewController {

    @IBOutlet weak var progressBar: UISlider!
    @IBOutlet weak var playButtonOutlet: UIButton!
    
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "audio", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        
        progressBar.maximumValue = Float(player.duration)
        
        let timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: Selector("updateSlider"), userInfo: nil, repeats: true)
    }
    
    @IBAction func playButton(_ sender: UIButton) {
        if !player.isPlaying {
            player.play()
        } else {
            player.pause()
        }
        print("ok")
    }
    
    @IBAction func progressAction(_ sender: UISlider) {
        player.currentTime = TimeInterval(progressBar.value)
    }
    
    @objc func updateSlider(){
        progressBar.value = Float(player.currentTime)
    }
    
}
