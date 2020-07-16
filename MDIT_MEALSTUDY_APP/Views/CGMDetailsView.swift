//
//  CGMDetailsView.swift
//  MDIT_MEALSTUDY_APP
//
//  Created by Isaiah McNealy on 7/9/20.
//  Copyright © 2020 Pradeep Mysore. All rights reserved.
//

import SwiftUI

struct CGMDetailsView: View {
    
    let TAG = "CGMDetailsView"
    
    @Binding var test_details: Bool
    
    var body: some View {
        Details(viewModel: ContentViewModel())
    }
}

struct CGMDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CGMDetailsView(test_details: .constant(true))
    }
}

struct Details: View {

    // creates an object from the viewModel
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        
        ZStack{
            
            Rectangle()
                .fill(Color.gray)
                .opacity(0.15)
                .frame(width: 200, height: 250)
            
            VStack{
                
                Text("Last Updated")
                    .font(.caption)
                    .fixedSize()
                    .foregroundColor(.gray)
                
                Text(viewModel.currentTime)
                    .font(.headline)
                
            }
            
        }
    }
}
