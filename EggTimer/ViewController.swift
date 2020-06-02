//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes: [String:Double] = ["Soft": 5.0, "Medium": 7, "Hard": 12]
    var timer: Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer?.invalidate()
        guard let hardness = sender.titleLabel?.text else { return }
        guard let totalTime = eggTimes[hardness] else { return }
        var remainingTime = totalTime
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            self.updateProgressBar(totalTime, remainingTime)
            if remainingTime == 0 {
                self.timer?.invalidate()
                self.titleLabel.text = "Done!"
                // play alarm sound
            }
            remainingTime-=1
        })
    }
    
    func updateProgressBar(_ totalTime: Double, _ remainingTime: Double) {
        progressBar.progress = Float((totalTime - remainingTime)/totalTime)
    }
    
    func playAlarm() {
        
    }
    
}
