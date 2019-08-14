// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieNowPlaying = try? newJSONDecoder().decode(MovieNowPlaying.self, from: jsonData)

import Foundation

// MARK: - MovieNowPlaying
struct ListMovie: Codable {
    let results: [Movie]?
    let page, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults
    }
}

// MARK: - Dates


// MARK: - Result
struct Movie: Codable {
    let voteCount, id: Int?
    let video: Bool?
    let voteAverage: Double?
    let title: String?
    let popularity: Double?
    let posterPath: String?
    let genreIDS: [Int]?
    let backdropPath: String?
    let overview, releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case voteCount
        case id, video
        case voteAverage
        case title, popularity
        case posterPath
        case genreIDS
        case backdropPath
        case overview
        case releaseDate
    }
}

