//
//  AddTimerViewController.swift
//  Clock
//
//  Created by Tomonao Hashiguchi on 2022-05-23.
//

import UIKit

protocol AddTimerViewControllerDelegate{
    func add(hours: Int, minutes: Int, seconds: Int)
}

class AddTimerViewController: UIViewController {
    
    @IBOutlet var hoursLabel: UILabel!
    @IBOutlet var minutuesLabel: UILabel!
    @IBOutlet var secondsLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    
    var delegate: AddTimerViewControllerDelegate?
    
    var indexOfNumberStart = -1 {
        didSet{
            startButton.isEnabled = indexOfNumberStart == -1 ? false : true
        }
    }
    
    var isFirstNumber = true{
        didSet{
            startButton.isEnabled = !isFirstNumber
        }
    }
    var time: [String] = ["0", "0", "0", "0", "0", "0",]{
        didSet{
            hoursLabel.text = time[5] + time[4]
            minutuesLabel.text = time[3] + time[2]
            secondsLabel.text = time[1] + time[0]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.isEnabled = false
    }
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        if let number = sender.restorationIdentifier {
            if indexOfNumberStart == -1 && ( number == "0" || number.count == 2 ){
                return
            }
            if number.count == 2 {
                time.insert("0", at: 0)
                time.insert("0", at: 0)
                indexOfNumberStart += 2
            }else{
                time.insert(number, at: 0)
                indexOfNumberStart += 1
            }
        }
    }
    
    @IBAction func backDeleteButtonTapped() {
        guard time.count > 6 else { return }
        indexOfNumberStart -= 1
        time.remove(at: 0)
    }
    @IBAction func startButtonTapped() {
        var seconds = 0
        var minutes = 0
        var hours = 0
        
        let effectiveDigit = time[0...5].map { Int($0)! }
        let reversed: [Int] = effectiveDigit.reversed()
        
        seconds = {
            var sec = reversed[4] * 10 + reversed[5]
            if sec > 59 {
                let overValue = sec / 60
                sec = sec % 60
                minutes += overValue
            }
            return sec
        }()
        minutes = {
            var min = reversed[2] * 10 + reversed[3] + minutes
            if min > 59 {
                let overValue = min / 60
                min = min % 60
                hours += overValue
            }
            return min
        }()
        hours = reversed[0] * 10 + reversed[1] + hours

        delegate?.add(hours: hours, minutes: minutes, seconds: seconds)
        dismiss(animated: true)
    }
    @IBAction func cancellButtonTapped() {
        dismiss(animated: true)
    }
}
