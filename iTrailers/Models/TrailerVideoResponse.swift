//
//  TrailerVideoResponse.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-22.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
