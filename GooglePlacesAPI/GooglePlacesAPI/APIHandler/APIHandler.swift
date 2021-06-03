//
//  APIHandler.swift
//  GooglePlacesAPI
//
//  Created by Harsh Jaiswal on 03/06/21.
//

import Foundation

class APIHandler {
    static let shared = APIHandler()
    private init() {
    }
    
    func googlePlacesResult(input: String, completion: @escaping (_ result: NSArray) -> Void) {
        let searchWordProtection = input.replacingOccurrences(of: " ", with: "")
        if !searchWordProtection.isEmpty {
//            let dfdf = String(format: "%@?input=%@&types=establishment|geocode&location=%@,%@&radius=500&language=en&key=%@",GoogleUrl.autocomplete.rawValue,input ,"\(28.535517)","\(77.391029)",AppConstants.googleMapKey)
            let urlString = NSString(format: "%@?input=%@&types=establishment|geocode&location=%@,%@&radius=500&language=en&key=%@",GoogleUrl.autocomplete.rawValue,input,"\(28.535517)","\(77.391029)",AppConstants.googleMapKey)
            let url = URL(string: urlString.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!)
//            let urlString = NSString(format: "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=establishment|geocode&location=%@,%@&radius=500&language=en&key=AIzaSyBxbEh5YeXI1zXvD3eDzCF3qz7ygwO_GN0",input,"\(28.535517)","\(77.391029)")
//            let url = URL(string: urlString.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!)
            URLSession.shared.jsonDecodableTask(with: url!) { (result: Result<PredictionData, Error>) in
                switch result {
                case .success(let person):
                    print("Person \(person.status)")s
                case .failure(let error):
                    print(error)
                }
            }.resume()
        }
    }
}
