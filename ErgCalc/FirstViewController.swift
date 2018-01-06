//
//  FirstViewController.swift
//  ErgCalc
//
//  Created by James Williams on 29/01/2017.
//  Copyright © 2017 James Williams. All rights reserved.
//

import UIKit
import GoogleMobileAds

class FirstViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FirstViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.distanceTextField.delegate = self
        self.timeTextField.delegate = self
        self.splitTextField.delegate = self
        
        bannerView.adUnitID = "ca-app-pub-2004135778380140/4101948112"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
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
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
    
    @IBAction func textFieldEditingDidEnd(_ sender: UITextField) {
        
        recalculate(sender:sender)
    }
    
    func recalculate(sender:UITextField) {
        print("recalculating")
        
        let distanceEmpty = distanceTextField.text == ""
        let timeEmpty = timeTextField.text == ""
        let splitEmpty = splitTextField.text == ""
        
        let numEmpty = Int(NSNumber(value:distanceEmpty)) + Int(NSNumber(value:timeEmpty)) + Int(NSNumber(value:splitEmpty))
        
        
        
        /**if sender.text == "" {
         if numEmpty >= 2 {
         distanceTextField.text = ""
         splitTextField.text = ""
         timeTextField.text = ""
         }
         }**/
        
        if numEmpty == 1 {
            
            if distanceTextField.text != "" && timeTextField.text != "" && sender != splitTextField {
                let timeComponents = timeTextField.text!.components(separatedBy: ":")
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
                
                let distance = Float(distanceTextField.text!)
                if distance != nil && totalSeconds > 0 {
                    let splitSeconds = 500 * totalSeconds / (distance!)
                    
                    
                    let splitMinutes = Int(splitSeconds / 60)
                    let splitSecs = splitSeconds.truncatingRemainder(dividingBy: 60)
                    
                    
                    
                    splitTextField.text = "\(splitMinutes):\(String(format:"%04.1f", splitSecs))"
                    
                    return
                }
                
            }
            
            
            if distanceTextField.text != "" && splitTextField.text != "" && sender != timeTextField {
                
                let splitComponents = splitTextField.text!.components(separatedBy: ":")
                var splitSeconds:Float = 0
                var i:Float = 0
                for comp in splitComponents.reversed() {
                    if comp != "" {
                        let compf = Float(comp)
                        
                        if compf != nil {
                            splitSeconds += compf! * powf(60, i)
                        }
                    }
                    
                    
                    i += 1
                }
                
                
                let distance = Float(distanceTextField.text!)
                
                if distance != nil && splitSeconds > 0 {
                    let totalSeconds =  splitSeconds * (distance! / 500)
                    
                    
                    let totalMinutes = Int(totalSeconds / 60)
                    let totalSecs = totalSeconds.truncatingRemainder(dividingBy: 60)
                    
                    timeTextField.text = "\(totalMinutes):\(String(format:"%04.1f", totalSecs))"
                
                    return
                }
                
            }
            
            if timeTextField.text != "" && splitTextField.text != "" && sender != distanceTextField {
                
                let splitComponents = splitTextField.text!.components(separatedBy: ":")
                var splitSeconds:Float = 0
                var i:Float = 0
                for comp in splitComponents.reversed() {
                    if comp != "" {
                        let compf = Float(comp)
                        
                        if compf != nil {
                            splitSeconds += compf! * powf(60, i)
                        }
                    }
                    
                    
                    i += 1
                }
                
                let timeComponents = timeTextField.text!.components(separatedBy: ":")
                var totalSeconds:Float = 0
                var j:Float = 0
                for comp in timeComponents.reversed() {
                    if comp != "" {
                        let compf = Float(comp)
                        
                        if compf != nil {
                            totalSeconds += compf! * powf(60, j)
                        }
                    }
                    
                    
                    j += 1
                }
                
                if splitSeconds > 0 && totalSeconds > 0 {
                    let dist = (totalSeconds / splitSeconds) * 500
                    distanceTextField.text = "\(Int(dist))"
                    
                    return
                }
                
                
            }
            
        }

    }
}
