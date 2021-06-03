//
//  URLSession+.swift
//  GooglePlacesAPI
//
//  Created by Harsh Jaiswal on 03/06/21.
//

import Foundation
enum URLError: Error {
    case noData, decodingError
}

extension URLSession {

    /// A type safe URL loader that either completes with success value or error with Error
    func jsonDecodableTask<T: Decodable>(with url: URLRequest, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
       self.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                guard let data = data, let _ = response else {
                    completion(.failure(URLError.noData))
                    return
                }
                do {
                    let decoded = try decoder.decode(T.self, from: data)
                    completion(.success(decoded))
                } catch  {
                    completion(.failure(error))
                }
            }
        }
    }

    func jsonDecodableTask<T: Decodable>(with url: URL, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
       self.jsonDecodableTask(with: URLRequest(url: url), decoder: decoder, completion: completion)
    }
}
