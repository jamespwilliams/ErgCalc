//
//  SecondViewController.swift
//  ErgCalc
//
//  Created by James Williams on 29/01/2017.
//  Copyright © 2017 James Williams. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FirstViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.knownDist.delegate = self
        self.knownTime.delegate = self
        self.predictDist.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var knownDist: YokoTextField!
    @IBOutlet weak var knownTime: YokoTextField!
    @IBOutlet weak var predictDist: YokoTextField!
    @IBOutlet weak var splitField: YokoTextField!
    @IBOutlet weak var timeField: YokoTextField!
    
    @IBAction func textFieldEditingEnded(_ sender: UITextField) {
        calc()
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
    
    func calc() {
        if knownDist.text != "" && knownTime.text != "" && predictDist.text != "" {
            var dist = Int(knownDist.text!)
            var predDist = Int(predictDist.text!)
            
            if dist == nil || predDist == nil {
                return
            }
            
            dist = dist!
            predDist = predDist!
            
            let timeComponents = knownTime.text!.components(separatedBy: ":")
            var totalSeconds:Float = 0
            var i:Float = 0
            for comp in timeComponents.reversed() {
                if comp != "" {
                    let compf = Float(comp)
                    
                    if compf != nil {
                        totalSeconds += compf! * powf(60, i)
                    }
                }
                
                
                i += 1
            }
            print(totalSeconds)
            
            let splitSeconds = 500 * totalSeconds / Float(dist!)
            let delta = 5*log2(Float(predDist!)/Float(dist!))
            
            print(delta)
            print(splitSeconds)
            print(dist!)
            let newSplit = splitSeconds + delta
            print(newSplit)
            
            let splitMinutes = Int(newSplit / 60)
            let splitSecs = newSplit.truncatingRemainder(dividingBy: 60)
            
            splitField.text = "\(splitMinutes):\(String(format:"%04.1f", splitSecs))"
            
            let newTime = newSplit * Float(predDist! / 500)
            
            let totMinutes = Int(newTime / 60)
            let totSecs = newTime.truncatingRemainder(dividingBy: 60)
            
            timeField.text = "\(totMinutes):\(String(format:"%04.1f", totSecs))"
            
        }
    }

}

