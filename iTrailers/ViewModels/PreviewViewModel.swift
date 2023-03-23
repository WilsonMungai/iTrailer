//
//  PreviewViewModel.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-22.
//

import Foundation
// responsible for holding the date to be shown in the detail view
struct PreviewViewModel {
    // trailer view
    let youtubeView: VideoElement
    // movie rating
    let movieRating: Double
    // movie name
    let movieName: String
    // movie released date
    let movieReleaseDate: String
    // movie poster image
    let moviePoster: String
    // movie overview
    let movieOverView: String
}
