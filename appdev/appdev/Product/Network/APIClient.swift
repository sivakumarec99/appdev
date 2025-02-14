//
//  APIClient.swift
//  JsonService
//
//  Created by JIDTP1408 on 12/02/25.
//

import Foundation

enum APIError: Error {
    case invalidURL, requestFailed, decodingFailed
}

protocol APIClient {
    func request<T: Decodable>(_ endpoint: APIService, completion: @escaping (Result<T, Error>) -> Void)
}

final class APIClientImpl: APIClient {
    func request<T: Decodable>(_ endpoint: APIService, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(APIError.invalidURL))
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(APIError.decodingFailed))
            }
        }.resume()
    }
}

