//
//  SessionManager.swift
//  Test Cognito
//
//  Created by Web Dev on 9/25/21.
//

import Amplify

enum AuthState {
    case signUp
    case login
    case confirmCode(username: String)
    case session(user: AuthUser)
    case resetPassword
    case confirmResetPassword(username: String)
}

final class SessionManager: ObservableObject {
    @Published var authState: AuthState = .login
    
    func getCurrentAuthUser() {
        if let user = Amplify.Auth.getCurrentUser() {
            authState = .session(user: user)
        } else {
            authState = .login
        }
    }
    
    func showSignUp() {
        authState = .signUp
    }
    
    func showLogin() {
        authState = .login
    }
    
    func singUp(username: String, email: String, password: String) {
        let attributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: attributes)
        
        _ = Amplify.Auth.signUp(
            username: username,
            password: password,
            options: options
        ) { [weak self] result in
            
            switch result {
            case .success(let signUpResult):
                print("Sign up result:", signUpResult)
                
                switch signUpResult.nextStep {
                case .done:
                    print("Finished Sign up")
                    
                case .confirmUser(let details, _):
                    print(details ?? "no details")
                    
                    DispatchQueue.main.sync {
                        self?.authState = .confirmCode(username: username)
                    }
                }
                
            case .failure(let error):
                print("Sign up error:", error)
            }
            
        }
    }
    
    func confirm(username: String, code: String) {
        _ = Amplify.Auth.confirmSignUp(
            for: username,
            confirmationCode: code
        ) { [weak self] result in
            
            switch result {
            case .success(let confirmResult):
                print(confirmResult)
                if confirmResult.isSignupComplete {
                    DispatchQueue.main.sync {
                        self?.showLogin()
                    }
                }
                
            case .failure(let error	):
                print("faild to confirm code: ", error)
            }
        }
    }
    
    func resendSignUpCode(username: String) {
        _ = Amplify.Auth.resendSignUpCode(for: username) { result in
            
            switch result {
            case .success(let authCodeDeliveryDetails):
                print(authCodeDeliveryDetails)
                
            case .failure(let error):
                print("failed to resend code:", error)
            }
            
        }
    }
    
    func login(username: String, password: String) {
        _ = Amplify.Auth.signIn(username: username, password: password) { [weak self] result in
            
            switch result {
            case .success(let signInResult):
                print(signInResult)
                if signInResult.isSignedIn {
                    DispatchQueue.main.sync {
                        self?.getCurrentAuthUser()
                    }
                }
                
            case .failure(let error):
                print("failed to login: ", error)
            }
        }
    }
    
    func signOut() {
        _ = Amplify.Auth.signOut() { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.sync {
                    self?.getCurrentAuthUser()
                }
            case .failure(let error):
                print("sign out error: ", error)
            }
        }
    }
    
    func showResetPassword() {
        authState = .resetPassword
    }
    
    func resetPassword(username: String) {
        _ = Amplify.Auth.resetPassword(for: username) {[weak self] result in
            do {
                let resetResult = try result.get()
                switch resetResult.nextStep {
                
                case .confirmResetPasswordWithCode(let deliveryDetails, let info):
                    print("Confirm reset password with code send to - \(deliveryDetails) \(info)")
                    DispatchQueue.main.sync {
                        self?.authState = .confirmResetPassword(username: username)
                    }
                    
                case .done:
                    print("Reset completed")
                }
            } catch {
                print("Reset password failed with error \(error)")
            }
        }
    }
    
    func confirmResetPassword(
        username: String,
        newPassword: String,
        confirmationCode: String
    ) {
        _ = Amplify.Auth.confirmResetPassword(
            for: username,
            with: newPassword,
            confirmationCode: confirmationCode
        ) {[weak self] result in
            switch result {
            case .success():
                print("Password reset confirmed")
                DispatchQueue.main.sync {
                    self?.showLogin()
                }
                
            case .failure(let error):
                print("Reset password failed with error \(error)")
            }
        }
    }
}
