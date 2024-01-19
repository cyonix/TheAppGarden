//
//  Created by Austin Ugbeme on 1/18/24.
//

import Foundation

@propertyWrapper
public struct CodableDate<D: DateDecoder> {
    public var wrappedValue: Date

    public init(_ date: Date) {
        self.wrappedValue = date
    }
}

public protocol DateDecoder {
    static func date(
        from string: String,
        codingPath: [CodingKey]
    ) throws -> Date
}

extension CodableDate: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let text = try container.decode(String.self)
        let date = try D.date(from: text, codingPath: container.codingPath)
        self.wrappedValue = date
    }
}

public struct RFC3339DateFormatterProvider: DateDecoder {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
    
    public static func date(
        from string: String,
        codingPath: [CodingKey]
    ) throws -> Date {
        guard let date = dateFormatter.date(from: string) else {
            throw DecodingError.dataCorrupted(.init(codingPath: codingPath, debugDescription: "Invalid format!"))
        }
        
        return date
    }
}

public struct ISO8601DateFormatterProvider: DateDecoder {
    static let dateFormatter = ISO8601DateFormatter()
    
    public static func date(
        from string: String,
        codingPath: [CodingKey]
    ) throws -> Date {
        guard let date = dateFormatter.date(from: string) else {
            throw DecodingError.dataCorrupted(.init(codingPath: codingPath, debugDescription: "Invalid format!"))
        }
        
        return date
    }
}
