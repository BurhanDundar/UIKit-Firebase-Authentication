//
//  signupViewController.swift
//  UIKit-Firebase-Authentication
//
//  Created by Burhan Dündar on 11.03.2023.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    var _txtEmail: UITextField!
    var _txtPassword: UITextField!
    var _emailImageView: UIImageView!
    var _passwordImageView: UIImageView!
    var _eyeImageView: UIImageView!
    var _loginButton: UIButton!
    var _signUpButton: UIButton!
    private var isPasswordHidden: Bool = true
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        
        navigationItem.title = "Sign Up"
        
        _txtEmail = UITextField()
        //  frame: CGRect(x: 10, y: 100, width: UIScreen.main.bounds.size.width - 20, height: 50)
        _txtEmail.translatesAutoresizingMaskIntoConstraints = false
        _txtEmail.backgroundColor = .yellow
        _txtEmail.borderStyle = .line
        _txtEmail.keyboardAppearance = .dark
        _txtEmail.keyboardType = .default
        _txtEmail.placeholder = "Email"
        _txtEmail.font = UIFont.systemFont(ofSize: 15.0)
        _txtEmail.delegate = self
        // txtEmail.leftView = UIImageView(image: UIImage(systemName: "envelope"))
        
        _emailImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 20))
        _emailImageView.image = UIImage(systemName: "envelope")
        _txtEmail.setupLeftImage(imageView: _emailImageView)
        
        view.addSubview(_txtEmail)
                
        _txtPassword = UITextField()
        _txtPassword.translatesAutoresizingMaskIntoConstraints = false
        _txtPassword.backgroundColor = .yellow
        _txtPassword.borderStyle = .line
        _txtPassword.keyboardAppearance = .dark
        _txtPassword.keyboardType = .default
        _txtPassword.placeholder = "Password"
        _txtPassword.font = UIFont.systemFont(ofSize: 15.0)
        _txtPassword.delegate = self
        _txtPassword.isSecureTextEntry = true
        // txtPassword.leftView = UIImageView(image: UIImage(systemName: "lock"))
        
        // This is a show-hide password action, so there is only one possibility.
        // If you want to more flexible design, seperate the imageView part
        // and add it customizable func
        
        _passwordImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 20))
        _passwordImageView.image = UIImage(systemName: "lock")
        
        _eyeImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 20))
        _eyeImageView.image = UIImage(systemName: "eye")
        
        let _tapGr = UITapGestureRecognizer(target: self, action: #selector(showHidePassword))
        _eyeImageView.addGestureRecognizer(_tapGr)
        _eyeImageView.isUserInteractionEnabled = true
        
        _txtPassword._setupLeftImage(imageView: _passwordImageView)
        _txtPassword._setupRightImage(imageView: self._eyeImageView) // eye-eye.slash
        
        view.addSubview(_txtPassword)
        
        _signUpButton = UIButton()
        _signUpButton.translatesAutoresizingMaskIntoConstraints = false
        _signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        _signUpButton.setTitle("Sign Up", for: .normal)
        _signUpButton.setTitleColor(.systemGreen, for: .normal)
        _signUpButton.setTitleColor(.green, for: .highlighted)
        
        view.addSubview(_signUpButton)
        
        _loginButton = UIButton()
        _loginButton.translatesAutoresizingMaskIntoConstraints = false
        _loginButton.backgroundColor = .blue
        _loginButton.addTarget(self, action: #selector(goToLoginPage), for: .touchUpInside)
        _loginButton.setTitle("Login!", for: .normal)
        _loginButton.setTitleColor(.white, for: .normal)
        
        view.addSubview(_loginButton)
        
        
        NSLayoutConstraint.activate([
            // txtEmail
            _txtEmail.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            _txtEmail.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            _txtEmail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            _txtEmail.heightAnchor.constraint(equalToConstant: 50),
            
            // txtPassword
            _txtPassword.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            _txtPassword.topAnchor.constraint(equalTo: _txtEmail.bottomAnchor, constant: 50),
            _txtPassword.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            _txtPassword.heightAnchor.constraint(equalToConstant: 50),
            
            // Login button
            _signUpButton.topAnchor.constraint(equalTo: _txtPassword.bottomAnchor, constant: 50),
            _signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Sign up button
            _loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            _loginButton.topAnchor.constraint(equalTo: _signUpButton.bottomAnchor, constant: 50),
            _loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            _loginButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func showHidePassword(_ sender: UITapGestureRecognizer){ // func içine imageView'ları alarak da deneyeceğim sonra
        self.isPasswordHidden.toggle()
        
        if(self.isPasswordHidden){
            self._eyeImageView.image = UIImage(systemName: "eye")
            self._txtPassword._setupRightImage(imageView: _eyeImageView) // eye-eye.slash
            self._txtPassword.isSecureTextEntry = true
        } else {
            self._eyeImageView.image = UIImage(systemName: "eye.slash")
            self._txtPassword._setupRightImage(imageView: _eyeImageView) // eye-eye.slash
            self._txtPassword.isSecureTextEntry = false
        }
    }
    
    @objc private func goToLoginPage(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func signUp(_ sender: UIButton){
        let email: String = self._txtEmail.text!
        let password: String = self._txtPassword.text!
        let registerUserRequest = RegisterUserRequest(
                   email: self._txtEmail.text ?? "",
                   password: self._txtPassword.text ?? ""
               )
        
        
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
                    guard let self = self else { return }
                    
                    if let error = error {
                        //AlertManager.showRegistrationErrorAlert(on: self, with: error)
                        print("error")
                        return
                    }
                    
                    if wasRegistered {
                        let homeVC = HomeViewController()
                        self.navigationController?.pushViewController(homeVC, animated: true)
                        //if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                            //sceneDelegate.checkAuthentication()
                            //print("scene delegate")
                        //}
                    } else {
                        //AlertManager.showRegistrationErrorAlert(on: self)
                        print("error", error)
                    }
                }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension UITextField {
    
    func _setupRightImage(imageView: UIImageView){
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        imageContainerView.addSubview(imageView)
        rightView = imageContainerView
        rightViewMode = .always
        self.tintColor = .lightGray
    }
    
    func _setupLeftImage(imageView: UIImageView){
           let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
           imageContainerView.addSubview(imageView)
           leftView = imageContainerView
           leftViewMode = .always
           self.tintColor = .lightGray
         }
}
