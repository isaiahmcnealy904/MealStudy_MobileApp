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
        formatter.dateFormat = "dd-MM-YYYY HH:MM:SS"
        formatter.locale = Locale.autoupdatingCurrent
        
        return formatter

    }
}
