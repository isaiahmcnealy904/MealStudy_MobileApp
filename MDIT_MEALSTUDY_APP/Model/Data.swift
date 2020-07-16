//
//  Data.swift
//  MDIT_MEALSTUDY_APP
//
//  Created by Isaiah McNealy on 7/13/20.
//  Copyright © 2020 Pradeep Mysore. All rights reserved.
//

import Foundation

// create an object 'drinkData' which is an array of Drink objects
let cgmData:[CGM] = load("cgms.json")

// function to load contents of json file
func load<T:Decodable>(_ filename:String, as type:T.Type = T.self) -> T {
    
    let data: Data
    // attempt to locate file in bundle
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldnt find \(filename) in bundle.")
    }
    // attempt to load the file
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle: \n \(error)")
    }
    // attempt to parse file's json data
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self) : \n\(error)")
    }
    
}
