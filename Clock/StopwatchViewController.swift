//
//  StopwatchViewController.swift
//  Clock
//
//  Created by Tomonao Hashiguchi on 2022-05-22.
//

import UIKit

class StopwatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var minituesLabel: UILabel!
    @IBOutlet var secondsLabel: UILabel!
    @IBOutlet var milliSecondsLable: UILabel!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet var lapButton: UIButton!
    
    var isStopwatchWorking = false
    var lapTimes: [String] = []
    var timer = Timer()
    var minitues: Int = 0{
        didSet{
            var labelText: String
            if minitues < 10 {
                labelText = "0\(minitues)"
            }else{
                labelText = "\(minitues)"
            }
            minituesLabel.text = labelText
        }
    }
    var seconds: Int = 0{
        didSet{
            var labelText: String
            if seconds < 10 {
                labelText = "0\(seconds)"
            }else if seconds < 61{
                labelText = "\(seconds)"
            }else{
                minitues += 1
                seconds = 0
                labelText = "0\(seconds)"
            }
            secondsLabel.text = labelText
        }
    }
    var milliSeconds: Int = 0{
        didSet{
            var labelText: String
            if milliSeconds < 10 {
                labelText = "0\(milliSeconds)"
            }else if milliSeconds < 100{
                labelText = "\(milliSeconds)"
            }else{
                seconds += 1
                milliSeconds = 0
                labelText = "0\(milliSeconds)"
            }
            milliSecondsLable.text = labelText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonDesign()
    }
    
    func setupButtonDesign(){
        playButton.layer.cornerRadius = 75/2
        restartButton.layer.cornerRadius = 40/2
        lapButton.layer.cornerRadius = 40/2
        playButton.clipsToBounds = true
        restartButton.clipsToBounds = true
        lapButton.clipsToBounds = true
        controlVisibleOfButtons()
    }
    
    func controlVisibleOfButtons(){
        if isStopwatchWorking{
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            lapButton.isEnabled = true
            lapButton.alpha = 1
        }else{
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            lapButton.isEnabled = false
            lapButton.alpha = 0
        }
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        if isStopwatchWorking{
            timer.invalidate()
        }else{
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(increseMilliSeconds), userInfo: nil, repeats: true)
        }
        isStopwatchWorking.toggle()
        controlVisibleOfButtons()
    }
    
    @objc fileprivate func increseMilliSeconds(){
        milliSeconds += 1
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        if isStopwatchWorking{
            timer.invalidate()
            isStopwatchWorking = false
            controlVisibleOfButtons()
        }
        lapTimes.removeAll()
        tableView.reloadData()
        minitues = 0
        seconds = 0
        milliSeconds = 0
    }
    @IBAction func lapButtonTapped(_ sender: UIButton) {
        let time = "\(minitues) : \(seconds) , \(milliSeconds)"
        lapTimes.insert(time, at: 0)
        tableView.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapTimes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "lapTimeCell", for: indexPath)
        cell.textLabel?.text = lapTimes[indexPath.row]
        return cell
    }
    
    
}

