//
//  ForecastGridData.swift
//  NationalWeatherService-Swift
//
//  Created by Nicholas Kaczmarek on 6/6/21.
//

import Foundation

public struct ForecastGridData: Codable {
    public enum CodingKeys: String, CodingKey {
        case validTimes
        case elevation
        case apparentTemperature
        case temperature
        case dewpoint
        case minTemperature
        case maxTemperature
        case heatIndex
        case windChill
        case probabilityOfPrecipitation
        case pressure
        case relativeHumidity
        case skyCover
    }

    public let validTimes: DateInterval
    private let rawValidTimes: String
    public let elevation: Measurement<UnitLength>

    public let apparentTemperature: ForecastGridDataTemperature
    public let temperature: ForecastGridDataTemperature
    public let minTemperature: ForecastGridDataTemperature
    public let maxTemperature: ForecastGridDataTemperature
    public let dewPoint: ForecastGridDataTemperature
    public let heatIndex: ForecastGridDataTemperature
    public let windChill: ForecastGridDataTemperature

    public let probabilityOfPrecipitation: ForecastGridDataPercentage
    public let relativeHumidity: ForecastGridDataPercentage
    public let skyCover: ForecastGridDataPercentage

    public let pressure: ForecastGridDataPercentage

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let validTimesValue = try container.decode(String.self, forKey: .validTimes)
        self.rawValidTimes = validTimesValue
        guard let validTimes = DateInterval.iso8601Interval(from: validTimesValue) else {
            throw DecodingError.dataCorruptedError(forKey: .validTimes, in: container, debugDescription: "Invalid date interval.")
        }
        self.validTimes = validTimes
        let elevationContainer = try container.nestedContainer(keyedBy: AnyCodingKey.self, forKey: .elevation)
        let elevationValue = try elevationContainer.decode(Double.self, forKey: AnyCodingKey(stringValue: "value"))
        self.elevation = Measurement(value: elevationValue, unit: .meters)
        self.apparentTemperature = try container.decode(ForecastGridDataTemperature.self, forKey: .apparentTemperature)
        self.temperature = try container.decode(ForecastGridDataTemperature.self, forKey: .temperature)
        self.dewPoint = try container.decode(ForecastGridDataTemperature.self, forKey: .dewpoint)
        self.minTemperature = try container.decode(ForecastGridDataTemperature.self, forKey: .minTemperature)
        self.maxTemperature = try container.decode(ForecastGridDataTemperature.self, forKey: .maxTemperature)
        self.heatIndex = try container.decode(ForecastGridDataTemperature.self, forKey: .heatIndex)
        self.windChill = try container.decode(ForecastGridDataTemperature.self, forKey: .windChill)
        self.probabilityOfPrecipitation = try container.decode(ForecastGridDataPercentage.self, forKey: .probabilityOfPrecipitation)
        self.relativeHumidity = try container.decode(ForecastGridDataPercentage.self, forKey: .relativeHumidity)
        self.skyCover = try container.decode(ForecastGridDataPercentage.self, forKey: .skyCover)
        self.pressure = try container.decode(ForecastGridDataPercentage.self, forKey: .pressure)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(elevation, forKey: .elevation)
        try container.encode(rawValidTimes, forKey: .validTimes)
        try container.encode(apparentTemperature, forKey: .apparentTemperature)
        try container.encode(temperature, forKey: .temperature)
        try container.encode(dewPoint, forKey: .dewpoint)
        try container.encode(minTemperature, forKey: .minTemperature)
        try container.encode(maxTemperature, forKey: .maxTemperature)
        try container.encode(heatIndex, forKey: .heatIndex)
        try container.encode(windChill, forKey: .windChill)
        try container.encode(probabilityOfPrecipitation, forKey: .probabilityOfPrecipitation)
        try container.encode(relativeHumidity, forKey: .relativeHumidity)
        try container.encode(skyCover, forKey: .skyCover)
        try container.encode(pressure, forKey: .pressure)
    }
}
