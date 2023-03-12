//
//  HomeViewController.swift
//  UIKit-Firebase-Authentication
//
//  Created by Burhan Dündar on 12.03.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Loading..."
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Home"
        view.accessibilityIdentifier = "homeVC"
        self.setupUI()
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
        
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    // MARK: - Selectors
    @objc private func didTapLogout() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                //AlertManager.showLogoutError(on: self, with: error)
                print("error",error)
                return
            } else {
                let loginVC = LoginViewController()
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
            
//            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
//                //sceneDelegate.checkAuthentication()
//                print("scene delegate")
//            }
        }
    }
    
}
