//
//  CommonUtils.swift
//  ErgCalc
//
//  Created by James Williams on 21/03/2018.
//  Copyright © 2018 James Williams. All rights reserved.
//

import Foundation

struct Constants {
    // How many meters are in one "split"
    static let SplitLength:Float = 500.0
    // Conversion rate from KG to LB
    static let KGtoLB:Float = 2.20462
    // Weight factor used in weight adjustment
    static let WeightFactor:Float = 270
    // Exponent used in weight adjustment formula
    static let WeightFactorExponent:Float = 0.222
    // Multiplicand used in watts formula
    static let WattsFactor:Float = 2.8
}

// Convert time string in HH:MM:SS.MS format to seconds
func timeStringToSeconds( timeString:String ) -> Float {
    let timeComponents = timeString.components(separatedBy: ":")
    var totalSeconds:Float = 0
    var power:Float = 0
    
    // Convert time in ["HH", "MM", "SS"] format to seconds
    for component in timeComponents.reversed() {
        if component != "" {
            let componentFloat = Float(component)
            
            if componentFloat != nil {
                totalSeconds += componentFloat! * powf(60, power)
            }
        }
        power += 1
    }
    
    return totalSeconds;
}
