//
//  IndicatorView.swift
//  MDIT_MEALSTUDY_APP
//
//  Created by Isaiah McNealy on 7/9/20.
//  Copyright © 2020 Pradeep Mysore. All rights reserved.
//

import SwiftUI

struct IndicatorView: View {
    var body: some View {
        Indicator()
    }
}

struct IndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorView()
    }
}

struct Indicator: View {
    var body: some View {
        
        ZStack {
            
            Rectangle()
            .fill(Color.blue)
            .frame(width: 200, height: 250)
            
            Image("High - Dropping")    // retrieve image from cgm object
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            
            VStack {
                Text("200")     // retrieve this from CGM Object
                    .font(.headline)
                Text("mg/dL")
            }
            
            
        }

    }
}
