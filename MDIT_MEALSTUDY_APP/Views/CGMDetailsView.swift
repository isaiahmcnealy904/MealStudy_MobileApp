//
//  CGMDetailsView.swift
//  MDIT_MEALSTUDY_APP
//
//  Created by Isaiah McNealy on 7/9/20.
//  Copyright © 2020 Pradeep Mysore. All rights reserved.
//

import SwiftUI

struct CGMDetailsView: View {
    var body: some View {
        Details()
    }
}

struct CGMDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CGMDetailsView()
    }
}

struct Details: View {
    var body: some View {
        
        
            
            ZStack{
                
                Rectangle()
                    .fill(Color.gray)
                    .opacity(0.15)
                    .frame(width: 200, height: 250)
                
                VStack{
                    
                    Text("Last Updated")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text("3:34 PM")
                        .font(.largeTitle)

                }
            }
            
                        

        
    }
}
