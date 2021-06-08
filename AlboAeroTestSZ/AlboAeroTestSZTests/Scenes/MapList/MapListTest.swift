//
//  MapListTest.swift
//  AlboAeroTestSZTests
//
//  Created by Sergio Eduardo Zorrilla Arellano on 08/06/21.
//

import XCTest
import CoreLocation
@testable import AlboAeroTestSZ

class MapListTest: XCTestCase {
    private var sut: MapAirportsInteractor!
    override func setUp() {
        sut = MapAirportsInteractor()
    }

    func testGetAirports() {
        // GIVEN
        let request = MapAirportsModels.FetchAirportsMap.Request(coordinates: CLLocationCoordinate2D(latitude: 37.33233141,
                                                                                                     longitude: -122.031218),
                                                                 radiusKm: 27)
        let workerSpy = GetAirportsWorkerSpySuccess()
       
        let getAirportsSpy = GetAirportPresenterSpy()
        sut.worker = workerSpy
        sut.presenter = getAirportsSpy
        // WHEN
        sut.getMapAirports(request: request)
        
        // THEN
        getAirportsSpy.presentAirports = true
        getAirportsSpy.presentAirportsResponse = MapAirportsModels.FetchAirportsMap.Response(airports: ResponseAirports())
        XCTAssertTrue(getAirportsSpy.presentAirports)
        XCTAssertNotNil(getAirportsSpy.presentAirportsResponse)
        workerSpy.getAirports(params: request) { response in
            XCTAssertNotEqual(getAirportsSpy.presentAirportsResponse?.airports?.items?.count, response.airports?.items?.count)
        }
    }

}

class GetAirportsWorkerSpySuccess: MapAirportsWorkerInterface {
    func getAirports(params: MapAirportsModels.FetchAirportsMap.Request,
                     completion: @escaping (MapAirportsModels.FetchAirportsMap.Response) -> Void) {
        let dataResponse = AirportModel(icao: "KSJC",
                                        iata: "SJC",
                                        name: "San Jose, Norman Y. Mineta San Jose",
                                        shortName: "Norman Y. Mineta",
                                        municipalityName: "San Jose",
                                        location: AirportLocation(lat: 37.3626,
                                                                  lon: -121.929),
                                        countryCode: "US")
        let responseGetData = ResponseAirports(items: [dataResponse])
        let result = MapAirportsModels.FetchAirportsMap.Response(airports: responseGetData)
        completion(result)
    }
}

class GetAirportPresenterSpy: MapAirportsPresenterInterface {
    var presentAirports = false
    var presentAirportsResponse: MapAirportsModels.FetchAirportsMap.Response?
    func presentMapAirports(response: MapAirportsModels.FetchMapAirports.Response) {}
    
    func presentMapAirportsFromApi(response: MapAirportsModels.FetchAirportsMap.Response) {
        presentAirports = true
        presentAirportsResponse = response
    }

}
