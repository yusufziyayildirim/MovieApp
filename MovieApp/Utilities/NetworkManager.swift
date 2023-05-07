//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Yusuf Ziya YILDIRIM on 7.05.2023.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Codable>(type: T.Type, url: String, method: HttpMethod, completion: @escaping(Result<T, Error>)->()) {
        let session = URLSession.shared
        if let url = URL(string: url) {
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            let dataTask = session.dataTask(with: request) { [weak self] data, response, error in
                guard let self = self else { return }
                
                if let error = error {
                    completion(.failure(error))
                }
                
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(URLError(.zeroByteResource)))
                    return
                }
                
                self.handleResponse(data: data) { response in
                    completion(response)
                    
                }
            }
            
            dataTask.resume()
        }
    }
    
    private func handleResponse<T: Codable>(data: Data, complete: @escaping(Result<T, Error>)->()) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            complete(.success(result))
        } catch {
            complete(.failure(error))
        }
    }
}
