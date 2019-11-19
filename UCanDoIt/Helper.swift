//
//  Helper.swift
//  UCanDoIt
//
//  Created by Pardeep on 14/11/19.
//  Copyright © 2019 Pardeep. All rights reserved.
//

import UIKit

final class Helper: NSObject {

    static let shared = Helper()
    
    private var padMusics : [String] = ["Pad1","Pad2","Pad3","Pad4","Pad5","Pad6","Pad7","Pad8","Pad9","Pad10","Pad11","Pad12","Pad12"]
    
    private override init() {
        
    }
    
    func formatSecondsToTime(_ seconds: Int) -> String{
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day ,.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter.string(from: TimeInterval(seconds)) ?? ""
    }
    
    func getRandomNumber(min: Int, max: Int) -> Int{
        return Int(arc4random_uniform(UInt32(max) - UInt32(min)) + UInt32(min))
    }
    
    func getPadMusic() -> String{
        let padIndex = self.getRandomNumber(min: 0, max: (self.padMusics.count - 1))
        return self.padMusics[padIndex]
    }
}
