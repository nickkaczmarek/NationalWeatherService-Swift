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
    public let elevation: Measurement<UnitLength>

    public let apparentTemperature: ForecastGridDataTemperature
    public let temperature: ForecastGridDataTemperature
    public let minTemperature: ForecastGridDataTemperature
    public let maxTemperature: ForecastGridDataTemperature
    public let dewPoint: ForecastGridDataTemperature
    public let headIndex: ForecastGridDataTemperature
    public let windChill: ForecastGridDataTemperature

    public let probabilityOfPrecipitation: ForecastGridDataPercentage
    public let relativeHumidity: ForecastGridDataPercentage
    public let skyCover: ForecastGridDataPercentage

    public let pressure: ForecastGridDataPercentage

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let validTimesValue = try container.decode(String.self, forKey: .validTimes)
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
        self.headIndex = try container.decode(ForecastGridDataTemperature.self, forKey: .heatIndex)
        self.windChill = try container.decode(ForecastGridDataTemperature.self, forKey: .windChill)

        self.probabilityOfPrecipitation = try container.decode(ForecastGridDataPercentage.self, forKey: .probabilityOfPrecipitation)
        self.relativeHumidity = try container.decode(ForecastGridDataPercentage.self, forKey: .relativeHumidity)
        self.skyCover = try container.decode(ForecastGridDataPercentage.self, forKey: .skyCover)

        self.pressure = try container.decode(ForecastGridDataPercentage.self, forKey: .pressure)
    }
}
