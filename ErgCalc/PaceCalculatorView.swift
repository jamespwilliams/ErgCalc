//
//  PaceCalculatorView.swift
//  ErgCalc
//
//  Created by James Williams on 29/01/2017.
//  Copyright © 2017 James Williams. All rights reserved.
//

import UIKit

class PaceCalculatorView: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PaceCalculatorView.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.distanceTextField.delegate = self
        self.timeTextField.delegate = self
        self.splitTextField.delegate = self
        
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBOutlet weak var distanceField: YokoTextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var distanceTextField: YokoTextField!
    @IBOutlet weak var timeTextField: YokoTextField!
    @IBOutlet weak var splitTextField: YokoTextField!
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func textFieldEditingDidEnd(_ sender: UITextField) {
        recalculate(sender:sender)
    }
    
    func recalculate(sender:UITextField) {
        let distanceEmpty = distanceTextField.text == ""
        let timeEmpty = timeTextField.text == ""
        let splitEmpty = splitTextField.text == ""
        
        // Count number of empty fields
        let numEmpty = Int(NSNumber(value:distanceEmpty)) + Int(NSNumber(value:timeEmpty)) + Int(NSNumber(value:splitEmpty))
        
        if (numEmpty != 1) {
            return
        }
        
        if !distanceEmpty && !timeEmpty && sender != splitTextField {

            let totalSeconds = timeStringToSeconds(timeString: timeTextField.text!)
            let distance = Float(distanceTextField.text!)
            
            if distance != nil && totalSeconds > 0 {
                let splitSeconds = Constants.SplitLength * totalSeconds / (distance!)
                
                let splitMinutes = Int(splitSeconds / 60)
                let splitSecs = splitSeconds.truncatingRemainder(dividingBy: 60)

                let splitSecsFormat = String(format:"%04.1f", splitSecs)
                
                splitTextField.text = "\(splitMinutes):\(splitSecsFormat)"
                return
            }
        }
        
        if !distanceEmpty && !splitEmpty && sender != timeTextField {
            
            let splitSeconds = timeStringToSeconds(timeString: splitTextField.text!)
            let distance = Float(distanceTextField.text!)
            
            if distance != nil && splitSeconds > 0 {
                let totalSeconds =  splitSeconds * (distance! / Constants.SplitLength)
            
                let totalMinutes = Int(totalSeconds / 60)
                let totalSecs = totalSeconds.truncatingRemainder(dividingBy: 60)
                
                timeTextField.text = "\(totalMinutes):\(String(format:"%04.1f", totalSecs))"
                
                return
            }
            
        }
        
        if !timeEmpty && !splitEmpty && sender != distanceTextField {
            
            let splitSeconds = timeStringToSeconds(timeString: splitTextField.text!)
            let totalSeconds = timeStringToSeconds(timeString: timeTextField.text!)
            
            if splitSeconds > 0 && totalSeconds > 0 {
                let dist = (totalSeconds / splitSeconds) * Constants.SplitLength
                distanceTextField.text = "\(Int(dist))"
                
                return
            }
            
            
        }
        
        

    }
    
    
}
