//
//  MovieController.swift
//  MovieSearch
//
//  Created by Ryan Plitt on 6/19/17.
//  Copyright © 2017 Ryan Plitt. All rights reserved.
//

import Foundation

class MovieController {
    
    static let apiKey: String = {
        let filepath = Bundle.main.url(forResource: "APIKey", withExtension: "plist")!
        let dic = NSDictionary(contentsOf: filepath) as! [String : String]
        return dic["APIKey"]!
    }()
    
    
    
}
