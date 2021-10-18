//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes : [String : Float] = ["Soft": 0.1, "Medium": 0.8, "Hard": 1]
    var secondsRemaining = Float()
    var timer = Timer()
    var count = Float()
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!

    @IBAction func eggButtonPressed(_ sender: UIButton) {
    
        progressBar.progress = 1
        timer.invalidate()
        let hardness = sender.currentTitle!
        let time = eggTimes[hardness]!
        secondsRemaining = time * 60
        count = (100 / secondsRemaining)/100
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    var player : AVAudioPlayer!
    
    func playSound(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    @objc func updateTimer(time: Double){
        
        if (secondsRemaining > 0) {
            progressBar.progress = progressBar.progress - count
            secondsRemaining -= 1
        } else {
            timer.invalidate()
            playSound()
            labelView.text = "Done"
        }
    }
    
}
