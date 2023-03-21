//
//  Trending.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-21.
//

import Foundation

// MARK: - Welcome
struct TrendingResult: Codable {
    let results: [Trending]
}

// MARK: - Result
struct Trending: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let title: String
    let originalLanguage: OriginalLanguage
    let originalTitle, overview, posterPath: String
    let mediaType: String
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

//enum MediaType: String, Codable {
//    case movie = "movie"
//}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case fr = "fr"
    case nl = "nl"
}
