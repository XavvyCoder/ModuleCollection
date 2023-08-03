//
//  TCPViewController.swift
//  ModuleCollection
//
//  Created by 정준우 on 2023/08/04.
//

import UIKit

class TCPViewController: UIViewController {
    let ipTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " IP input"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let portTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Port input"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(ipTextField)
        view.addSubview(portTextField)
        view.addSubview(sendButton)
        view.addSubview(activityIndicator)
        
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            ipTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ipTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            ipTextField.heightAnchor.constraint(equalToConstant: 50),
            ipTextField.widthAnchor.constraint(equalToConstant: 300),
        ])
        NSLayoutConstraint.activate([
            portTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            portTextField.topAnchor.constraint(equalTo: ipTextField.bottomAnchor, constant: 20),
            portTextField.heightAnchor.constraint(equalToConstant: 50),
            portTextField.widthAnchor.constraint(equalToConstant: 300),
        ])
        NSLayoutConstraint.activate([
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendButton.topAnchor.constraint(equalTo: portTextField.bottomAnchor, constant: 20),
            sendButton.heightAnchor.constraint(equalToConstant: 50),
            sendButton.widthAnchor.constraint(equalToConstant: 300),
        ])
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc func sendButtonTapped() {
        guard let hostInput = ipTextField.text, let portTextInput = portTextField.text, let portInput = Int32(portTextInput)
        else { return }
        
        let request = " ? "
        
        TCPHandler.shared.configureHostAndPort(host: hostInput, port: portInput)
        TCPHandler.shared.configureRequest(request: request)
        
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let response = try TCPHandler.shared.connectToServer()
                print(response)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                }
            } catch {
                if let error = error as? TCPError {
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                }
            }
        }
    }
}
