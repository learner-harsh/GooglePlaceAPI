//
//  PredictionView.swift
//  GooglePlacesAPI
//
//  Created by Harsh Jaiswal on 03/06/21.
//

import Foundation
import UIKit

class PredictionView: UIView {
    
    private (set) lazy var containerView: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private (set) lazy var lblTitle: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 12, weight: .semibold)
        lbl.clipsToBounds = true
        lbl.text = "Title dsfkjsdfh dsfoidfs "
        return lbl
    }()
    
    private (set) lazy var button: UIButton = {[unowned self] in
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.setTitleColor(.black, for: UIControl.State.init())
        view.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        return view
    }()
    
    private var action: ((_ placeId: String) -> Void)!
    private var viewModel: PredictionViewVMProtocol!
    
    init(viewModel: PredictionViewVMProtocol, action: @escaping ((_ placeId: String) -> Void)) {
        super.init(frame: CGRect.zero)
        self.viewModel = viewModel
        lblTitle.text = viewModel.placeDetail
        self.action = action
        setUpContainerView()
    }
    
    deinit {
        debugPrint("deinit PredictionView")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    @objc private
    func actionButton() {
        debugPrint("Action")
        action(viewModel.placeId)
    }
}

//MARK: Autolayout handling
extension PredictionView {
    private func setUpContainerView() {
        backgroundColor = .white
        if !containerView.isDescendant(of: self) {
            self.addSubview(containerView)
        }
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true

        
        if !lblTitle.isDescendant(of: containerView) {
            containerView.addSubview(lblTitle)
        }
        lblTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        lblTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        if !button.isDescendant(of: self) {
            self.addSubview(button)
        }
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        button.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
}
