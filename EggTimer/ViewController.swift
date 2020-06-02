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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes: [String:Double] = ["Soft": 5.0, "Medium": 7, "Hard": 12]
    var timer: Timer? = nil
    var alarmPlayer: AVAudioPlayer? = nil
    let intoSeconds = 60.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer?.invalidate()
        guard let hardness = sender.titleLabel?.text else { return }
        guard var totalTime = eggTimes[hardness] else { return }
        totalTime = totalTime * intoSeconds
        var remainingTime = totalTime
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            self.updateProgressBar(totalTime, remainingTime)
            if remainingTime == -1 {
                self.timer?.invalidate()
                self.titleLabel.text = "Done!"
                self.playAlarm()
                self.reset()
            }
            remainingTime-=1
        })
    }
    
    func reset() {
        titleLabel.text = "How do you like your eggs?"
        progressBar.progress = 0.0
    }
    
    func updateProgressBar(_ totalTime: Double, _ remainingTime: Double) {
        progressBar.progress = Float((totalTime - remainingTime)/totalTime)
    }
    
    func playAlarm() {
        guard let path = Bundle.main.path(forResource: "alarm_sound.mp3", ofType: nil) else { return }
        let url = URL(fileURLWithPath: path)
        do {
            alarmPlayer = try AVAudioPlayer(contentsOf: url)
            alarmPlayer?.play()
        } catch {
            print("Cannot play alarm sound!")
        }
    }
    
}
