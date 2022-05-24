//
//  TimerViewController.swift
//  Clock
//
//  Created by Tomonao Hashiguchi on 2022-05-23.
//

import UIKit

class TimerViewController: UIViewController, AddTimerViewControllerDelegate {
    
    
    
    
//
//    
//    var seconds: Int = 0{
//        didSet{
//            var secondsText: String
//            if seconds == -1{
//                minutes -= 1
//                seconds = 59
//                return
//            }else if seconds < 10{
//                secondsText = "0\(seconds)"
//            }else{
//                secondsText = "\(seconds)"
//            }
//        }
//    }
//    var minutes: Int = 0{
//        didSet{
//            var minutesText: String
//            if minutes == -1{
//                hour -= 1
//                minutes = 59
//                return
//            }else if minutes < 10{
//                minutesText = "0\(minutes)"
//            }else{
//                minutesText = "\(minutes)"
//            }
//        }
//    }
//    var hour: Int = 0{
//        didSet{
//            var hourText: String
//            if hour < 10 {
//                hourText = "0\(hour)"
//            }else{
//                hourText = "\(hour)"
//            }
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTimerVC"{
            let addTimerVC = segue.destination as! AddTimerViewController
            addTimerVC.delegate = self
        }
    }

    func add(hours: Int, minutes: Int, seconds: Int) {
        print("\(hours)h \(minutes)m \(seconds)s")
    }

}
