//
//  MapAirportsModels.swift
//  AlboAeroTestSZ
//
//  Created by Sergio Eduardo Zorrilla Arellano on 07/06/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import CoreLocation

enum MapAirportsModels {
    
    // MARK: Use cases
    
    enum FetchMapAirports {
        
        struct Request {
        }
        
        struct Response {
            var coordinates: CLLocationCoordinate2D
            var radiusKm: Int
        }
        
        struct ViewModel {
            var coordinates: CLLocationCoordinate2D
            var radiusKm: Int
        }
    }

    enum FetchAirportsMap {
        struct Request {
            var coordinates: CLLocationCoordinate2D
            var radiusKm: Int
        }

        struct Response {
            var airports: ResponseAirports?
        }
        
        struct ViewModel {
            var airports: ResponseAirports?
        }
    }
}

struct ResponseAirports: Codable {
    var items: [AirportModel]?
}

struct AirportModel: Codable {
    var icao: String?
    var iata: String?
    var name: String?
    var shortName: String?
    var municipalityName: String?
    var location: AirportLocation?
    var countryCode: String?
}

struct AirportLocation: Codable {
    var lat: Double?
    var lon: Double?
}
