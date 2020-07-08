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
    
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    @Published var glucoseArray: [CGM] = []
    
    var cancellable: AnyCancellable?
    
    var currentValue: String = ""
    var currentTime: String = ""
    
}

extension ContentViewModel {
   
    func postCGM() {
                
        // get url to send the cgm data
        guard let cgmURL = URL(string: "http://localhost:3001/cgmdata") else {
            return
        }
        
        // create a dictionary of values to transmit
        let parameterDictionary = ["value" : CGM.generateRandomValue(), "trend" : "upArrow", "timestamp" : CGM.generateCurrentTime()]
        
        // capture the values and timestamp from the dictionary to pass to graph
        currentValue = parameterDictionary["value"]!
        currentTime = parameterDictionary["timestamp"]!
        
        // print current time and values to the console
        print("current value: \(currentValue), current time: \(currentTime)")
  
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
                print("Error: \(error.localizedDescription)")
            case .finished:
                break
            }

        }) {[unowned self] (cgm) in
            
            // insert value into glucose array
            self.glucoseArray.insert(cgm, at: 0)

        }
        
    }
}

