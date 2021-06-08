//
//  SearchRangeViewController.swift
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

protocol SearchRangeDisplayInterface: AnyObject {
    func askLocationPermission(permission: SearchRangeModels.FetchSearchRangeAksLocation.Response)
}

class SearchRangeViewController: UIViewController {
    
    // MARK: - Properties
    
    var interactor: SearchRangeInteractorInterface?
    var router: (SearchRangeRouterInterface & SearchRangeDataPassing)?
    
    @IBOutlet weak var nameAppLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var rangeSlider: UISlider!
    @IBOutlet weak var descriptionKmLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!

    var locationManager = CLLocationManager()
    var coordinates = CLLocationCoordinate2D()

    // MARK: - Init

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupVIPCycle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupVIPCycle()
    }
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLabels()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAccessibilityIdentifers()
        performRequest()
        configureLocationManager()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Setup
    
    private func setupVIPCycle() {
        let viewController = self
        let interactor = SearchRangeInteractor()
        let presenter = SearchRangePresenter()
        let router = SearchRangeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        searchButton.layer.cornerRadius = 20.0
    }
    
    private func setupAccessibilityIdentifers() {
    
    }

    private func setupLabels() {
        nameAppLabel.text = LocalizedKeys.Search.title
        descriptionKmLabel.text = LocalizedKeys.Search.radius
        searchButton.setTitle(LocalizedKeys.Search.button, for: .normal)
    }
    
    // MARK: - Helpers
    
    func performRequest() {
        let request = SearchRangeModels.FetchSearchRangeAksLocation.Request()
        interactor?.fetchSearchRangeLocation(request: request)
    }

    private func configureLocationManager(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    private func showAlertSettings() {
        let alertController = UIAlertController(title: LocalizedKeys.Search.Alert.title,
                                                message: LocalizedKeys.Search.Alert.message,
                                                preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: LocalizedKeys.Search.Alert.settings, style: .default) { (_) -> Void in
            guard let urlGeneral = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            UIApplication.shared.open(urlGeneral)
        }
        let cancelAction = UIAlertAction(title: LocalizedKeys.Search.Alert.cancel,
                                         style: .default,
                                         handler: nil)

        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func sliderDidChange(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        self.rangeLabel.text = "\(currentValue)"
    }

    @IBAction func searchDidTouch(_ sender: Any) {
        router?.showAirports(coordinates: self.coordinates,
                             radiusKm: Int(self.rangeSlider.value))
    }
}


// MARK: - SearchRangeDisplayLogic

extension SearchRangeViewController: SearchRangeDisplayInterface {
    func askLocationPermission(permission: SearchRangeModels.FetchSearchRangeAksLocation.Response) {
        switch permission.locationManager?.authorizationStatus {
        case .restricted, .denied:
            self.showAlertSettings()
        default:
            break
        }
        if let coordenadas = permission.locationManager?.location?.coordinate {
            self.coordinates = coordenadas
        }
    }
}

extension SearchRangeViewController: CLLocationManagerDelegate{

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        switch status {
        case .notDetermined:
            manager.requestLocation()
        case .authorizedAlways, .authorizedWhenInUse:
            break
        case .denied, .restricted:
            self.showAlertSettings()
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){

    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){

    }
}