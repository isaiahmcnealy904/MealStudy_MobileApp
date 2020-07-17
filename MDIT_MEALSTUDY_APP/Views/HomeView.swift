//
//  HomeView.swift
//  MDIT_MEALSTUDY_APP
//
//  Created by Isaiah McNealy on 7/9/20.
//  Copyright © 2020 Pradeep Mysore. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    let TAG = "HomeView.swift"
    
    // creates an object from the viewModel
    @State var viewModel: ContentViewModel
    
    // tracks the simulator state and starts auto charting on graph
//    @State var test_indicator: Bool = true
    @State var test_details: Bool = true
    @State var test: Bool = true
    
    // create timer and timer objects
    @State var time = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State var SimRunning = false
    @State var count = 0 // stores a runnning count of items entered
    
    var body: some View {
        
        VStack {
            
            HStack {
                IndicatorView(viewModel: $viewModel)     // display indicator
                CGMDetailsView(viewModel: $viewModel)    // display details
            }
            
            // display chart
            ChartView(test: $test)
                .frame(height: 300)
            
            
            // start / stop button for simulator
            Button(action: {
        
                print("Simulator Running: \(!self.SimRunning)")     // log that the button was pressed

                if self.count == 5 {           // when counter gets to 15 restart

                    self.count = 0              // reset counter to zero
                }

                self.SimRunning.toggle()        // toggle the simultor
                
            }) {
                // stack controls the layout within the button and the button style
                HStack(spacing: 15) {
                    
                    // set stop/play system icons
                    Image(systemName: self.SimRunning ? "stop.fill" : "play.fill")
                        .foregroundColor(.white)
                    
                    // set the stop and play t
                    Text(self.SimRunning ? "Stop" : "Start")
                        .foregroundColor(.white)
                    
                }
                .padding(.vertical)
                .frame(width: (UIScreen.main.bounds.width) - 90 )
                .background(Color.red)
                .clipShape(Capsule())
                .shadow(radius: 6)
                
            }
        }
        // when the timer goes off do something
        .onReceive(self.time) { (_) in
            
            // if the simulator is runnign
            if self.SimRunning {
                
                //TODO: Remove hard count in final build. Simulator should run until stopped (see lines #20 and #81 - #90)
                // log to console the record number record
                if self.count != 50 {   //if count hasn't reached its limit add new record
                    
                    // print current value, trend, and timestamp from contentViewModel
//                    print("Context: \(self.TAG) | current value: \(self.viewModel.currentValue) | current trend: \(self.viewModel.currentTrend) | current Time: \(self.viewModel.currentTime)")
                    
                    // post cgm to list
                    self.viewModel.postCGM()
                    
                    // add new point on graph
                     self.test.toggle()
                    
                    // update indicator
//                    self.test_indicator.toggle()
//                    self.test_details.toggle()
                    
                    self.count += 1
                    print("Posted CGM item: \(self.count) \n\n")
                    
            
                } else {    // if count has reach its limit stop the simulator
                    
                    print("Simulator has disconnected. Count limit reached")
                    self.SimRunning.toggle()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: ContentViewModel())
    }
}
