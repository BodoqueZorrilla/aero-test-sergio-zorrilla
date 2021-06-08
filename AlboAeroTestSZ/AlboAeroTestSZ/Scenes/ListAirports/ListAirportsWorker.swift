//
//  ListAirportsWorker.swift
//  AlboAeroTestSZ
//
//  Created by Sergio Eduardo Zorrilla Arellano on 07/06/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//
import Foundation

protocol ListAirportsWorkerInterface {
    func getAirports(params: MapAirportsModels.FetchAirportsMap.Request,
                     completion: @escaping (_ result: ListAirportsModels.FetchAirportsList.Response) -> Void)
}

class ListAirportsWorker: ListAirportsWorkerInterface {
    func getAirports(params: MapAirportsModels.FetchAirportsMap.Request, completion: @escaping (ListAirportsModels.FetchAirportsList.Response) -> Void) {
        ApiHandler().getAirports(url: "airports/search/location/", method: "GET", params: params) { data, error in
            if error != nil {
                print("error -> ", error.debugDescription)
            } else {
                do {
                    let responseData = try JSONDecoder().decode(ResponseAirports.self, from: data!)
                    let response = ListAirportsModels.FetchAirportsList.Response(airports: responseData)
                    completion(response)
                } catch let jsonError {
                    print("Failed getting json -> ", jsonError)
                }
            }
        }
    }
    

}
