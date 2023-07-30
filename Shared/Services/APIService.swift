//
//  APIService.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 03/07/2023.
//

import Foundation


final class APIService {
    static let shared = APIService()
    let session = URLSession.shared

    private init() {}

    func get<T: Codable>(
        _ url: URL,
        headers: [String: String] = [:],
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = "GET"

        let (data, response) = try await session.data(for: urlRequest)

        guard let response = response as? HTTPURLResponse,
              200...299 ~= response.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try decoder.decode(T.self, from: data)
    }
}

extension URL {
    static let baseURL = "https://api-dev.taperk.com"

    static func buildURL(
        _ urlString: String = baseURL,
        version: String = APIVersion.v1,
        path: String,
        queries: [String: String?] = [:]
    ) -> URL {
        guard let baseURL = URL(string: urlString + version + path) else {
            fatalError()
        }

        let queryItems = queries.map { key, value in
            URLQueryItem(name: key, value: value)
        }

        return baseURL.appending(queryItems: queryItems)
    }

    mutating func append(queries: [String: String?]) {
        let queryItems = queries.map { key, value in
            URLQueryItem(name: key, value: value)
        }

        self.append(queryItems: queryItems)
    }
}

enum APIVersion {
    static let v1 = "/api/v1"
}

enum APIPath {
    static let availableRewards = "/users/rewards/available"
    static let rewardAccumulation = "/users/rewards/accumulation"
}
