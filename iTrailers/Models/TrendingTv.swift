//
//  TrendingTv.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-21.
//


//https://api.themoviedb.org/3/tv/airing_today?api_key=53bb76834e431dda9c6ac64c32ec35a5&language=en-US&page=1
//https://api.themoviedb.org/3/tv/top_rated?api_key=53bb76834e431dda9c6ac64c32ec35a5&language=en-US&page=1
//https://api.themoviedb.org/3/tv/popular?api_key=53bb76834e431dda9c6ac64c32ec35a5&language=en-US&page=1

import Foundation

struct TrendingTvResponse: Codable {
    let results: [TrendingTv]
}

struct TrendingTv: Codable {
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let name: String?
    let originalLanguage: String?
    let originalName: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let firstAirDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    let mediaType: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case name
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
