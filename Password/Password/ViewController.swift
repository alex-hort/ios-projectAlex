//
//  ViewController.swift
//  Password
//
//  Created by Alexis Horteales Espinosa on 03/06/25.
//

import UIKit

class ViewController: UIViewController {
    
    typealias CustomValidation = PasswordTextField.CustomValidation
    
    let stackView = UIStackView()
    let newPasswordTextField = PasswordTextField(placeHolderText: "New password")
    let statusView = PasswordStatusView()
    
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Re-enter new password")
    
    let resetButton = UIButton(type: .system)
    
    var alert: UIAlertController? //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

extension ViewController {
    
    func setup(){
        setupNewPassword()
        setupConfirmPassword()
        setupDismissKeyboardGesture()
        setupKeyboardingHiding()
    }
    
    
    private func setupNewPassword(){
        let newPasswordValidation: CustomValidation = { text in
            //empty text
            guard let text = text, !text.isEmpty else {
                self.statusView.reset()
                return (false, "Enter your password")
            }
            
            // Valid characters
            let validChars =
            "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@?!()$\\/#"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.statusView.reset()
                return (false, "Enter valid special chars (.,@?!()$\\/#) with no spaces")
            }
            
            
            return (true, "")
        }
        newPasswordTextField.customValidation = newPasswordValidation
        newPasswordTextField.delegate = self
    }
    
    private func setupConfirmPassword() {
        let confirmPasswordValidation: CustomValidation = { text in
            guard let text = text, !text.isEmpty else {
                return (false, "Enter your password.")
            }

            guard text == self.newPasswordTextField.text else {
                return (false, "Passwords do not match.")
            }

            return (true, "")
        }

        confirmPasswordTextField.customValidation = confirmPasswordValidation
        confirmPasswordTextField.delegate = self
    }
    
    private func setupDismissKeyboardGesture(){
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer){
        view.endEditing(true) //resing firts responder
    }
    
    private func setupKeyboardingHiding(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        newPasswordTextField.delegate = self
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.layer.cornerRadius = 5
        statusView.clipsToBounds = true
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: [])
        resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetButton)
      
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
           
           
        ])
    }
}


extension ViewController: PasswordTextFieldDelegate{
   
    
    func editingChanged(_ sender: PasswordTextField){
        if sender === newPasswordTextField{
            statusView.updateDisplay(sender.textField.text ?? "")
        }
    }
    
    func editingDidEnd(_ sender: PasswordTextField) {
        if sender === newPasswordTextField {
            statusView.shouldResetCriteria = false
            _ = newPasswordTextField.validate()
        } else if sender == confirmPasswordTextField {
            _ = confirmPasswordTextField.validate()
        }
    }
}



extension ViewController{
    @objc func keyboardWillShow(sender: NSNotification){
        guard let userInfo = sender.userInfo,
                      let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
                      let currentTextField = UIResponder.currentFirst() as? UITextField else { return }

        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        if textFieldBottomY > keyboardTopY {
            // adjust view up
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
    }
    @objc func keyboardWillHide(notification: NSNotification){
        view.frame.origin.y = 0
    }
    
}


// MARK: Actions
extension ViewController {

    @objc func resetPasswordButtonTapped(sender: UIButton) {
        view.endEditing(true)

        let isValidNewPassword = newPasswordTextField.validate()
        let isValidConfirmPassword = confirmPasswordTextField.validate()

        if isValidNewPassword && isValidConfirmPassword {
            showAlert(title: "Success", message: "You have successfully changed your password.")
        }
    }

    private func showAlert(title: String, message: String) {
        alert =  UIAlertController(title: "", message: "", preferredStyle: .alert)
        guard let alert = alert else {return}
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        alert.title = title
        alert.message = message
        present(alert, animated: true, completion: nil)
    }
}

// MARK: Tests
extension ViewController {
    var newPasswordText: String? {
        get { return newPasswordTextField.text }
        set { newPasswordTextField.text = newValue}
    }
    
    var confirmPasswordText: String? {
        get { return confirmPasswordTextField.text }
        set { confirmPasswordTextField.text = newValue}
    }
}
