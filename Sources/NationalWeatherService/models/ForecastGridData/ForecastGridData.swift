//
//  File.swift
//  
//
//  Created by Nicholas Kaczmarek on 6/6/21.
//

import Foundation

public struct ForecastGridData: Decodable {
    public enum CodingKeys: String, CodingKey {
        case validTimes, elevation
    }

    // TODO: Handle valid times interval
    public let validTimes: DateInterval
    public let elevation: Measurement<UnitLength>

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let validTimesValue = try container.decode(String.self, forKey: .validTimes)
        guard let validTimes = DateInterval.iso8601Interval(from: validTimesValue) else {
            throw DecodingError.dataCorruptedError(forKey: .validTimes, in: container, debugDescription: "Invalid date interval.")
        }
        self.validTimes = validTimes

        let elevationContainer = try container.nestedContainer(keyedBy: AnyCodingKey.self, forKey: .elevation)
        let elevationValue = try elevationContainer.decode(Double.self, forKey: AnyCodingKey(stringValue: "value"))

        self.elevation = Measurement(value: elevationValue, unit: .meters)      // NWS returns elevation in meters regardless of parent unit
    }
}
