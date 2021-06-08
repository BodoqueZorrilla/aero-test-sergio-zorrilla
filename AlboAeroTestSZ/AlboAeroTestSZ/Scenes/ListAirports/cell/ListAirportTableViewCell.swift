//
//  ListAirportTableViewCell.swift
//  AlboAeroTestSZ
//
//  Created by Sergio Eduardo Zorrilla Arellano on 08/06/21.
//

import UIKit

class ListAirportTableViewCell: UITableViewCell {
    @IBOutlet weak var airportNameLabel: UILabel!
    @IBOutlet weak var icaoLabel: UILabel!
    @IBOutlet weak var iataLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    static let cellIdentifier = "ListAirportTableViewCell"

    var airport: AirportModel! {
        didSet {
            airportNameLabel.text = airport.name
            icaoLabel.text = airport.icao
            iataLabel.text = airport.iata
            locationLabel.text = "lat: \(airport.location?.lat ?? 0.0)\nlon: \(airport.location?.lon ?? 0.0)"
        }
    }
}
