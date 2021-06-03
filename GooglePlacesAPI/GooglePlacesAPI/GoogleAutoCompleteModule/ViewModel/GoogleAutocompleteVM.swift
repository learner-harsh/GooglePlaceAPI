//
//  GoogleAutocompleteVM.swift
//  GooglePlacesAPI
//
//  Created by Harsh Jaiswal on 03/06/21.
//

import Foundation
import CoreLocation

protocol GoogleAutocompleteViewProtocol: class {
    func updateMapLocation(lattitude:CLLocationDegrees,longitude:CLLocationDegrees)
    func addressPredictions(predictions: [Prediction])
}

protocol GoogleAutocompleteVMProtocol {
    var userLocation: CLLocationCoordinate2D? {get}
    func viewDidLoad()
    func searchAddress(input: String)
    func searchPlaceDetail(_ placeid: String)
}

class GoogleAutocompleteVM: NSObject {
    private weak var view: GoogleAutocompleteViewProtocol!
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocationCoordinate2D?
    init( view: GoogleAutocompleteViewProtocol) {
        self.view = view
    }
    
    deinit {
        debugPrint("Deinit GoogleAutocompleteVM")
    }
}

extension GoogleAutocompleteVM: GoogleAutocompleteVMProtocol {
    var userLocation: CLLocationCoordinate2D? {
        return currentLocation
    }
    
    func viewDidLoad() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func searchAddress(input: String) {
        APIHandler.shared.googleAutocompleteResult(input: input, location: currentLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)) { [weak self] (predictions) in
            guard let self = self else {return}
            self.view.addressPredictions(predictions: predictions)
        }
    }
    
    func searchPlaceDetail(_ placeid: String) {
        APIHandler.shared.googlePlaceResult(placeId: placeid) { [weak self] (placeLocation: PlaceLocation?) in
            guard let self = self else {return}
            let lat: CLLocationDegrees = placeLocation?.latitude ?? 0
            let lng: CLLocationDegrees = placeLocation?.longitude ?? 0
            debugPrint("Search location: \(lat), \(lng)")
            self.view.updateMapLocation(lattitude: lat, longitude: lng)
        }
    }
}

extension GoogleAutocompleteVM: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        currentLocation = locValue
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        view.updateMapLocation(lattitude: locValue.latitude, longitude: locValue.longitude)
    }
}

