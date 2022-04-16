//
//  ForecastGridDataTemperature.swift
//  NationalWeatherService-Swift
//
//  Created by Nicholas Kaczmarek on 6/6/21.
//

import Foundation

public struct ForecastGridDataTemperature: Codable {
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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(unitOfMeasure, forKey: .uom)
        try container.encode(values, forKey: .values)
    }
}

public struct ForecastGridDataTemperatureValues: Codable {
    public enum CodingKeys: String, CodingKey {
        case validTime, value
    }

    public let validTime: DateInterval
    private let rawValidTime: String
    public let value: Measurement<UnitTemperature>
    private let rawValue: Double?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let validTimeValue = try container.decode(String.self, forKey: .validTime)
        self.rawValidTime = validTimeValue
        guard let validTime = DateInterval.iso8601Interval(from: validTimeValue) else {
            throw DecodingError.dataCorruptedError(forKey: .validTime, in: container, debugDescription: "Invalid date interval.")
        }
        self.validTime = validTime

        self.rawValue = try container.decode(Double?.self, forKey: .value)

        self.value = Measurement(value: self.rawValue ?? -270, unit: .celsius)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rawValidTime, forKey: .validTime)
        try container.encode(rawValue, forKey: .value)
    }
}
