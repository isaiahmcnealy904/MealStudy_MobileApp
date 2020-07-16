//
//  CGMDateFormatter.swift
//  MDIT_MEALSTUDY_APP
//
//  Created by Pradeep Mysore on 6/1/20.
//  Copyright © 2020 Pradeep Mysore. All rights reserved.
//

import Foundation

class CGMDateFormatter{
    
    // formats the date and time for use in cgm table
    static func getFormatter() -> DateFormatter{
        
        let formatter = DateFormatter()
        let formatterAlt = DateFormatter()
        
        formatterAlt.dateFormat = "dd-MM-YYYY HH:mm:ss"
        formatter.dateFormat = "HH:mm a"
        
        return formatter
    }
}
