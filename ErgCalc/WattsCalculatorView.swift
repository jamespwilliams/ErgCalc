//
//  WattsCalculatorView.swift
//  ErgCalc
//
//  Created by James Williams on 31/01/2017.
//  Copyright © 2017 James Williams. All rights reserved.
//

import UIKit

class WattsCalculatorView: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PaceCalculatorView.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @IBOutlet weak var splitField: YokoTextField!
    @IBOutlet weak var wattsField: YokoTextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        
        view.endEditing(true)
    }
    
    
    @IBAction func textFieldEditingEnd(_ sender: UITextField) {
        if (splitField.text! == "" && wattsField.text == "") {
            return
        }
        
        if sender == splitField && splitField.text != "" {
            let splitSeconds = timeStringToSeconds(timeString: splitField.text!)
            
            let pace = splitSeconds / Constants.SplitLength
            let watts = Constants.WattsFactor / pow(pace, 3)
            
            wattsField.text = "\(String(format:"%.1f", watts))"
            
        } else {
            let watts = Float(wattsField.text!)
            
            if watts != nil {
                
                let w = Float(wattsField.text!)!
                let pace = pow(Constants.WattsFactor/w, 1/3)
                
                let splitSeconds = pace * Constants.SplitLength
                let splitMinutes = Int(splitSeconds / 60)
                let splitSecs = splitSeconds.truncatingRemainder(dividingBy: 60)

                splitField.text = "\(splitMinutes):\(String(format:"%04.1f", splitSecs))"
                
            } else {
                return
            }
        }
    }
}
