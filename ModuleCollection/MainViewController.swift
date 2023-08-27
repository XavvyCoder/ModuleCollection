//
//  MainViewController.swift
//  ModuleCollection
//
//  Created by 정준우 on 2023/08/04.
//

import UIKit

class MainViewController: UIViewController {

    lazy var portraitConstraints: [NSLayoutConstraint] = {
        var constraints: [NSLayoutConstraint] = []
        constraints.append(contentsOf: [
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.bounds.height/3),
        ])
        constraints.append(contentsOf: [
            tcpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tcpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        constraints.append(contentsOf: [
            sampleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sampleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.bounds.height/3)
        ])
        return constraints
    }()
    lazy var landscapeConstraints: [NSLayoutConstraint] = {
        var constraints: [NSLayoutConstraint] = []
        constraints.append(contentsOf: [
            alertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.bounds.height/3),
        ])
        constraints.append(contentsOf: [
            tcpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tcpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        constraints.append(contentsOf: [
            sampleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            sampleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.bounds.height/3)
        ])
        return constraints
    }()
    let alertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("AlertHandler", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.frame.size.width = 300
        button.frame.size.height = 180
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5.0
        return button
    }()
    
    let tcpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("TCPHandler", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.frame.size.width = 300
        button.frame.size.height = 180
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5.0
        return button
    }()
    
    let sampleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("HTTPHandler", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.frame.size.width = 300
        button.frame.size.height = 180
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5.0
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeOrientationChanges()
        
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        tcpButton.translatesAutoresizingMaskIntoConstraints = false
        sampleButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alertButton)
        view.addSubview(tcpButton)
        view.addSubview(sampleButton)
        
        alertButton.addTarget(self, action: #selector(alertButtonTapped), for: .touchUpInside)
        tcpButton.addTarget(self, action: #selector(tcpButtonTapped), for: .touchUpInside)
        sampleButton.addTarget(self, action: #selector(sampleButtonTapped), for: .touchUpInside)
            
        applyOrientationSpecificSettings()
    }
    func observeOrientationChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIApplication.willChangeStatusBarOrientationNotification, object: nil)
    }
    @objc func orientationChanged() {
        applyOrientationSpecificSettings()
        self.view.layoutIfNeeded()
    }
    func applyOrientationSpecificSettings() {
        if UIApplication.shared.statusBarOrientation.isPortrait {
            NSLayoutConstraint.deactivate(landscapeConstraints)
            NSLayoutConstraint.activate(portraitConstraints)
        } else if UIApplication.shared.statusBarOrientation.isLandscape {
            NSLayoutConstraint.deactivate(portraitConstraints)
            NSLayoutConstraint.activate(landscapeConstraints)
        }
    }
    @objc func alertButtonTapped() {
        AlertHandler.showAlert(on:self,
                               title:"테스트 알림",
                               message:"아래 확인 버튼을 누르시면 됩니다.",
                               actionTitle:"확인",
                               actionHandler:nil)
    }
    @objc func tcpButtonTapped() {
        self.navigationController?.pushViewController(TCPViewController(), animated: false)
    }
    @objc func sampleButtonTapped() {
        self.navigationController?.pushViewController(SampleViewController(), animated: false)
    }
}
