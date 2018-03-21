//
//  WeightAdjustmentView.swift
//  ErgCalc
//
//  Created by James Williams on 30/01/2017.
//  Copyright © 2017 James Williams. All rights reserved.
//

import UIKit

class WeightAdjustmentView: UIViewController, UITextFieldDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PaceCalculatorView.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.weightKgField.delegate = self
        self.weightLbField.delegate = self
        self.distField.delegate = self
        self.timeField.delegate = self

    }
    
    @IBOutlet weak var weightLbField: YokoTextField!
    @IBOutlet weak var weightKgField: YokoTextField!
    @IBOutlet weak var timeField: YokoTextField!
    @IBOutlet weak var distField: YokoTextField!
    @IBOutlet weak var resultField: YokoTextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        
        return false
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.

        view.endEditing(true)
    }
    
    @IBAction func textEditingEnded(_ sender: UITextField) {
        calc()
    }
    
    func calc() {
        var weight:Float = 0

        if weightKgField.text! != "" {
            let weightKg = Float(weightKgField.text!)
            
            if (weightKg != nil) {
                weight = weightKg! * Constants.KGtoLB
            } else {
                return
            }
        } else if weightLbField.text != "" {
            let weightLb = Float(weightLbField.text!)
            
            if (weightLb != nil) {
                weight = weightLb!
            } else {
                return
            }
        } else {
            return
        }
        
        if distField.text != "" {
            var distance = Float(distField.text!)
            
            if (distance != nil) {
                distance = distance!
            } else {
                return
            }
            
            let weightedDistance = distance! / getWeightFactor(weight: weight)
            
            resultField.text = "\(String(format:"%.0f", weightedDistance))"
            
        } else if timeField.text != "" {
            var totalSeconds = timeStringToSeconds(timeString: timeField.text!)
            
            totalSeconds *= getWeightFactor(weight: weight)
            
            let totalMinutes = Int(totalSeconds / 60)
            let totalSecs = totalSeconds.truncatingRemainder(dividingBy: 60)
            
            resultField.text = "\(totalMinutes):\(String(format:"%04.1f", totalSecs))"
        }
    }
    
    func getWeightFactor(weight:Float) -> Float {
        return powf(weight/Constants.WeightFactor, Constants.WeightFactorExponent)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
