//
//  MovieParser.swift
//  BlueprintDemoApp
//
//  Created by Mindy Long on 2/20/21.
//

import Foundation
import SwiftyJSON

// What if we have thousands of movies? We can help define them and pass their data using basic structs.
struct Movie {
    let title, image, overview, releaseDate, rating: String
    let categories: [Int]
}

class Movies {
    
    private var movieData: [Movie] = []
    private let imageBaseURL = "https://image.tmdb.org/t/p/w500/"
    
    func getData() {
        guard let path = Bundle.main.path(forResource: "Movies", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)

        do {
            let data = try Data(contentsOf: url)
            parseData(data: data)

        }  catch {
            print(error)
        }
    }
    
    func parseData(data: Data) {
        
        do {
            
            let json = try JSON(data: data)
            let data = json["results"]
                        
            // Check SwifyJSON docs for more documentation
            // Moral of the story: READ DOCUMENTATION
            for (_, movie):(String, JSON) in data {
                
                // Get the data we need
                let title = movie["original_title"].stringValue
                let image = imageBaseURL + movie["poster_path"].stringValue
                let overview = movie["overview"].stringValue
                let releaseDate = movie["release_date"].stringValue
                let rating = movie["vote_average"].stringValue
                let genres = movie["genre_ids"].arrayValue.map { $0.intValue}
                                
                // Make a new Movie struct object
                let m = Movie(title: title, image: image, overview: overview, releaseDate: releaseDate, rating: rating, categories: genres)
                movieData.append(m)
            }
            
        } catch let jsonErr {
            print("decoding error")
            print(jsonErr)
            // do something else with data
        }
        
    }
    
    func getMovies() -> [Movie] {
        return self.movieData
    }
    
}
