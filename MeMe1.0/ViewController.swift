//
//  ViewController.swift
//  MeMe1.0
//
//  Created by NEVERCUTE on 17/06/2019.
//  Copyright © 2019 NEVERCUTE. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let topTextFieldDelegate = MemeTextFieldDelegate()
    let bottomTextFieldDelegate = MemeTextFieldDelegate()
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var pickImageButton: UIBarButtonItem!
    
    @IBOutlet weak var imageToolbar: UIToolbar!
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    var memeImage: UIImage!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        imagePickerView.image = info[.originalImage] as? UIImage
        if let _ = imagePickerView.image {
            self.shareButton.isEnabled = true
        } else {
            self.shareButton.isEnabled = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        self.shareButton.isEnabled = false
        imagePickerView.image = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //cameraButton.isEnabled =  UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyBoardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyBoardNotifications()
    }
    
    fileprivate func setTextFieldProps(_ textField: UITextField) {
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .center
        textField.defaultTextAttributes = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strikethroughColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth: -4.0
        ]
    }
    
    @objc fileprivate func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isEditing {
            view.frame.origin.y = -getKeyboardHeight(notification)+20
            
        }
    }
    
    @objc fileprivate func keyboardWillHide(_ notification: Notification) {
        if bottomTextField.isEditing {
            view.frame.origin.y = 20
        }
    }
    
    fileprivate func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    fileprivate func subscribeToKeyBoardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    fileprivate func unsubscribeToKeyBoardNotifications(){
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func generateImage() -> UIImage {
        // Render view to an image
        UIGraphicsBeginImageContext(self.imagePickerView.frame.size)
        view.drawHierarchy(in: self.imagePickerView.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    fileprivate func prepareView() {
        
        //Prepare Text fields within image view
        self.topTextField.delegate = self.topTextFieldDelegate
        self.bottomTextField.delegate = self.bottomTextFieldDelegate
        
        self.setTextFieldProps(self.topTextField)
        self.setTextFieldProps(self.bottomTextField)
        
        //share button settings
        self.shareButton.isEnabled = false
        
    }
    
    //pick image from photo library
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickAnImage(.camera)
    }
    
    //pick image by camera roll button
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickAnImage(.photoLibrary)
    }
    
    fileprivate func pickAnImage(_ source : UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        present(pickerController, animated: true, completion: nil)
    }
    
    
    //share image action
    @IBAction func share() {
        memeImage = generateImage()
        let meme = Meme(topText: self.topTextField.text!, bottomText: self.bottomTextField.text!, image: imagePickerView.image!, memedImage: memeImage)
        print(meme)
        
        let activity = UIActivityViewController(activityItems: [memeImage!], applicationActivities: nil)
        show(activity, sender: self)
        
    }
    
    
}



