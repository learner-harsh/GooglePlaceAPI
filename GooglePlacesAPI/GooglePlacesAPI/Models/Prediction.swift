//
//  Prediction.swift
//  GooglePlacesAPI
//
//  Created by Harsh Jaiswal on 03/06/21.
//

import Foundation

struct PredictionData: Codable {
    var status: String?
    var predictions: [Prediction]?
}

struct Prediction: Codable {
    var description: String?
    var placeId: String?
    enum CodingKeys: String, CodingKey {
        case description
        case placeId = "place_id"
    }
}

struct PlaceData: Codable {
    var status: String?
    var result: PlaceDetail?
}

struct PlaceDetail: Codable {
    var geometry: PlaceGeometry?
}

struct PlaceGeometry: Codable {
    var location: PlaceLocation?
}


struct PlaceLocation: Codable {
    var latitude: Double?
    var longitude: Double?
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}
