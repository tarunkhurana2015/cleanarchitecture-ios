// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public protocol NetworkSession {
    func request(_ request: Requestable) async throws -> Data
}

public struct DefaultNetworkSession: NetworkSession {
    
    private let config: NetworkConfigurable
    private let urlSession: NetworkURLSession
    
    public init(config: NetworkConfigurable, urlSession: NetworkURLSession = DefaultNetworkURLSession()) {
        self.config = config
        self.urlSession = urlSession
    }
    
    public func request(_ request: Requestable) async throws -> Data {
        do {
            let urlRequest = try request.urlRequest(with: config)
            let result = await self.request(request: urlRequest)
            switch result {
            case let .success(data):
                return data
            case let .failure(error):
                throw error
            }
        } catch {
            throw NetworkError.urlGeneration
        }
    }
    
}

// MARK: Private
extension DefaultNetworkSession {
    private func request(request: URLRequest) async -> Result<Data, Error> {
        do {
            let data = try await urlSession.request(request)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
}
