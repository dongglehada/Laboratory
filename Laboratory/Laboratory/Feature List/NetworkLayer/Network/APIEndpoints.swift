//
//  APIEndpoints.swift
//  Laboratory
//
//  Created by SeoJunYoung on 5/25/24.
//

import Foundation

struct APIEndpoints {
    static func fetchSearchMovieList(with movieListRequestDTO: MovieListRequestDTO) -> Endpoint<MovieListResponseDTO> {
        return Endpoint(
            baseURL: "https://api.themoviedb.org/3/search/movie",
            method: .get,
            queryParameters: movieListRequestDTO
        )
    }
}
