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
    
    func googlePlacesResult(input: String, location: CLLocationCoordinate2D, completion: @escaping (_ result: [Prediction]) -> Void) {
        let searchWordProtection = input.replacingOccurrences(of: " ", with: "")
        if !searchWordProtection.isEmpty {
            let urlString = NSString(format: "%@?input=%@&types=establishment|geocode&location=%@,%@&radius=500&language=en&key=%@",GoogleUrl.autocomplete.rawValue,input,"\(location.latitude)","\(location.longitude)",AppConstants.googleMapKey)
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
}
