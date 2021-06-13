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

    func testForecastGridData() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let forecastData = Fixtures.ForecastGridData_Only_Fixture_STL
        let forecast = try decoder.decode(ForecastGridData.self, from: forecastData)

        XCTAssertNotNil(forecast.elevation)

        XCTAssertNotNil(forecast.apparentTemperature)

        XCTAssertNotNil(forecast.pressure)
    }

    static var allTests = [
        ("testForecastGridDataTests", testForecastGridData)
    ]
}
