// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieNowPlaying = try? newJSONDecoder().decode(MovieNowPlaying.self, from: jsonData)

import Foundation

// MARK: - MovieNowPlaying
struct ListMovie: Codable {
    let results: [Movie_Swift]?
    let page, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults
    }
}

// MARK: - Result
struct Movie_Swift: Codable {
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
        case voteCount = "vote_count"
        case id, video
        case voteAverage = "vote_average"
        case title, popularity
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}

