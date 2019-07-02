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
    
    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Share Image", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.addTarget(self, action: #selector(ViewController.save), for: .touchUpInside)
        button.backgroundColor = .blue
        button.isEnabled = false
        return button
    }()
    
    let pickImageButton: UIBarButtonItem = {
        let pickButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.pickAnImageFromAlbum))
        return pickButton
    }()
    
    let cameraButton: UIBarButtonItem = {
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(ViewController.pickAnImageFromCamera))
        return cameraButton
    }()
    
    let flexibleSpaceButton: UIBarButtonItem = {
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        return flexible
    }()
    
    let imageToolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 500, y: 10, width: 400, height: 20))
        toolbar.sizeToFit()
        toolbar.backgroundColor = UIColor.blue
        return toolbar
    }()
    
    let imagePickerView: UIImageView = {
        let imageController = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
        return imageController
    }()
    //var cameraButton: UIBarButtonItem!
    let topTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 50, y: 0, width: 300, height: 30))
        textField.placeholder = "TOP TEXT"
        return textField
    }()
    
    let bottomTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 150, y: 0, width: 300, height: 30))
        textField.placeholder = "BOTTOM TEXT"
        return textField
    }()
    
    var memeImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        // Do any additional setup after loading the view.
    }
    
    @objc func pickAnImageFromAlbum(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @objc func pickAnImageFromCamera(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
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
            NSAttributedString.Key.strokeWidth: 2.0
        ]
    }
    
    @objc fileprivate func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        if keyboardSize.cgSizeValue.height > view.frame.size.height/2 {
            view.frame.origin.y = -getKeyboardHeight(notification)+20
        }
    }
    
    @objc fileprivate func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 20
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
    
    @objc fileprivate func save() {
        
        memeImage = generateImage()
        let meme = Meme(topText: self.topTextField.text!, bottomText: self.bottomTextField.text!, image: imagePickerView.image!, memedImage: memeImage)
        print(meme)
        
        let activity = UIActivityViewController(activityItems: [memeImage!], applicationActivities: nil)
        show(activity, sender: self)
        
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
        
        let textVStack = UIStackView(arrangedSubviews: [self.topTextField, self.bottomTextField])
        self.imagePickerView.addSubview(textVStack)
        self.imagePickerView.isUserInteractionEnabled = true
        
        //prepare share button
        self.shareButton.setTitle("SHARE", for: .normal)
        
        //prepare toolbar
        self.imageToolbar.setItems([pickImageButton, flexibleSpaceButton, cameraButton], animated: true)
        self.imageToolbar.center = CGPoint(x: view.frame.width/2, y: 100)
        
        let verticalView = UIStackView(arrangedSubviews: [shareButton, imagePickerView, imageToolbar])
        
        
        view.addSubview(verticalView)
        
        //main stackview constriants
        verticalView.axis = .vertical
        verticalView.translatesAutoresizingMaskIntoConstraints = false
        verticalView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        verticalView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0 ).isActive = true
        verticalView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        verticalView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        
        //share button constrains
        self.shareButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        self.shareButton.leadingAnchor.constraint(equalTo: verticalView.leadingAnchor).isActive = true
        self.shareButton.trailingAnchor.constraint(equalTo: verticalView.trailingAnchor).isActive = true
        self.shareButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //image constraints
        

        self.imagePickerView.topAnchor.constraint(equalTo: shareButton.bottomAnchor, constant: 120).isActive = true
        self.imagePickerView.leadingAnchor.constraint(equalTo: verticalView.leadingAnchor).isActive = true
        self.imagePickerView.trailingAnchor.constraint(equalTo: verticalView.trailingAnchor, constant: 0).isActive = true
        self.imagePickerView.contentMode = .scaleAspectFill

        //toolbar constraints
        self.imageToolbar.leadingAnchor.constraint(equalTo: verticalView.leadingAnchor).isActive = true
        self.imageToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        self.imageToolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        //textfield constraints
        textVStack.axis = .vertical
        textVStack.translatesAutoresizingMaskIntoConstraints = false
        textVStack.alignment = .center
        textVStack.distribution = .equalSpacing
        textVStack.centerXAnchor.constraint(equalTo: verticalView.centerXAnchor).isActive = true
        textVStack.centerYAnchor.constraint(equalTo: verticalView.centerYAnchor).isActive = true
        self.topTextField.topAnchor.constraint(equalTo: shareButton.bottomAnchor, constant: 20).isActive = true
        self.topTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        self.topTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        self.bottomTextField.topAnchor.constraint(equalTo: imageToolbar.topAnchor, constant: -70).isActive = true
        self.bottomTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        self.bottomTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
    }
}


