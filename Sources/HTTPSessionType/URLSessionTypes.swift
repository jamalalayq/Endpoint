//
//  Created by Jamal Alaayq on 2022-12-16.
//

import Foundation

public protocol URLSessionType {
    func request(endpoint: some Endpoint) async throws -> (any Decodable)?
}
