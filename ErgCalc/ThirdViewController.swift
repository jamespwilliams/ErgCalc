//
//  ThirdViewController.swift
//  ErgCalc
//
//  Created by James Williams on 30/01/2017.
//  Copyright © 2017 James Williams. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ThirdViewController: UIViewController, UITextFieldDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FirstViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.weightKgField.delegate = self
        self.weightLbField.delegate = self
        self.distField.delegate = self
        self.timeField.delegate = self
        
        bannerView.adUnitID = "ca-app-pub-2004135778380140/4101948112"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    @IBOutlet weak var weightLbField: YokoTextField!
    
    @IBOutlet weak var weightKgField: YokoTextField!
    @IBOutlet weak var timeField: YokoTextField!
    @IBOutlet weak var distField: YokoTextField!
    @IBOutlet weak var resultField: YokoTextField!
    
    @IBOutlet weak var bannerView: GADBannerView!
    
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
        var weight = Float(-1)
        
        print("calculating")
        if weightKgField.text! != "" {
            let w = Float(weightKgField.text!)
            
            if (w != nil) {
                weight = w! * 2.20462
                
            } else {
                print("w is nil")
            }
        }
        
        if weight == -1 && weightLbField.text != "" {
            let w = Float(weightLbField.text!)
            if (w != nil) {
                weight = w!
            } else {
                print("w is nil")
            }
        }
        
        if weight == -1 {
            // no weight entered
            print("no weight")
            return
        }
        
        if distField.text != "" {
            let d = Float(distField.text!)
            var dist = Float(0)
            if (d != nil) {
                dist = d!
            } else {
                return
            }
            
            let wf = powf(weight/270, 0.222)
            let dc = dist / wf
            
            resultField.text = "\(String(format:"%.0f", dc))"
            
        } else if timeField.text != "" {
            
            let timeComponents = timeField.text!.components(separatedBy: ":")
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
            let wf = powf(weight/270, 0.222)
            totalSeconds *= wf
            
            let totalMinutes = Int(totalSeconds / 60)
            let totalSecs = totalSeconds.truncatingRemainder(dividingBy: 60)
            
            resultField.text = "\(totalMinutes):\(String(format:"%04.1f", totalSecs))"
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
