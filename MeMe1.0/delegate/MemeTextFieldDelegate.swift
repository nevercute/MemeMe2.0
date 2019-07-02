//
//  MemeTextFieldDelegate.swift
//  MeMe1.0
//
//  Created by NEVERCUTE on 01/07/2019.
//  Copyright © 2019 NEVERCUTE. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var fieldText: String = ""
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
//        NotificationCenter.default.post(Notification.init(name: UIResponder.keyboardWillShowNotification))
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        NotificationCenter.default.post(Notification.init(name: UIResponder.keyboardWillShowNotification))
    }
    
}