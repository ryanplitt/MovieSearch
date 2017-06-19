//
//  Movie.swift
//  MovieSearch
//
//  Created by Ryan Plitt on 6/19/17.
//  Copyright © 2017 Ryan Plitt. All rights reserved.
//

import Foundation

struct Result: Decodable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    var movies = [Movie]()
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case movieKeys = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
        
        var movies = try container.nestedUnkeyedContainer(forKey: .movieKeys)
        
        if let count = movies.count {
            self.movies.reserveCapacity(count)
        }
        
        while !movies.isAtEnd {
            let movie = try movies.decode(Movie.self)
            self.movies.append(movie)
        }
        
    }
}

struct Movie: Decodable {
    let title: String
    let popularity: Double
    let imagePath: String
    let releaseDate: Date
    let description: String
    let backdropPath: String
    
    enum MovieKeys: String, CodingKey {
        case title
        case popularity
        case imagePath = "poster_path"
        case releaseDate = "release_date"
        case description = "overview"
        case backdropPath = "backdrop_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKeys.self)
        title = try container.decode(String.self, forKey: .title)
        popularity = try container.decode(Double.self, forKey: .popularity)
        imagePath = try container.decode(String.self, forKey: .imagePath)
        releaseDate = try container.decode(Date.self, forKey: .releaseDate)
        description = try container.decode(String.self, forKey: .description)
        backdropPath = try container.decode(String.self, forKey: .backdropPath)
    }
}
