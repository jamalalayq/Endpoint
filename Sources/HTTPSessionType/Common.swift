
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
        
    public static let contentTypeAppJSON: Self = .init(key: "ContentType", value: HeadersValues.applicationJSON)
    public static let acceptAppJSON: Self = .init(key: "accept", value: HeadersValues.applicationJSON)
    
    public static func acceptLanguage(_ language: String) -> Self {
        .init(key: "Accept-Language", value: language)
    }
    
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
    func asCURL() -> String {
        let tab = "    "
        let newLine = "\n"
        
        var command = #"curl -iv \"#
        command.append(newLine)
        command.append(tab)
        command.append(#"-X \#(httpMethod ?? "GET") \"#)
                       
        command.append(newLine)
        allHTTPHeaderFields?.forEach { key, value in
            command.append(tab)
            command.append(#"-H "\#(key): \#(value)" \"#)
            command.append(newLine)
         }
                           
        if let body = httpBody, let json = String(data: body, encoding: .utf8) {
            command.append(tab)
            command.append(#"-d '\#(json)' \"#)
            command.append(newLine)
        }
                               
        command.append(tab)
        command.append(#" "\#(url?.absoluteString ?? "<EMPTY_URL>")" \"#)
        command.append(newLine)
               
        command.append(tab)
        command.append("-w ")
        command.append(newLine)
        command.append(newLine)
        command.append("{{[ Time Calculations ]}}")
        command.append(newLine)
        command.append("->")
        command.append("Connection Time: %{time_connect} [ s ]")
        command.append(newLine)
        command.append("->")
        command.append("Transfer Time: %{time_starttransfer} [ s ]")
        command.append(newLine)
        command.append("->")
        command.append("Total Time: %{time_total} [ s ]")
        command.append(newLine)
        command.append(newLine)
        command.append("Created By Jamal Alaayq")
        command.append(newLine)
        return command
    }
}
