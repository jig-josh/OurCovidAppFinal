//
//  CovidAPI.swift
//  OurCovidApp
//
//  Created by Aysha, Jignasa and Gelila on 2022-07-28.
//

import Foundation

enum APIError: Error {
    case networkingError(Error)
    case serverError
    case requestError(Int, String)
    case invalidResponse
    case decodingError(Error)
}


class CovidAPI {
    
    private let session: URLSession
    private let baseURL = URL(string: "https://api.covid19tracker.ca/reports/province/")
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchCovidData(province: String = "on", completion: @escaping (Result<APIResponse, APIError>) -> Void) {
        let path = "\(province)"
        guard let url = baseURL?.appendingPathComponent(path) else { return }
        let request = URLRequest(url: url)
         
        perform(request: request, completion: completion)
    }
    
    private func perform(request: URLRequest, completion: @escaping (Result<APIResponse, APIError>) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.networkingError(error)))
                }
                return
            }
            
            guard let http = response as? HTTPURLResponse, let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            
            switch http.statusCode {
            case 200:
                let parser = JSONDecoder()
                parser.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try parser.decode(APIResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError(error)))
                    }
                }
                
            case 400...499:
                let body = String(data: data, encoding: .utf8)
                DispatchQueue.main.async {
                    completion(.failure(.requestError(http.statusCode, body ?? "<no body>")))
                }
            case 500...599:
                DispatchQueue.main.async {
                    completion(.failure(.serverError))
                }
                
            default:
                fatalError("Unhandled HTTP status code: \(http.statusCode)")
            }
        }
        
        task.resume()
    }
}
