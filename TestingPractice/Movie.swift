//
//  Movie.swift
//  TestingPractice
//
//  Created by C4Q on 4/24/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation

struct ResultsWrapper: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let trackName: String
    let artistName: String
    let kind: String
    let artworkUrl60:String
    let contentAdvisoryRating: String
}

