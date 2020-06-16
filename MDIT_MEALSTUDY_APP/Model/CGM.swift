//
//  CGM.swift
//  MDIT_MEALSTUDY_APP
//
//  Created by Pradeep Mysore on 6/1/20.
//  Copyright © 2020 Pradeep Mysore. All rights reserved.
//

import Foundation

struct CGM: Codable, Identifiable {

    var id: String
    var value: String?
    var trend: String?
    var timestamp: String?
}

extension CGM {

    static func generateRandomCGM() -> CGM {
        
        return CGM(id: "50", value: "10", trend: "Single Arrow Up", timestamp: "2020-06-01 10:20:30")

    }
    
    // create function to generate current date and time -> timestamp: Time
    
    // create function to generate random value -> value: Int
    
    // create function to calculate if value is trending up or down -> trend: String
    
    
    
}
