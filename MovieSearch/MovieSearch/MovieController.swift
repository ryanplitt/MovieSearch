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
    
    static let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")!
    
    static func searchFor(searchTerm: String, completion: @escaping ([Movie]) -> Void) {
        
        let params = ["api_key": apiKey, "query" : searchTerm]
        
        NetworkController.performRequest(for: baseURL, httpMethod: .Get, urlParameters: params, body: nil) { (data, error) in
            
            guard let data = data else { completion([]) ; return }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .formatted(formater)
            
            let result = try! jsonDecoder.decode(Result.self, from: data)
            completion(result.movies)
        }
        
    }
    
    static let formater: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static func fetchImageData(for movie: Movie, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500"), let imagePath = movie.imagePath else { completion(nil) ; return }
        let searchURL = url.appendingPathComponent(imagePath)
        NetworkController.performRequest(for: searchURL, httpMethod: .Get, urlParameters: nil, body: nil) { (data, error) in
            completion(data)
            return
        }
    }
}

