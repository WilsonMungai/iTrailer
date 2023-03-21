//
//  NetworkService.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-21.
//

import Foundation

//https://api.themoviedb.org/3/trending/movie/day?api_key=53bb76834e431dda9c6ac64c32ec35a5

class NetworkService {
    static let shared = NetworkService()
    
    func getTrending(completion: @escaping (Result<[Trending], Error>)-> Void) {
        // construct url
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.apiKey)") else {return }
        // url session
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
             guard let data = data, error == nil else {
                 completion(.failure( error ?? ApiError.failedToGetData ))
                 return
             }
            // decode response
            do {
//                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let result = try JSONDecoder().decode(TrendingResult.self, from: data)
                completion(.success(result.results))
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
