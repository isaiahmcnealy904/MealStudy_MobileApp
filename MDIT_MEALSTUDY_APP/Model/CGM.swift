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
        
        // generate a random value to pass to returned CGM
//        let cgmValue = String(format: "%.2f", Float.random(in: 1..<10))

        return CGM(id: "50", value: "10", trend: "Single Arrow Up", timestamp: "2020-06-01 10:20:30")

    }
    
}
