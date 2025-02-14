//
//  AuthServices.swift
//  appdev
//
//  Created by JIDTP1408 on 14/02/25.
//

import Foundation

import FirebaseAuth
import GoogleSignIn
import FirebaseCore

class AuthService {
    
    static let shared = AuthService()
    
    private init() {}

    // MARK: - Email/Password Authentication

    func loginUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let result = result {
                completion(.success(result))
            }
        }
    }

    func registerUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let result = result {
                completion(.success(result))
            }
        }
    }
    
    // MARK: - Google Sign-In
    
    func googleSignIn(viewController: UIViewController, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { result, error in
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                completion(.failure(error ?? NSError(domain: "GoogleSignIn", code: -1, userInfo: nil)))
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                } else if let authResult = authResult {
                    completion(.success(authResult))
                }
            }
        }
    }
}
