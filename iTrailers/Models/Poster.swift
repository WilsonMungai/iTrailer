//
//  Trending.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-21.
//

//https://api.themoviedb.org/3/trending/movie/day?api_key=53bb76834e431dda9c6ac64c32ec35a5
//https://api.themoviedb.org/3/movie/popular?api_key=53bb76834e431dda9c6ac64c32ec35a5&language=en-US&page=1
//https://api.themoviedb.org/3/movie/top_rated?api_key=53bb76834e431dda9c6ac64c32ec35a5&language=en-US&page=1
//https://api.themoviedb.org/3/movie/now_playing?api_key=53bb76834e431dda9c6ac64c32ec35a5&language=en-US&page=1
//https://api.themoviedb.org/3/movie/upcoming?api_key=53bb76834e431dda9c6ac64c32ec35a5&language=en-US&page=1
import Foundation

// MARK: - Welcome
struct PosterResult: Codable {
    let results: [Poster]
}

// MARK: - Result
struct Poster: Codable {
    let backdropPath: String?
    let id: Int
    let title: String?
    let originalTitle, overview, posterPath: String?
    let mediaType: String?
    let popularity: Double
    let releaseDate: String?
    let voteAverage: Double
    let voteCount: Int
    let name: String?
    let originalName: String?
    let firstAirDate: String?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, title
//        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case popularity
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originalName = "original_name"
        case name
        case firstAirDate = "first_air_date"
    }
}

