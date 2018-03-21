//
//  PredictionCalculatorView.swift
//  ErgCalc
//
//  Created by James Williams on 29/01/2017.
//  Copyright © 2017 James Williams. All rights reserved.
//

import UIKit

class PredictionCalculatorView: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PaceCalculatorView.dismissKeyboard))
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
        recalculate()
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
    
    func recalculate() {
        if knownDist.text != "" && knownTime.text != "" && predictDist.text != "" {
            var knownDistance = Float(knownDist.text!)
            var predictedDistance = Float(predictDist.text!)
            
            if knownDistance == nil || predictedDistance == nil {
                return
            }
            
            knownDistance = knownDistance!
            predictedDistance = predictedDistance!
            
            let totalSeconds = timeStringToSeconds(timeString: knownTime.text!)
            
            let splitSeconds = Constants.SplitLength * totalSeconds / Float(knownDistance!)
            
            // Paul's law formula: ∆ = 5*log2(predicted/known)
            let delta = 5*log2(Float(predictedDistance!)/Float(knownDistance!))

            let newSplit = splitSeconds + delta
            
            let splitMinutes = Int(newSplit / 60)
            let splitSecs = newSplit.truncatingRemainder(dividingBy: 60)
            
            splitField.text = "\(splitMinutes):\(String(format:"%04.1f", splitSecs))"
            
            let newTime = newSplit * Float(predictedDistance! / Constants.SplitLength)
            
            let resultMinutes = Int(newTime / 60)
            let resultSeconds = newTime.truncatingRemainder(dividingBy: 60)
            
            timeField.text = "\(resultMinutes):\(String(format:"%04.1f", resultSeconds))"
            
        }
    }

}

