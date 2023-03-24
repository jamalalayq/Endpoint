
import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public struct Header {
    public let key, value: String
    
    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
        
    public static let contentTypeAppJSON: Self = .init(key: "Content-Type", value: HeadersValues.applicationJSON)
    public static let acceptAppJSON: Self = .init(key: "Accept", value: HeadersValues.applicationJSON)
    
    public static func acceptLanguage(_ language: String) -> Self { .init(key: "Accept-Language", value: language) }
    
    public static func userAgent(_ value: String) -> Self { .init(key: "User-Agent", value: value) }
    
    public struct HeadersValues {
        public static let applicationJSON: String = "application/json"
    }
}

extension Encodable {
    func asData(by encoder: JSONEncoder = .init()) throws -> Data {
        try encoder.encode(self)
    }
}

extension URLRequest {
    func toCURL() -> String {
        var body: String = ""
        if let httpBody {
            body = String(decoding: httpBody, as:  UTF8.self)
        }
        
        return #"""

curl --location --request \#(httpMethod ?? "GET") '\#(url?.absoluteString ?? "")' \
\#((allHTTPHeaderFields ?? [:]).compactMap { "--header \'\($0): \($1)\' \\" }.joined(separator: "\n") )
--data-raw '\#(body)'

"""#
    }
}
