//
//  SampleViewController.swift
//  ModuleCollection
//
//  Created by 정준우 on 2023/08/27.
//

import UIKit
import Combine

class SampleViewController: UIViewController {
    var viewModel = SampleViewModel()
    
    let ohButton: UIButton = {
        let button = UIButton()
        button.frame.size.width = 200
        button.frame.size.height = 150
        button.layer.cornerRadius = 20
        button.backgroundColor = .magenta
        button.setTitle("실행해봐", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        view.addSubview(ohButton)
        
        ohButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ohButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ohButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        ohButton.addTarget(self, action: #selector(ohButtonTapped), for: .touchUpInside)
    }
    
    @objc func ohButtonTapped() {
        viewModel.fetchByName()
    }
}
