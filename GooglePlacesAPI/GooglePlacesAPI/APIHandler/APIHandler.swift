//
//  APIHandler.swift
//  GooglePlacesAPI
//
//  Created by Harsh Jaiswal on 03/06/21.
//

import Foundation
import CoreLocation

class APIHandler {
    static let shared = APIHandler()
    private init() {
    }
    
    func googleAutocompleteResult(input: String, location: CLLocationCoordinate2D, completion: @escaping (_ result: [Prediction]) -> Void) {
        let searchWordProtection = input.replacingOccurrences(of: " ", with: "")
        if !searchWordProtection.isEmpty {
            let urlString = NSString(format: "%@?input=%@&types=establishment|geocode&location=%@,%@&radius=5000&language=en&key=%@",GoogleUrl.autocomplete.rawValue,input,"\(location.latitude)","\(location.longitude)",AppConstants.googleMapKey)
            let url = URL(string: urlString.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!)
            URLSession.shared.jsonDecodableTask(with: url!) { (result: Result<PredictionData, Error>) in
                switch result {
                case .success(let person):
                    completion(person.predictions ?? [])
                case .failure(let error):
                    print(error)
                    completion([])
                }
            }.resume()
        }
    }
    
    func googlePlaceResult(placeId: String, completion: @escaping (_ result: PlaceLocation?) -> Void) {
        let searchWordProtection = placeId.replacingOccurrences(of: " ", with: "")
        if !searchWordProtection.isEmpty {
            let urlString = NSString(format: "%@=%@&key=%@",GoogleUrl.placeDetail.rawValue,placeId,AppConstants.googleMapKey)
            let url = URL(string: urlString.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!)
            URLSession.shared.jsonDecodableTask(with: url!) { (result: Result<PlaceData, Error>) in
                switch result {
                case .success(let placeData):
                    completion(placeData.result?.geometry?.location)
                case .failure(let error):
                    print(error)
                    completion(nil)
                }
            }.resume()
        }
    }
}
