//
//  ViewController.swift
//  CryptoTracker_v1.0
//
//  Created by Tanguy BILLON on 20/01/2021.
//

import UIKit
import FirebaseAuth

let LightGreyColor = UIColor.init(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, alpha: 1.00)
let DarkBluePerso = UIColor.init(red: 0.13, green: 0.14, blue: 0.32, alpha: 1.00)
let ElectricBluePerso = UIColor.init(red: 0.00, green: 0.92, blue: 1.00, alpha: 1.00)
let BkgGreyedBlue = UIColor.init(red: 0.20, green: 0.44, blue: 0.50, alpha: 1.00)

class ViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Log In"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private let emailField: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = "Email Adress"
        emailField.layer.borderWidth = 1
        emailField.layer.cornerRadius = 12
        emailField.backgroundColor = BkgGreyedBlue
        return emailField
    }()
    
    private let passwordField: UITextField = {
        let passField = UITextField()
        passField.placeholder = "Password"
        passField.layer.borderWidth = 1
        passField.isSecureTextEntry = true
        passField.layer.cornerRadius = 12
        passField.backgroundColor = BkgGreyedBlue
        return passField
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
       return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(button)
        view.layer.contents = UIImage(named: "blockchainbkg")?.cgImage
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        label.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 80)
        
        emailField.frame = CGRect(x: 20,
                                  y: label.frame.origin.y+label.frame.size.height+10,
                                  width: view.frame.size.width-40,
                                  height: 50)
        
        passwordField.frame = CGRect(x: 20,
                                     y: emailField.frame.origin.y+emailField.frame.size.height+10,
                                     width: view.frame.size.width-40,
                                     height: 50)
        
        button.frame = CGRect(x: 20,
                              y: passwordField.frame.origin.y+passwordField.frame.size.height+30,
                              width: view.frame.size.width-40,
                              height: 52)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailField.becomeFirstResponder()
    }
    @objc private func didTapButton() {
        print("Continue button tapped")
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            print("Missing field data")
            return
        }
        
        // Get Auth instance
        // attempt sign in
        // if failure, present alert to create account
        // if user continues, create account
        
        // check sign in on app lauch
        // allow user to sign out with button
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                // show account creation
                strongSelf.showCreateAccount(email: email, password: password)
                return
            }
            
            print("You have signed in")
            strongSelf.label.isHidden = true
            strongSelf.emailField.isHidden = true
            strongSelf.passwordField.isHidden = true
            strongSelf.button.isHidden = true
            
        })
    
    }
    
    func showCreateAccount(email: String, password: String) {
        let alert = UIAlertController(title: "Create Account",
                                      message: "Would you like to create an account?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue",
                                      style: .default,
                                      handler: {_ in
                                        
                                        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
                                            
                                            guard let strongSelf = self else {
                                                return
                                            }
                                            
                                            guard error == nil else {
                                                // show account creation
                                                print("Account creation failed")
                                                return
                                            }
                                            
                                            print("You have signed in")
                                            strongSelf.label.isHidden = true
                                            strongSelf.emailField.isHidden = true
                                            strongSelf.passwordField.isHidden = true
                                            strongSelf.button.isHidden = true
                                        })
        }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: {_ in
        }))
        
        present(alert, animated: true)
    }

}

