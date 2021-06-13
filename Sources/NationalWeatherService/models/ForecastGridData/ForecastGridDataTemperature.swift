//
//  File.swift
//  
//
//  Created by Nicholas Kaczmarek on 6/6/21.
//

import Foundation

public struct ForecastGridDataTemperature: Decodable {
    public enum CodingKeys: String, CodingKey {
        case uom, values
    }

    public let unitOfMeasure: String?
    public let values: [ForecastGridDataTemperatureValues]

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.unitOfMeasure = try container.decodeIfPresent(String.self, forKey: .uom)

        self.values = try container.decode([ForecastGridDataTemperatureValues].self, forKey: .values)
    }
}

public struct ForecastGridDataTemperatureValues: Decodable {
    public enum CodingKeys: String, CodingKey {
        case validTime, value
    }

    public let validTime: DateInterval
    public let value: Measurement<UnitTemperature>

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let validTimeValue = try container.decode(String.self, forKey: .validTime)
        guard let validTime = DateInterval.iso8601Interval(from: validTimeValue) else {
            throw DecodingError.dataCorruptedError(forKey: .validTime, in: container, debugDescription: "Invalid date interval.")
        }
        self.validTime = validTime

        let rawValue = try container.decode(Double?.self, forKey: .value)

        self.value = Measurement(value: rawValue ?? 0, unit: .celsius)

    }
}