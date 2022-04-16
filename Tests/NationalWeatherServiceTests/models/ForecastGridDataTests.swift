//
//  File.swift
//  
//
//  Created by Nicholas Kaczmarek on 6/6/21.
//

import XCTest
@testable import NationalWeatherService

final class ForecastGridDataTests: XCTestCase {
    let iso8601 = ISO8601DateFormatter()

    func testForecastGridData_canBe_Decoded() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let forecastData = Fixtures.ForecastGridData_Only_Fixture_STL
        let forecast = try decoder.decode(ForecastGridData.self, from: forecastData)

        XCTAssertNotNil(forecast.elevation)

        XCTAssertNotNil(forecast.apparentTemperature)

        XCTAssertNotNil(forecast.pressure)
    }

    func testForecastGridData_canBe_Encoded_and_Decoded() throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let forecastData = Fixtures.ForecastGridData_Only_Fixture_STL
        let decodedForecast = try decoder.decode(ForecastGridData.self, from: forecastData)

        let encodedForecast = try encoder.encode(decodedForecast)

        XCTAssertNotNil(encodedForecast)
        let json = String(data: encodedForecast, encoding: .utf8)
        XCTAssertNotNil(json)

        let redecodedForecast = try decoder.decode(ForecastGridData.self, from: encodedForecast)
        XCTAssertNotNil(redecodedForecast)
    }

    static var allTests = [
        ("testForecastGridData_canBe_Decoded", testForecastGridData_canBe_Decoded),
        ("testForecastGridData_canBe_Encoded_and_Decoded", testForecastGridData_canBe_Encoded_and_Decoded)
    ]
}
