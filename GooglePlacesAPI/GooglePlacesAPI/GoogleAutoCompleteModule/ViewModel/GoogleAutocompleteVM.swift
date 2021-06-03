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
}

protocol GoogleAutocompleteVMProtocol {
    var userLocation: CLLocationCoordinate2D? {get}
    func viewDidLoad()
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
}

extension GoogleAutocompleteVM: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        currentLocation = locValue
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        view.updateMapLocation(lattitude: locValue.latitude, longitude: locValue.longitude)
    }
}

