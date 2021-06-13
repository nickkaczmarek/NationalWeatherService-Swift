//
//  File.swift
//  
//
//  Created by Nicholas Kaczmarek on 6/6/21.
//

import Foundation

extension NationalWeatherService {
    public typealias ForecastGridDataHandler = (Result<ForecastGridData, Error>) -> Void

    fileprivate func loadForecastGridData(at url: URL, then handler: @escaping ForecastGridDataHandler) {
        self.load(at: url, as: ForecastGridData.self, then: handler)
    }

    public func forecastGridData(latitude: Double, longitude: Double, then handler: @escaping ForecastGridDataHandler) {
        self.loadPoint(latitude: latitude, longitude: longitude) { pointResult in
            // TODO: this is ugly
            switch pointResult {
            case .success(let point):
                self.loadForecastGridData(at: point.forecastGridData, then: handler)
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}

#if canImport(CoreLocation)
import CoreLocation

extension NationalWeatherService {
    public func forecastGridData(for coordinates: CLLocationCoordinate2D, then handler: @escaping ForecastGridDataHandler) {
        self.forecastGridData(latitude: coordinates.latitude, longitude: coordinates.longitude, then: handler)
    }

    public func forecastGridData(for location: CLLocation, then handler: @escaping ForecastGridDataHandler) {
        self.forecastGridData(for: location.coordinate, then: handler)
    }
}
#endif
