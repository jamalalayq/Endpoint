//
//  Created by Jamal Alaayq on 2023-03-17.
//

import Foundation

public final class URLClientSession: URLSessionType {
    private let session: URLSession = .shared
    
    public func request(endpoint: some Endpoint) async throws -> (Decodable)? {
        .none
    }
}
