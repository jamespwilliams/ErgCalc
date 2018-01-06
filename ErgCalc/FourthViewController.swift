//
//  FourthViewController.swift
//  ErgCalc
//
//  Created by James Williams on 31/01/2017.
//  Copyright © 2017 James Williams. All rights reserved.
//

import UIKit
import GoogleMobileAds

class FourthViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var bannerView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FirstViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        bannerView.adUnitID = "ca-app-pub-2004135778380140/4101948112"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
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
        
        if (splitField.text! != "" || wattsField.text! != "") {
            
            if sender == splitField && splitField.text != "" {
                
                let splitComponents = splitField.text!.components(separatedBy: ":")
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
                
                let pace = splitSeconds / 500
                let watts = 2.8 / pow(pace, 3)
                
                wattsField.text = "\(String(format:"%.1f", watts))"
                
            } else {
                
                
                let watts = Float(wattsField.text!)
                
                if watts != nil {
                    
                    let w = Float(wattsField.text!)!
                    let pace = pow(2.8/Double(w), 1/3)
                    
                    let splitSeconds = pace * 500
                    let splitMinutes = Int(splitSeconds / 60)
                    let splitSecs = splitSeconds.truncatingRemainder(dividingBy: 60)
                    
                    
                    
                    splitField.text = "\(splitMinutes):\(String(format:"%04.1f", splitSecs))"
                    

                    
                } else {
                    return
                }
                
                
            }
            
            
        }
        
    }
}
