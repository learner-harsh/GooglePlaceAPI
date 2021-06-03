//
//  RootViewController.swift
//  GooglePlacesAPI
//
//  Created by Harsh Jaiswal on 03/06/21.
//

import Foundation
import UIKit

class RootViewController: UIViewController {
    
    static func create() -> RootViewController {
        let view = RootViewController()
        return view
    }
    
    private (set) lazy var mainBtn: UIButton = {[unowned self] in
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.setTitle("Open", for: UIControl.State.init())
        view.setTitleColor(.black, for: UIControl.State.init())
        view.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        view.addTarget(self, action: #selector(mainBtnPressed), for: .touchUpInside)
        view.cornerReduis(reduis: 5, BGColor: .clear, borderColor: .gray, borderWidth: 1)
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("deinit RootViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadUI()
    }
    
    @objc private
    func mainBtnPressed() {
        self.navigationController?.pushViewController(GoogleAutocompleteVC.create(), animated: true)
    }
}

extension RootViewController {
    func loadUI() {
        if !mainBtn.isDescendant(of: view) {
            view.addSubview(mainBtn)
        }
        mainBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mainBtn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15.0, bottom: 10, right: 15.0)
    }
}
