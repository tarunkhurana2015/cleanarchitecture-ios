//
//  File.swift
//  
//
//  Created by Tarun Khurana on 4/28/24.
//

import Foundation

public enum HTTPMethodType: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

public enum BodyEncoding {
    case jsonSerializationData
    case stringEncodingAscii
}

public protocol BodyEncoder {
    func encode(_ parameters: [String: Any]) -> Data?
}
public struct JSONBodyEncoder: BodyEncoder {
    
    public init() {
        
    }
    public func encode(_ parameters: [String: Any]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: parameters)
    }
}

enum RequestGenerationError: Error {
    case components
}

public protocol Requestable {
    var path: String { get }
    var isFullPath: Bool { get }
    var method: HTTPMethodType { get }
    var headerParameters: [String: String] { get }
    var queryParametersEncodable: Encodable? { get }
    var queryParameters: [String: Any] { get }
    var bodyParamatersEncodable: Encodable? { get }
    var bodyParameters: [String: Any] { get }
    var bodyEncoder: BodyEncoder { get }

    func urlRequest(with config: NetworkConfigurable) throws -> URLRequest
}

extension Requestable {
    
    func url(with config: NetworkConfigurable) throws -> URL {
        
        // check for the baseURL if the last characetr is "/", if not then append the last character "/"
        let baseUrl = config.baseUrl.absoluteString.last != "/" ?
                                                                config.baseUrl.absoluteString + "/" :
                                                                config.baseUrl.absoluteString
        // if the baseURL is not a full path then append the path
        let endpoint = isFullPath ? path : baseUrl.appending(path)
        
        // setup the urlComponents
        guard var urlComponents = URLComponents(string: endpoint) else { throw RequestGenerationError.components}
        var urlQueryItems = [URLQueryItem]()
        
        // handle the query items
        let queryParams = self.queryParameters
        for (key, value) in queryParams {
            urlQueryItems.append(URLQueryItem(name: key, value: value as? String))
        }
        // add the query items from the config
        for (key, value) in config.queryParams {
            urlQueryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        
        guard let url = urlComponents.url else { throw RequestGenerationError.components }
        return url

    }
    
    public func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
        
        // UrlRequest
        let url = try self.url(with: config)
        var urlRequest = URLRequest(url: url)
        
        // HTTP Headers
        var allHeaders: [String: String] = config.headers
        for (key, value) in headerParameters {
            allHeaders.updateValue(value, forKey: key)
        }
        urlRequest.allHTTPHeaderFields = allHeaders
        
        // HTTP Body
        let bodyParams = self.bodyParameters
        if !bodyParams.isEmpty {
            urlRequest.httpBody = bodyEncoder.encode(bodyParams)
        }
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
    private func encodeBody(bodyParamaters: [String: Any], bodyEncoding: BodyEncoding) -> Data? {
        switch bodyEncoding {
        case .jsonSerializationData:
            return try? JSONSerialization.data(withJSONObject: bodyParamaters)
        case .stringEncodingAscii:
            return bodyParamaters.queryString.data(using: String.Encoding.ascii, allowLossyConversion: true)
        }
    }
}

private extension Dictionary {
    var queryString: String {
        return self.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
}

public struct Request: Requestable {
    public let path: String
    public let isFullPath: Bool
    public let method: HTTPMethodType
    public let headerParameters: [String: String]
    public let queryParametersEncodable: Encodable?
    public let queryParameters: [String: Any]
    public let bodyParamatersEncodable: Encodable?
    public let bodyParameters: [String: Any]
    public let bodyEncoder: BodyEncoder
    
    public init(path: String,
         isFullPath: Bool = false,
         method: HTTPMethodType,
         headerParameters: [String: String] = [:],
         queryParametersEncodable: Encodable? = nil,
         queryParameters: [String: Any] = [:],
         bodyParametersEncodable: Encodable? = nil,
         bodyParameters: [String: Any] = [:],
         bodyEncoder: BodyEncoder = JSONBodyEncoder()) {
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.headerParameters = headerParameters
        self.queryParametersEncodable = queryParametersEncodable
        self.queryParameters = queryParameters
        self.bodyParamatersEncodable = bodyParametersEncodable
        self.bodyParameters = bodyParameters
        self.bodyEncoder = bodyEncoder
    }
}
