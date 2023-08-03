//
//  AlertHandler.swift
//  ModuleCollection
//
//  Created by 정준우 on 2023/08/04.
//

import UIKit

@objc class AlertHandler: NSObject {
    
    @objc static func showAlert(on viewController: UIViewController, title: String, message: String, actionTitle: String = "OK", actionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: actionHandler)
        alertController.addAction(action)
        DispatchQueue.main.async {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
    @objc static func showAlertWithNoButton(on viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        DispatchQueue.main.async {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
}
