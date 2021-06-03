//
//  AppConstants.swift
//  GooglePlacesAPI
//
//  Created by Harsh Jaiswal on 03/06/21.
//

import Foundation

class AppConstants {
    static let googleMapKey = "AIzaSyDEPRccIiyh_9H2qon_H9WSMcrOyQWJu1I"
}

enum GoogleUrl : String {
    case autocomplete = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
    case placeDetail = "https://maps.googleapis.com/maps/api/place/details/json?placeid"
}
