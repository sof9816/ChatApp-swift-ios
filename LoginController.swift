//
//  LoginController.swift
//  ChatApp
//
//  Created by Mustafa on 5/10/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit
import Firebase


class LoginController: UIViewController {

    func alert(title:String, message:String,buttonTitle:String? = "OK", completion:(()->Void)? = nil ){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAlert = UIAlertAction(title: buttonTitle, style: .default) { (action) in
            if let completion = completion{
                completion()
            }
        }
        alert.addAction(okAlert)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    var messagesController: MessagesController?
    var inputContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldAnchor: NSLayoutConstraint?
    var emailTextFieldAnchor: NSLayoutConstraint?
    var passwordTextFieldAnchor: NSLayoutConstraint?
    
    
    let inputsContainerView: UIView = { // create a registeration view
        let view = UIView()
        view.backgroundColor =  UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var loginRegisterButton: UIButton = { // create a login button
       let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 26, g: 121, b: 255)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    

    
    let nameTextField: UITextField = {
       let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    let nameSperatorView: UIView =  {
    let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    let emailSperatorView: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        
        return tf
    }()
    

    
    lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Add-icon")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        image.isUserInteractionEnabled = true

       return image
    }()
    
    lazy var loginRegisterSegmentControl: UISegmentedControl = {
       let lrsc = UISegmentedControl(items: ["Login","Register"])
        lrsc.translatesAutoresizingMaskIntoConstraints = false
        lrsc.tintColor = .white
        lrsc.selectedSegmentIndex = 1
        lrsc.addTarget(self, action: #selector(handleLoginRegisterSegment), for: .valueChanged)
        return lrsc
    }()
    
   let loadingView = LoadingView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        self.hideKeyboardWhenTappedAround()

        view.backgroundColor = UIColor(r: 26, g: 163, b: 255)
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(loginRegisterSegmentControl)
        view.addSubview(profileImageView)
        
        setupProfileImageView()
        setupInputsConstraintView()
        setupLoginRegButton()
        setupLoginRegisterSegment()
        
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.loadingView.stopAnimating()
        self.loadingView.removeFromSuperview()
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.loadingView.stopAnimating()
        self.loadingView.removeFromSuperview()
    }
   
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() { // extension to make keybored hide if writing == nil
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

