//
//  TimerViewController.swift
//  Clock
//
//  Created by Tomonao Hashiguchi on 2022-05-23.
//

import UIKit

class TimerViewController: UIViewController, AddTimerViewControllerDelegate {
    
    @IBOutlet var hourLabel: UILabel!
    @IBOutlet var minutesLabel: UILabel!
    @IBOutlet var secondsLabel: UILabel!
    @IBOutlet var controlButton: UIButton!
    
    var timer: Timer?
    var prevTimer: [Int]?
    var totalWorkSeconds = 0
    var isTimerWorkingNow = false {
        didSet{
            if isTimerWorkingNow {
                controlButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            }else{
                controlButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            }
        }
    }
    
    var seconds: Int = 0{
        didSet{
            var secondsText: String
            if seconds == -1{
                minutes -= 1
                seconds = 59
                secondsText = "\(seconds)"
            }else if seconds < 10{
                secondsText = "0\(seconds)"
            }else{
                secondsText = "\(seconds)"
            }
            secondsLabel.text = secondsText
        }
    }
    var minutes: Int = 0{
        didSet{
            var minutesText: String
            if minutes == -1{
                hours -= 1
                minutes = 59
                minutesText = "\(minutes)"
            }else if minutes < 10{
                minutesText = "0\(minutes)"
            }else{
                minutesText = "\(minutes)"
            }
            minutesLabel.text = minutesText
        }
    }
    var hours: Int = 0{
        didSet{
            var hourText: String
            if hours < 10 {
                hourText = "0\(hours)"
            }else{
                hourText = "\(hours)"
            }
            hourLabel.text = hourText
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setTimer(){
        guard isTimerWorkingNow else {return}
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
    }
    func stopTimer(){
        isTimerWorkingNow = false
        timer?.invalidate()
    }
    func resetTimer(){
        isTimerWorkingNow = false
        if let prevTimer = prevTimer {
            self.totalWorkSeconds = prevTimer[3]
            self.hours = prevTimer[0]
            self.minutes = prevTimer[1]
            self.seconds = prevTimer[2]
        }
    }
    
    @objc func startTimer(){
        totalWorkSeconds -= 1
        seconds -= 1
        
        if totalWorkSeconds == 0{
            stopTimer()
            let alert = UIAlertController(title: "Time is up", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.resetTimer()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func add(hours: Int, minutes: Int, seconds: Int) {
        totalWorkSeconds = hours * 3600 + minutes * 60 + seconds
        controlButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        isTimerWorkingNow = true
        setTimer()
        prevTimer = [hours, minutes, seconds, totalWorkSeconds]
    }

    @IBAction func cotrolButtonTapped(_ sender: UIButton) {
        guard totalWorkSeconds != 0 else { return }
        if isTimerWorkingNow {
            stopTimer()
        }else{
            isTimerWorkingNow = true
            setTimer()
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        resetTimer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        stopTimer()
        if segue.identifier == "addTimerVC"{
            let addTimerVC = segue.destination as! AddTimerViewController
            addTimerVC.delegate = self
        }
    }
}
