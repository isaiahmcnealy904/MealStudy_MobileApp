//
//  GlucoseRow.swift
//  MDIT_MEALSTUDY_APP
//
//  Created by Pradeep Mysore on 6/1/20.
//  Copyright © 2020 Pradeep Mysore. All rights reserved.
//

import SwiftUI

struct GlucoseRow: View {
    
    var cgm: CGM
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            
            Text(cgm.id).fixedSize(horizontal: false, vertical: true)
            
            HStack {
                Text(CGMDateFormatter.getFormatter().string(from: Date())).font(.caption)
                
                // Add value text of the cgm
            }
        }
    }
}

struct GlucoseRow_Previews: PreviewProvider {
    static var previews: some View {
        GlucoseRow(cgm: .generateRandomCGM())
    }
}
