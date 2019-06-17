//
//  MemeImagePickerDelegate.swift
//  MeMe1.0
//
//  Created by NEVERCUTE on 17/06/2019.
//  Copyright © 2019 NEVERCUTE. All rights reserved.
//

import Foundation
import UIKit

class MemeImagePickerDelegate: UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Pick an image ")
        picker.dismiss(animated: true, completion: nil)
        print("Dismissed ")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        print("Dismissed ")
    }
}
