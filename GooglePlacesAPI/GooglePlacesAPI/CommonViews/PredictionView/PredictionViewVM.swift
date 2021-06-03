//
//  PredictionViewVM.swift
//  GooglePlacesAPI
//
//  Created by Harsh Jaiswal on 03/06/21.
//

import Foundation

protocol PredictionViewVMProtocol {
    var placeDetail: String {get}
    var placeId: String {get}
}

class PredictionViewVM: PredictionViewVMProtocol {
    var placeDetail: String = ""
    var placeId: String = ""
    init(placeId: String, placeDetail: String) {
        self.placeId = placeId
        self.placeDetail = placeDetail
    }
    
    deinit {
        debugPrint("deinit PredictionViewVM")
    }
}
