//
//  MainViewController.swift
//  ModuleCollection
//
//  Created by 정준우 on 2023/08/04.
//

import UIKit

class MainViewController: UIViewController {

    let alertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("AlertHandler", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5.0
        return button
    }()
    
    let tcpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("TCPHandler", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5.0
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        tcpButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alertButton)
        view.addSubview(tcpButton)
        
        alertButton.addTarget(self, action: #selector(alertButtonTapped), for: .touchUpInside)
        tcpButton.addTarget(self, action: #selector(tcpButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70),
            alertButton.heightAnchor.constraint(equalToConstant: 70),
            alertButton.widthAnchor.constraint(equalTo: alertButton.heightAnchor, multiplier: 2.0),
        ])
        NSLayoutConstraint.activate([
            tcpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tcpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 70),
            tcpButton.heightAnchor.constraint(equalToConstant: 70),
            tcpButton.widthAnchor.constraint(equalTo: alertButton.heightAnchor, multiplier: 2.0),
        ])
    }

    @objc func alertButtonTapped() {
        AlertHandler.showAlert(on:self,
                               title:"테스트 알림",
                               message:"아래 확인 버튼을 누르시면 됩니다.",
                               actionTitle:"확인",
                               actionHandler:nil)
    }
    @objc func tcpButtonTapped() {
        let tcpViewController = TCPViewController()
        navigationController?.pushViewController(tcpViewController, animated: true)
    }
}
