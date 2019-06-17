//
//  ViewController.swift
//  MeMe1.0
//
//  Created by NEVERCUTE on 17/06/2019.
//  Copyright © 2019 NEVERCUTE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ImagePickerView: UIImageView!
    
    let imagePickerDelegate = MemeImagePickerDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = imagePickerDelegate
        present(pickerController, animated: true, completion: nil)
    }
    
}

