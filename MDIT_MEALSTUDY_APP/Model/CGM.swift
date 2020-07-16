//
//  CGM.swift
//  MDIT_MEALSTUDY_APP
//
//  Created by Pradeep Mysore on 6/1/20.
//  Copyright © 2020 Pradeep Mysore. All rights reserved.
//

import SwiftUI


import Foundation

// identifiable is needed to display things in a list
// hashable is needed to efficiant categorization
// codable is needed to map json data into model

struct CGM: Codable, Identifiable, Hashable {

    var id: String
    var value: String?
    var trend: String?
    var timestamp: String?
    
}

extension CGM {

    static func generateRandomCGM() -> CGM {
        return CGM(id: "50", value: "10", trend: "upArrow")
    }

    static func generateCurrentTime() -> String {
        // create function to generate current date and time -> timestamp: Time
        let date = Date()
        let format = CGMDateFormatter.getFormatter()
        let currentDate = format.string(from: date)

        return currentDate
    }
    
    static func generateRandomValue() -> String {
        // generate a random value between 2 and 10
        let randomNum = Float.random(in: 2...10)
        let value = String(randomNum)
        
        return value
    }

}
