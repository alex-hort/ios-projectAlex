//
//  LoginView.swift
//  Bankey
//
//  Created by Alexis Horteales Espinosa on 26/04/25.
//

import Foundation
import UIKit

class LoginView: UIView{
    
    let stackView = UIStackView()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let divider = UIView()
    
    override init(frame: CGRect) {
           super.init(frame: frame)
    
           style()
           layout()
       }
    
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
     
}

extension LoginView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        ///usernametextfield
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Username"
        usernameTextField.delegate = self
        
        ///passwordTextfield
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        passwordTextField.enablePasswordToggle()
        
        ///divider view
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .secondarySystemFill
        
        ///cornerRadius layer
        layer.cornerRadius = 5
        clipsToBounds = true
    }
 
    func layout() {
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(divider)
        stackView.addArrangedSubview(passwordTextField)
        addSubview(stackView)
       
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ])
        
        ///constraint to divider view
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
 
    }
}


//Mark: UITextFieldDelegate

extension LoginView: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

