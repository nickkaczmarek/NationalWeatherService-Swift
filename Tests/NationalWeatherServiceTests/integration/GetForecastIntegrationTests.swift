import XCTest
@testable import NationalWeatherService

final class GetForecastIntegrationTests: XCTestCase {
    func testGetForecastForLocation() throws {
        let forecastExpectation = self.expectation(description: "get forecast expectation")
        nws.forecast(latitude: 47.6174, longitude: -122.2017) { result in
            XCTAssertSuccess(result)

            let forecast = try! result.get()
            XCTAssertFalse(forecast.periods.isEmpty)

            forecastExpectation.fulfill()
        }

        wait(for: [forecastExpectation], timeout: 5)
    }

    func testGetHourlyForecast() throws {
        let hourlyForecastExpectation = self.expectation(description: "get hourly forecast expectation")
        nws.hourlyForecast(latitude: 47.6174, longitude: -122.2017) { result in
            XCTAssertSuccess(result)

            let forecast = try! result.get()
            XCTAssertFalse(forecast.periods.isEmpty)

            hourlyForecastExpectation.fulfill()
        }
        wait(for: [hourlyForecastExpectation], timeout: 10)
    }

    func testGetForecastGridData() throws {
        let forecastGridDataExpectation = self.expectation(description: "get forecast grid data expectation")
        nws.forecastGridData(latitude: 47.6174, longitude: -122.2017) { result in
            XCTAssertSuccess(result)

            let forecast = try! result.get()
            XCTAssertFalse(forecast.apparentTemperature.values.isEmpty)
            XCTAssertFalse(forecast.temperature.values.isEmpty)
            XCTAssertFalse(forecast.dewPoint.values.isEmpty)
            XCTAssertFalse(forecast.probabilityOfPrecipitation.values.isEmpty)

            forecastGridDataExpectation.fulfill()
        }
        wait(for: [forecastGridDataExpectation], timeout: 10)
    }

    static var allTests = [
        ("testGetForecastForLocation", testGetForecastForLocation),
        ("testGetHourlyForecast", testGetHourlyForecast),
        ("testGetForecastGridData", testGetForecastGridData)
    ]
}
