//
//  MovieListRequestDTO.swift
//  Laboratory
//
//  Created by SeoJunYoung on 5/25/24.
//

import Foundation

struct MovieListRequestDTO: Encodable {
    var query: String
    var language: String
    var year: String
    var api_key: String
}
