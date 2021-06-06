//
//  AppConstants.swift
//  GooglePlacesAPI
//
//  Created by Harsh Jaiswal on 03/06/21.
//

import Foundation

class AppConstants {
    static let googleMapKey = "Your key"
}

enum GoogleUrl : String {
    case autocomplete = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
    case placeDetail = "https://maps.googleapis.com/maps/api/place/details/json?placeid"
}
