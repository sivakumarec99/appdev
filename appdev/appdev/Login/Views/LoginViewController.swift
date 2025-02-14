//
//  LoginViewController.swift
//  appdev
//
//  Created by JIDTP1408 on 11/02/25.
//
import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {

    private let viewModel = LoginViewModel()
        
    // MARK: - UI Components

        private let backgroundImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "backgroundImage"))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()

        private let gradientView: UIView = {
            let view = UIView()
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.blue.withAlphaComponent(0.6).cgColor, UIColor.red.cgColor]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            view.layer.insertSublayer(gradientLayer, at: 0)
            return view
        }()

        private let logoImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "logo"))
            imageView.contentMode = .scaleAspectFit
            imageView.alpha = 0
            return imageView
        }()

        private let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Welcome Back"
            label.font = UIFont.boldSystemFont(ofSize: 28)
            label.textAlignment = .center
            label.textColor = .white
            label.alpha = 0
            return label
        }()

        private let emailTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Email"
            textField.borderStyle = .roundedRect
            textField.keyboardType = .emailAddress
            textField.alpha = 0
            return textField
        }()

        private let passwordTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Password"
            textField.borderStyle = .roundedRect
            textField.isSecureTextEntry = true
            textField.alpha = 0
            return textField
        }()

    @objc private let loginButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Login", for: .normal)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 10
            button.alpha = 0
            return button
        }()

        private let googleLoginButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Sign in with Google", for: .normal)
            button.backgroundColor = .red
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 10
            button.alpha = 0
            return button
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            animateUI()
            BtnActions()
            setupViewModel()
        }

        private func setupUI() {
            view.addSubview(backgroundImageView)
            view.addSubview(gradientView)
            view.addSubview(logoImageView)
            view.addSubview(titleLabel)
            view.addSubview(emailTextField)
            view.addSubview(passwordTextField)
            view.addSubview(loginButton)
            view.addSubview(googleLoginButton)
            
            backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
            gradientView.translatesAutoresizingMaskIntoConstraints = false
            logoImageView.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            emailTextField.translatesAutoresizingMaskIntoConstraints = false
            passwordTextField.translatesAutoresizingMaskIntoConstraints = false
            loginButton.translatesAutoresizingMaskIntoConstraints = false
            googleLoginButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                // Background
                backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

                gradientView.topAnchor.constraint(equalTo: view.topAnchor),
                gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

                // Logo
                logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
                logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                logoImageView.widthAnchor.constraint(equalToConstant: 100),
                logoImageView.heightAnchor.constraint(equalToConstant: 100),

                // Title
                titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

                // Fields & Buttons
                emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
                emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emailTextField.widthAnchor.constraint(equalToConstant: 280),
                emailTextField.heightAnchor.constraint(equalToConstant: 50),

                passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
                passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
                passwordTextField.heightAnchor.constraint(equalToConstant: 50),

                loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
                loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loginButton.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
                loginButton.heightAnchor.constraint(equalToConstant: 50),

                googleLoginButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
                googleLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                googleLoginButton.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
                googleLoginButton.heightAnchor.constraint(equalToConstant: 50),
            ])
            
            // Ensure gradient covers the full screen
            DispatchQueue.main.async {
                self.gradientView.layer.sublayers?.first?.frame = self.gradientView.bounds
            }
        }

        private func animateUI() {
            UIView.animate(withDuration: 1.0, delay: 0.2, options: .curveEaseOut, animations: {
                self.logoImageView.alpha = 1
                self.logoImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { _ in
                UIView.animate(withDuration: 0.5) {
                    self.logoImageView.transform = .identity
                }
            }

            UIView.animate(withDuration: 1.0, delay: 0.4, options: .curveEaseOut, animations: {
                self.titleLabel.alpha = 1
            })

            UIView.animate(withDuration: 1.0, delay: 0.6, options: .curveEaseOut, animations: {
                self.emailTextField.alpha = 1
            })

            UIView.animate(withDuration: 1.0, delay: 0.8, options: .curveEaseOut, animations: {
                self.passwordTextField.alpha = 1
            })

            UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseOut, animations: {
                self.loginButton.alpha = 1
            })

            UIView.animate(withDuration: 1.0, delay: 1.2, options: .curveEaseOut, animations: {
                self.googleLoginButton.alpha = 1
            })
        }
    private func setupViewModel() {
        viewModel.onLoginSuccess = {
            
            self.navigate(to: CustomTabBarController(), presentationStyle: .present(.fullScreen))
            
            print("Login Successful!")
        }
        viewModel.onLoginFailure = { error in
            print("Error: \(error)")
        }
    }
    
    //Buttons
    
    func BtnActions(){
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        googleLoginButton.addTarget(self, action: #selector(googleLoginTapped), for: .touchUpInside)

    }
    

    @objc private func loginTapped() {
        viewModel.login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    @objc private func googleLoginTapped() {
        viewModel.googleLogin(from: self)
    }
}
