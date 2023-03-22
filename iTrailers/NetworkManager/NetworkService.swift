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
    // get trending movies
    /// function to fetch trending movies
    /// - Parameter completion: Gives data on success or an error
    /// - Result: represents either a success or a failure, including an associated value in each case.
    func getTrendingMovie(completion: @escaping (Result<[Movie], Error>)-> Void) {
        // construct ult to fetch trending movues
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.apiKey)") else {return }
        // create the url session task to fetch data from url
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            // confirm there is data and no error
             guard let data = data, error == nil else {
                 // incase there is error
                 completion(.failure( error ?? ApiError.failedToGetData ))
                 return
             }
            // decode response
            do {
//                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let result = try JSONDecoder().decode(MovieResult.self, from: data)
                completion(.success(result.results))
            } catch {
                // incase there is an error, print the error
                print(error)
            }
        }
        task.resume()
    }
    
    //https://api.themoviedb.org/3/movie/popular?api_key=53bb76834e431dda9c6ac64c32ec35a5&language=en-US&page=1
    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/popular?api_key=\(Constants.apiKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure( error ?? ApiError.failedToGetData ))
                return
            }
            do {
                let result = try JSONDecoder().decode(MovieResult.self, from: data)
                completion(.success(result.results))
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    //https://api.themoviedb.org/3/movie/top_rated?api_key=53bb76834e431dda9c6ac64c32ec35a5&language=en-US&page=1
    func getTopRatedMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/top_rated?api_key=\(Constants.apiKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ApiError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(MovieResult.self, from: data)
                completion(.success(result.results))
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    //https://api.themoviedb.org/3/movie/now_playing?api_key=53bb76834e431dda9c6ac64c32ec35a5&language=en-US&page=1
    func getNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/now_playing?api_key=\(Constants.apiKey)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ApiError.failedToGetData))
                return
                }
            do {
                let result = try JSONDecoder().decode(MovieResult.self, from: data)
                completion(.success(result.results))
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
  
    
    //    https://api.themoviedb.org/3/trending/tv/day?api_key=53bb76834e431dda9c6ac64c32ec35a5
    func getTrendingTv(completion: @escaping (Result<[TrendingTv], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/tv/day?api_key=\(Constants.apiKey)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                //                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let result = try JSONDecoder().decode(TrendingTvResponse.self, from: data)
                completion(.success(result.results))
                //                print(result)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
