//
//  Service.swift
//  DesafioAgileTV
//
//  Created by Bruno Rodrigues on 08/02/25.
//

import Foundation

/// Possible Network errors
enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}

/// Possible Endpoints
enum Endpoints {
    case getRepos(String)
    
    /// Possible HTTP methods
    var method: String {
        switch self {
        case .getRepos: return "GET"
        }
    }
    
    /// Possible API urls
    var url: String {
        switch self {
        case .getRepos(let user): return "https://api.github.com/users/\(user)/repos"
        }
    }
}

class Service {
    
    /// Get a list of all repositories
    /// - Parameter user: User to be searched
    /// - Returns: Fetched repositories or error
    func getRepos(user: String) async -> Result< [Repo], NetworkError > {
        let result = await makeRequest(endpoint: Endpoints.getRepos(user), Type: [Repo].self)
        return result
    }
    
    /// Generic request function
    /// - Parameters:
    ///   - endpoint: Wich endpoint its going to be called
    ///   - Type: Generic type of object to be expected
    /// - Returns: Result of the request
    private func makeRequest<T: Codable>(endpoint: Endpoints, Type: T.Type) async -> Result< T, NetworkError> {
        guard let url = URL(string: endpoint.url) else { return .failure(NetworkError.badUrl) }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.method
        urlRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        guard let (data, response) = try? await URLSession.shared.data(for: urlRequest) else { return .failure(NetworkError.badResponse)}
        guard let response = response as? HTTPURLResponse else { return .failure(NetworkError.badResponse) }
        guard response.statusCode >= 200 && response.statusCode < 300 else { return .failure(NetworkError.badStatus) }
        guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { return .failure(NetworkError.failedToDecodeResponse) }
        
        return .success(decodedResponse)
    }
}
