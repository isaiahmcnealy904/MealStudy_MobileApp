//
//  ContentViewModel.swift
//  MDIT_MEALSTUDY_APP
//
//  Created by Pradeep Mysore on 6/1/20.
//  Copyright © 2020 Pradeep Mysore. All rights reserved.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    
    let TAG = "ContentViewModel"
    
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    var cancellable: AnyCancellable?
    
    @Published var arrayData:[CGM] = cgmData    // this contains an array of premade cgm values read in from cgms.json
    @Published var glucoseArray: [CGM] = []     // empty array used to store cgms as they are published
    @Published var index: Int = 0               // contains the current index for reading from arrayData
    
    
    @Published var currentValue: String = "40"
    @Published var currentTime: String = "4:30pm"
    @Published var currentTrend: String = "High - Dropping"
    
    @Published var value = 0
    init() {
        for i in 1...100 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

extension ContentViewModel {
   
    func postCGM() {
                
        // get url to send the cgm data
        guard let cgmURL = URL(string: "http://localhost:3001/cgmdata") else {
            return
        }
        
        // create a dictionary of values to transmit
        let parameterDictionary = ["value" : arrayData[index].value, "trend" : arrayData[index].trend, "timestamp" : CGM.generateCurrentTime()]
        
        // capture the values and timestamp from the dictionary to pass to graph
        currentValue = parameterDictionary["value"]!!
        currentTime = parameterDictionary["timestamp"]!!
        currentTrend = parameterDictionary["trend"]!!
        
        // create a request to the server
        var request = URLRequest(url: cgmURL)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody

        cancellable = urlSession.dataTaskPublisher(for: request).map { (data, response) -> Data in
            
            return data

        }.tryMap { (data) -> CGM in
            
            let jsonDecoder = JSONDecoder()
        
            return try jsonDecoder.decode(CGM.self, from: data)

        }.receive(on: DispatchQueue.main).sink(receiveCompletion: { (subscriber) in

            switch subscriber {
            case .failure(let error):
                print("Error General: \(error)\n")
                print("Error Detailed: \(error.localizedDescription)\n\n")
            case .finished:
                break
            }

        }) {[unowned self] (cgm) in
            
            // insert value into glucose array at position 0
            self.glucoseArray.insert(cgm, at: 0)
        }
        
        testPrint()
        
        // increment current index
        self.index += 1
        
        // check that index doesnt exceed size of array
        if (self.index > 9) {   // TODO: replace hardcoded size with size of cgmData
            self.index %= 9     // TODO: replace hardcoded size with size of cgmData
//            self.index = 0
        }
        
    }
    
    func testPrint() {
        // print current time, trend, and values to the console
        print("Context: \(self.TAG) | current value: \(self.currentValue) | current trend: \(self.currentTrend) | current Time: \(self.currentTime)")
        
    }
}

