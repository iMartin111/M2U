//
//  APIManager.swift
//  M2U
//
//  Created by Yan Akhrameev on 22/09/21.
//


import UIKit


class APIManager {
    
    // MARK: - Properties:
    
    let baseURL = "https://api.themoviedb.org/3/movie/111"
    let imageUrl =  "https://image.tmdb.org/t/p/w500"
    
    // MARK: - Methods:
    
    func fetchMovie(completion: @escaping (Result<Movie, Error>) -> Void) {
        
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.queryItems = ["api_key" : "03269f4b09e5bcabf8f5481a800ac72d"].map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let movie = try jsonDecoder.decode(Movie.self, from: data)
                    completion(.success(movie))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchMovieImage(for imagePath: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let urlForImage = URL(string: "\(imageUrl)\(imagePath)")
        let task = URLSession.shared.dataTask(with: urlForImage!) { (data, response, error) in
            if let data = data {
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchRelatedMovies(completion: @escaping (Result<Movies, Error>) -> Void) {
        var urlComponents = URLComponents(string: "\(baseURL)/similar")!
        urlComponents.queryItems = ["api_key" : "03269f4b09e5bcabf8f5481a800ac72d"].map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let movies = try jsonDecoder.decode(Movies.self, from: data)
                    completion(.success(movies))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    
    
    
}
