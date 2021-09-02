//
//  AlterTempate.swift
//  TestOne
//
//  Created by Муслим Курбанов on 03.05.2021.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Закрыть",
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
