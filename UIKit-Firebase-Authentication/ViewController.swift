//
//  ViewController.swift
//  UIKit-Firebase-Authentication
//
//  Created by Burhan Dündar on 11.03.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var txtEmail: UITextField!
    var txtPassword: UITextField!
    var emailImageView: UIImageView!
    var passwordImageView: UIImageView!
    var eyeImageView: UIImageView!
    var loginButton: UIButton!
    var signUpButton: UIButton!
    private var isPasswordHidden: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Login"
        
        txtEmail = UITextField()
        //  frame: CGRect(x: 10, y: 100, width: UIScreen.main.bounds.size.width - 20, height: 50)
        txtEmail.translatesAutoresizingMaskIntoConstraints = false
        txtEmail.backgroundColor = .yellow
        txtEmail.borderStyle = .line
        txtEmail.keyboardAppearance = .dark
        txtEmail.keyboardType = .default
        txtEmail.placeholder = "Email"
        txtEmail.font = UIFont.systemFont(ofSize: 15.0)
        txtEmail.delegate = self
        // txtEmail.leftView = UIImageView(image: UIImage(systemName: "envelope"))
        
        emailImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 20))
        emailImageView.image = UIImage(systemName: "envelope")
        txtEmail.setupLeftImage(imageView: emailImageView)
        
        view.addSubview(txtEmail)
                
        txtPassword = UITextField()
        txtPassword.translatesAutoresizingMaskIntoConstraints = false
        txtPassword.backgroundColor = .yellow
        txtPassword.borderStyle = .line
        txtPassword.keyboardAppearance = .dark
        txtPassword.keyboardType = .default
        txtPassword.placeholder = "Password"
        txtPassword.font = UIFont.systemFont(ofSize: 15.0)
        txtPassword.delegate = self
        txtPassword.isSecureTextEntry = true
        // txtPassword.leftView = UIImageView(image: UIImage(systemName: "lock"))
        
        // This is a show-hide password action, so there is only one possibility.
        // If you want to more flexible design, seperate the imageView part
        // and add it customizable func
        
        passwordImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 20))
        passwordImageView.image = UIImage(systemName: "lock")
        
        eyeImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 20))
        eyeImageView.image = UIImage(systemName: "eye")
        
        let tapGr = UITapGestureRecognizer(target: self, action: #selector(showHidePassword))
        eyeImageView.addGestureRecognizer(tapGr)
        eyeImageView.isUserInteractionEnabled = true
        
        txtPassword.setupLeftImage(imageView: passwordImageView)
        txtPassword.setupRightImage(imageView: self.eyeImageView) // eye-eye.slash
        
        view.addSubview(txtPassword)
        
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.systemGreen, for: .normal)
        loginButton.setTitleColor(.green, for: .highlighted)
        
        view.addSubview(loginButton)
        
        signUpButton = UIButton()
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.backgroundColor = .blue
        signUpButton.addTarget(self, action: #selector(goToSignUpPage), for: .touchUpInside)
        signUpButton.setTitle("Sign Up!", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        
        view.addSubview(signUpButton)
        
        
        NSLayoutConstraint.activate([
            // txtEmail
            txtEmail.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            txtEmail.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            txtEmail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            txtEmail.heightAnchor.constraint(equalToConstant: 50),
            
            // txtPassword
            txtPassword.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            txtPassword.topAnchor.constraint(equalTo: txtEmail.bottomAnchor, constant: 50),
            txtPassword.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            txtPassword.heightAnchor.constraint(equalToConstant: 50),
            
            // Login button
            loginButton.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 50),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Sign up button
            signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 50),
            signUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func showHidePassword(_ sender: UITapGestureRecognizer){ // func içine imageView'ları alarak da deneyeceğim sonra
        self.isPasswordHidden.toggle()
        
        if(self.isPasswordHidden){
            self.eyeImageView.image = UIImage(systemName: "eye")
            self.txtPassword.setupRightImage(imageView: eyeImageView) // eye-eye.slash
            self.txtPassword.isSecureTextEntry = true
        } else {
            self.eyeImageView.image = UIImage(systemName: "eye.slash")
            self.txtPassword.setupRightImage(imageView: eyeImageView) // eye-eye.slash
            self.txtPassword.isSecureTextEntry = false
        }
    }
    
    @objc private func goToSignUpPage(_ sender: UIButton){
        let signupViewController = SignupViewController()
        navigationController?.pushViewController(signupViewController, animated: true)
    }
    
    @objc private func login(_ sender: UIButton){
        print("login to system")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension UITextField {
    
    func setupRightImage(imageView: UIImageView){
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        imageContainerView.addSubview(imageView)
        rightView = imageContainerView
        rightViewMode = .always
        self.tintColor = .lightGray
    }
    
    func setupLeftImage(imageView: UIImageView){
           let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
           imageContainerView.addSubview(imageView)
           leftView = imageContainerView
           leftViewMode = .always
           self.tintColor = .lightGray
         }
}
