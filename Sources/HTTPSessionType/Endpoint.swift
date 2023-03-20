//
//  Created by Jamal Alaayq on 2022-12-16.
//

import Foundation

public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: Array<URLQueryItem>? { get }
    var defaultHeaders: Array<Header>? { get }
    var method: HTTPMethod { get }
    var body: (any Encodable)? { get }
    var headers: Array<Header>? { get }
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
    var isDebuggable: Bool { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var timeoutInterval: TimeInterval { get }
    var responseType: Decodable.Type { get }
}

// MARK: - Defaults
public extension Endpoint {
    var queryItems: Array<URLQueryItem>? { .none }
    var method: HTTPMethod { .get }
    var body: (any Encodable)? { .none }
    var defaultHeaders: Array<Header>? { .none }
    var headers: Array<Header>? { .none }
    var encoder: JSONEncoder { .init() }
    var decoder: JSONDecoder { .init() }
    var isDebuggable: Bool { false }
    var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }
    var timeoutInterval: TimeInterval { 60.0 }
}

public extension Endpoint {
    func makeURL() throws -> URL {
        var urlComponents = URLComponents(string: baseURL + path)
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else { throw URLError(.badURL) }
        return url
    }
    
    func makeURLRequest() throws -> URLRequest {
        let url = try makeURL()
        
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.allowsCellularAccess = true
        request.httpMethod = method.rawValue
        defaultHeaders?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key)}
        request.httpBody = try body?.asData(by: encoder)
        if isDebuggable { debugPrint(url.lastPathComponent, ":", request.asCURL()) }
        return request
    }
}
