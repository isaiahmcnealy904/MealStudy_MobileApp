//
//  HomeView.swift
//  MDIT_MEALSTUDY_APP
//
//  Created by Isaiah McNealy on 7/9/20.
//  Copyright © 2020 Pradeep Mysore. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State var test: Bool = true
    
    var body: some View {
        
        VStack {
            
            HStack {
                IndicatorView()     // display indicator
                CGMDetailsView()    // display details
            }
            
            // display chart
            ChartView(test: $test)
                .frame(height: 300)
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
