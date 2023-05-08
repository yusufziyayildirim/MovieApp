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
    
    @discardableResult
    func request<T: Codable>(type: T.Type, url: String, method: HttpMethod, completion: @escaping(Result<T, Error>)->()) -> URLSessionDataTask? {
        let session = URLSession.shared
        var dataTask: URLSessionDataTask?
        
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            dataTask = session.dataTask(with: request) { [weak self] data, response, error in
                guard let self = self else { return }
                
                if let error = error {
                    completion(.failure(error))
                    return
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
            dataTask?.resume()
       }
        
        return dataTask
    }
    
    private func handleResponse<T: Codable>(data: Data, completion: @escaping(Result<T, Error>)->()) {
        do {
            /*
             For the Data type, return the data as is without attempting to decode it since it may already be in the expected binary format
             */
            if T.self == Data.self {
                completion(.success(data as! T))
            }else{
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            }
        } catch {
            completion(.failure(error))
        }
    }
}
