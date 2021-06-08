//
//  ApiHandler.swift
//  AlboAeroTestSZ
//
//  Created by Sergio Eduardo Zorrilla Arellano on 08/06/21.
//

import Foundation

struct ApiStrings {
    static let apiKey = Bundle.main.infoDictionary!["API_KEY"] as? String
    static let apiHost = Bundle.main.infoDictionary!["API_HOST"] as? String
    static let apiURL = "https://aerodatabox.p.rapidapi.com/"
}
class ApiHandler {
    func getAirports(url: String,
                     method: String,
                     params: MapAirportsModels.FetchAirportsMap.Request,
                     completion: @escaping(_ response: Data?, _ error: Error?) -> Void) {
        let url = URL(string: ApiStrings.apiURL + url + "\(params.coordinates.latitude)/\(params.coordinates.longitude)/km/\(params.radiusKm)/16")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.setValue(ApiStrings.apiKey, forHTTPHeaderField: "x-rapidapi-key")
        urlRequest.setValue(ApiStrings.apiHost, forHTTPHeaderField: "x-rapidapi-host")

        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(nil, error)
            } else {
                completion(data, nil)
            }
        })

        dataTask.resume()
    }
}

