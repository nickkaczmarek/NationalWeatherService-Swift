//
//  File.swift
//  
//
//  Created by Nicholas Kaczmarek on 6/7/21.
//

import Foundation

public struct ForecastGridDataPercentage: Decodable {
    public enum CodingKeys: String, CodingKey {
        case uom, values
    }

    public let unitOfMeasure: String?
    public let values: [ForecastGridDataPercentageValues]

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.unitOfMeasure = try container.decodeIfPresent(String.self, forKey: .uom)

        self.values = try container.decode([ForecastGridDataPercentageValues].self, forKey: .values)
    }
}

public struct ForecastGridDataPercentageValues: Decodable {
    public enum CodingKeys: String, CodingKey {
        case validTime, value
    }

    public let validTime: DateInterval
    public let value: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let validTimeValue = try container.decode(String.self, forKey: .validTime)
        guard let validTime = DateInterval.iso8601Interval(from: validTimeValue) else {
            throw DecodingError.dataCorruptedError(forKey: .validTime, in: container, debugDescription: "Invalid date interval.")
        }
        self.validTime = validTime

        let rawValue = try container.decode(Int.self, forKey: .value)

        self.value = "\(rawValue) %"
    }
}
