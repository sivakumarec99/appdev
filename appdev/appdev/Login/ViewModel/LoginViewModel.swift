//
//  LoginViewModel.swift
//  appdev
//
//  Created by JIDTP1408 on 14/02/25.
//

import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class LoginViewModel {
    
    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.onLoginFailure?(error.localizedDescription)
                return
            }
            
            guard let user = authResult?.user, let token = user.refreshToken else {
                self.onLoginFailure?("Invalid user data.")
                return
            }

            let userId = user.uid
            let userName = user.displayName ?? "Unknown"
            let userEmail = user.email ?? ""

            // Save user details and auth token
            UserSessionManager.shared.saveUserData(userId: userId, name: userName, email: userEmail, token: token)
            
            self.onLoginSuccess?()
        }
    }
    
    func googleLogin(from viewController: UIViewController) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { result, error in
            if let error = error {
                self.onLoginFailure?(error.localizedDescription)
                return
            }

            guard let user = result?.user, let idToken = user.idToken else {
                self.onLoginFailure?("Google authentication failed.")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self.onLoginFailure?(error.localizedDescription)
                    return
                }

                guard let firebaseUser = authResult?.user, let token = firebaseUser.refreshToken else {
                    self.onLoginFailure?("Invalid Firebase user data.")
                    return
                }

                let userId = firebaseUser.uid
                let userName = firebaseUser.displayName ?? "Unknown"
                let userEmail = firebaseUser.email ?? ""

                // Save user details and auth token
                UserSessionManager.shared.saveUserData(userId: userId, name: userName, email: userEmail, token: token)
                
                self.onLoginSuccess?()
            }
        }
    }
}
