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
}

extension ContentViewModel {
   
    func postCGM() {
                
        guard let cgmURL = URL(string: "http://localhost:3001/cgmdata") else {
            return
        }
        let parameterDictionary = ["value" : "100", "trend" : "Single Arrow Down", "timestamp" : "2020-01-06 10:30:00"]
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
            
            self.glucoseArray.insert(cgm, at: 0)

        }
        
    }
}

