//
//  IndicatorView.swift
//  MDIT_MEALSTUDY_APP
//
//  Created by Isaiah McNealy on 7/9/20.
//  Copyright © 2020 Pradeep Mysore. All rights reserved.
//

import SwiftUI

struct IndicatorView: View {
    
    @Binding var test_indicator: Bool
    
    var body: some View {
        Indicator(viewModel: ContentViewModel(), cgm: cgmData)
    }
    
}

struct IndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorView(test_indicator: .constant(true))
    }
}

struct Indicator: View {

    
    
    @ObservedObject var viewModel : ContentViewModel
    
    var cgm:[CGM]
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
            .fill(Color.blue)
            .frame(width: 200, height: 250)
            
            Image(viewModel.currentTrend)    // retrieve image from cgm object
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            
            VStack {
                
                Text(String(viewModel.value))     // retrieve this from CGM Object
                    .font(.headline)
                
                Text("mg/dL")
            }
            
            
        }

    }
}
