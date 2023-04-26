//
//  NetworkService.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-21.
//

import Foundation
// responsible for api calling
class NetworkService {
    // singleton
    static let shared = NetworkService()
    
    // fetch trending movies
    // get trending movies
    /// function to fetch trending movies
    /// - Parameter completion: Gives data on success or an error
    /// - Result: represents either a success or a failure, including an associated value in each case.
    func getTrendingMovie(completion: @escaping (Result<[Poster], Error>)-> Void) {
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
                let result = try JSONDecoder().decode(PosterResult.self, from: data)
                completion(.success(result.results))
            } catch {
                // incase there is an error, print the error
                print(error)
                completion(.failure(ApiError.failedToGetData))
            }
        }
        task.resume()
    }
    
    // fetch popular movies
    func getPopularMovies(completion: @escaping (Result<[Poster], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/popular?api_key=\(Constants.apiKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure( error ?? ApiError.failedToGetData ))
                return
            }
            do {
                let result = try JSONDecoder().decode(PosterResult.self, from: data)
                completion(.success(result.results))
            } catch {
                print(error)
                completion(.failure(ApiError.failedToGetData))
            }
        }
        task.resume()
    }
    
    // fetch now playing movies
    func getNowPlayingMovies(completion: @escaping (Result<[Poster], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/now_playing?api_key=\(Constants.apiKey)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ApiError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(PosterResult.self, from: data)
                completion(.success(result.results))
            } catch {
                print(error)
                completion(.failure(ApiError.failedToGetData))
            }
        }
        task.resume()
    }
    
    // fetch top rated movies
    func getTopRatedMovies(completion: @escaping (Result<[Poster], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/top_rated?api_key=\(Constants.apiKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ApiError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(PosterResult.self, from: data)
                completion(.success(result.results))
            } catch {
                print(error)
                completion(.failure(ApiError.failedToGetData))
            }
        }
        task.resume()
    }
    
    // fetch upcoming movies
    func getUpcomingMovies(completion: @escaping (Result<[Poster], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/upcoming?api_key=\(Constants.apiKey)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ApiError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(PosterResult.self, from: data)
                completion(.success(result.results))
            } catch {
                print(error)
                completion(.failure(ApiError.failedToGetData))
            }
        }
        task.resume()
    }
    
    // fetch trending tv
    func getTrendingTv(completion: @escaping (Result<[Poster], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/tv/day?api_key=\(Constants.apiKey)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ApiError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(PosterResult.self, from: data)
                completion(.success(result.results))
            } catch {
                print(error)
                completion(.failure(ApiError.failedToGetData))
            }
        }
        task.resume()
    }
    
    // fetch popular tv
    func getPopularTv(completion: @escaping (Result<[Poster], Error>) -> Void ) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/tv/popular?api_key=\(Constants.apiKey)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ApiError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(PosterResult.self, from: data)
                completion(.success(result.results))
            } catch {
                print(error)
                completion(.failure(ApiError.failedToGetData))
            }
        }
        task.resume()
    }
    
    // fetch airing today tv
    func getAiringTodayTv(completion: @escaping (Result<[Poster], Error>) -> Void ) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/tv/airing_today?api_key=\(Constants.apiKey)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ApiError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(PosterResult.self, from: data)
                completion(.success(result.results))
            } catch {
                print(error)
                completion(.failure(ApiError.failedToGetData))
            }
        }
        task.resume()
    }
    
    // fetch top rated tv
    func getTopRatedTv(completion: @escaping (Result<[Poster], Error>) -> Void ) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/tv/top_rated?api_key=\(Constants.apiKey)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ApiError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(PosterResult.self, from: data)
                completion(.success(result.results))
            } catch {
                print(error)
                completion(.failure(ApiError.failedToGetData))
            }
        }
        task.resume()
    }
    
    // youtube api caller to display the trailers
    func getTrailer(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        // replace white space adding Percent Encoding
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        // url string
        guard let url = URL(string: "\(Constants.YoutubeBaseUrl)q=\(query)&key=\(Constants.YoutubeAPIKey)") else { return }
        // url session
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let data = data, error == nil else { return }
            do {
                // decode response
                let result = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                // access the items but return the firs index which is the best matching result
                completion(.success(result.items[0]))
            }
            catch {
                print(error)
                completion(.failure(ApiError.failedToGetData))
            }
        }
        task.resume()
    }
    
    // search for movies with the user query term
    func searchMovie(with query: String, completion: @escaping (Result<[Poster], Error>) -> Void) {
        // format query to return a new string
        // replace white space adding Percent Encoding
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseUrl)/3/search/multi?api_key=\(Constants.apiKey)&query=\(query)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(PosterResult.self, from: data)
                completion(.success(result.results))
            } catch {
                print(error)
                completion(.failure(ApiError.failedToGetData))
            }
        }
        task.resume()
    }
}
