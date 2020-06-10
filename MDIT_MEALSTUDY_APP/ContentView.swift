//
//  ContentView.swift
//  MDIT_MEALSTUDY_APP
//
//  Created by Pradeep Mysore on 6/1/20.
//  Copyright © 2020 Pradeep Mysore. All rights reserved.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
 
    // creates an object from the viewModel
    @ObservedObject var viewModel: ContentViewModel

    // create timer and timer objects
    @State var time = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State var SimRunning = false
    @State var count = 0

    // declare the content and behavior of some view
    var body: some View {
        
        // verticle stack for the entire home page
        VStack(spacing: 20){
            
            // create a list to contain the CGM data
            List(viewModel.glucoseArray) { cgm in
                GlucoseRow(cgm: cgm)
            }
            .navigationBarTitle("Glucose")  // set title for navigation bar
            
            // stack contains buttons for controlling simulator
            HStack(spacing: 10){
             
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
                        
                        // set the stop and play text
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
            .padding(.top, 50) // add padding above stack
        }
        // when the timer goes off do something
        .onReceive(self.time) { (_) in
            
            // if the simulator is runnign
            if self.SimRunning {
                
                self.viewModel.postCGM()
                
                //TODO: Remove hard count in final build. Simulator should run until stopped (see lines #20 and #81 - #90)
                // log to console the record number record
                if self.count != 5 {   //if count hasn't reached its limit add new record
                    
                    self.count += 1
                    print("Posted CGM item: \(self.count)")
                    
            
                } else {    // if count has reach its limit stop the simulator
                    
                    print("Simulator has disconnected. Count limit reached")
                    self.SimRunning.toggle()
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(viewModel: ContentViewModel())
        }
    }
}
