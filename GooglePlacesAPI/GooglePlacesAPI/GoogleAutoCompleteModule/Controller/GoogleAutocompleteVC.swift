//
//  GoogleAutocompleteVC.swift
//  GooglePlacesAPI
//
//  Created by Harsh Jaiswal on 03/06/21.
//

import Foundation
import UIKit
import GoogleMaps

class GoogleAutocompleteVC: UIViewController {
    
    static func create() -> GoogleAutocompleteVC {
        let view = GoogleAutocompleteVC()
        view.viewModel = GoogleAutocompleteVM.init(view: view)
        return view
    }
    
    private (set) lazy var searchBar: UISearchBar = {[unowned self] in
        let view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.searchBarStyle = UISearchBar.Style.default
        view.placeholder = " Search..."
        view.sizeToFit()
        view.isTranslucent = false
        view.backgroundImage = UIImage()
        //        view.delegate = self
        return view
    }()
    
    
    private (set) lazy var mapView: GMSMapView = {[unowned self] in
        let view = GMSMapView.map(withFrame: self.view.frame, camera: GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0))
        return view
    }()
    
    private (set) lazy var marker: GMSMarker = {[unowned self] in
        let view = GMSMarker()
        return view
    }()
    
    private var viewModel: GoogleAutocompleteVMProtocol!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("deinit GoogleAutocompleteVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadUI()
        viewModel.viewDidLoad()
    }
}

//MARK: Autolayout handling
extension GoogleAutocompleteVC {
    private func loadUI() {
        view.backgroundColor = .white
        transparentNavigationBar()
        
        view.addSubview(mapView)
        
        if !mapView.isDescendant(of: view) {
            view.addSubview(mapView)
        }
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.map = mapView
    }
    
    private func transparentNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
    }
}

extension GoogleAutocompleteVC: GoogleAutocompleteViewProtocol {
    func updateMapLocation(lattitude:CLLocationDegrees,longitude:CLLocationDegrees){
        let camera = GMSCameraPosition.camera(withLatitude: lattitude, longitude: longitude, zoom: 16)
        mapView.camera = camera
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: lattitude, longitude: longitude))
        marker.position = CLLocationCoordinate2D(latitude: lattitude, longitude: longitude)
    }
}

