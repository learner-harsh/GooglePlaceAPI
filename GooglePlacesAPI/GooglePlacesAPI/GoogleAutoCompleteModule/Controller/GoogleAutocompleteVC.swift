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
    
    private (set) lazy var containerView: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .red
        return view
    }()
    
    private (set) lazy var txtField: UITextField = {[unowned self] in
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autocapitalizationType = .none
        view.setLeftPaddingPoints(5)
        view.textAlignment = .left
        view.textColor = .black
        view.backgroundColor = .white
        view.font = .systemFont(ofSize: 16, weight: .medium)
        view.backgroundColor = .systemGroupedBackground
        view.cornerReduis(reduis: 5, BGColor: .white, borderColor: .clear, borderWidth: 0)
        view.clipsToBounds = true
        view.placeholder = "Search"
        view.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        return view
    }()
    
    private (set) lazy var stackView: UIStackView = { [unowned self] in
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = 0.5
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
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
    
    @objc private
    func textFieldDidChange(textField: UITextField) {
        viewModel.searchAddress(input: textField.text ?? "")
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
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.map = mapView
        
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 0 
        
        if !txtField.isDescendant(of: view) {
            view.addSubview(txtField)
        }
        txtField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraints.point16).isActive = true
        txtField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constraints.point16).isActive = true
        txtField.topAnchor.constraint(equalTo: view.topAnchor, constant: (navigationController?.navigationBar.frame.size.height ?? 80) + topPadding + 20).isActive = true
        txtField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        if !stackView.isDescendant(of: view) {
            view.addSubview(stackView)
        }
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraints.point16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constraints.point16).isActive = true
        stackView.topAnchor.constraint(equalTo: txtField.bottomAnchor, constant: Constraints.point0).isActive = true
        //        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func transparentNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
    }
}

extension GoogleAutocompleteVC: GoogleAutocompleteViewProtocol {
    func addressPredictions(predictions: [Prediction]) {
        debugPrint("predictions: \(predictions.count)")
        self.stackView.resetStack()
        predictions.forEach { [weak self] (prediction: Prediction) in
            guard let self = self else {return}
            let predictionview = PredictionView {
                debugPrint("predictionview clicked")
            }
            self.stackView.addArrangedSubview(predictionview)
        }
    }
    
    func updateMapLocation(lattitude:CLLocationDegrees,longitude:CLLocationDegrees){
        let camera = GMSCameraPosition.camera(withLatitude: lattitude, longitude: longitude, zoom: 16)
        mapView.camera = camera
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: lattitude, longitude: longitude))
        marker.position = CLLocationCoordinate2D(latitude: lattitude, longitude: longitude)
    }
}

