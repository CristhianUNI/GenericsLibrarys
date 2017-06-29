//
//  MessageView.swift
//  Pods
//
//  Created by COCOMSYS One on 6/29/17.
//
//

import Foundation
import UIKit

public class MessageView {
    
    let alert: UIAlertController!
    
    init(title: String?, message: String?, cancelTitle: String? = "OK") {
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: nil)
        alert.addAction(cancelAction)
    }
    
    func show(controller: UIViewController) {
        controller.present(alert, animated: true)
    }
    
    public static func show(controller: UIViewController, title: String?, message: String?, cancelTitle: String? = "OK") {
        let myself = MessageView(
            title: title,
            message: message,
            cancelTitle: cancelTitle
        )
        controller.present(myself.alert, animated: true)
    }
}
