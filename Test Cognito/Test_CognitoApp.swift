//
//  Test_CognitoApp.swift
//  Test Cognito
//
//  Created by Web Dev on 9/25/21.
//

import Amplify
import AmplifyPlugins
import SwiftUI

@main
struct Test_CognitoApp: App {
    
    @ObservedObject var sessionManager = SessionManager()
    
    init() {
        configureAmplify()
        sessionManager.getCurrentAuthUser()
    }
    
    var body: some Scene {
        WindowGroup {
            switch sessionManager.authState {
            case .login:
                LoginView()
                    .environmentObject(sessionManager)
                
            case .signUp:
                SignUpView()
                    .environmentObject(sessionManager)
                
            case .confirmCode(let username):
                ConfirmationView(username: username)
                    .environmentObject(sessionManager)
                
            case .session(let user):
                SessionView(user: user)
                    .environmentObject(sessionManager)
                
            case .resetPassword:
                ResetPasswordView()
                    .environmentObject(sessionManager)
                
            case .confirmResetPassword(username: let username):
                ConfirmResetPassword(username: username)
                    .environmentObject(sessionManager)
            }
        }
    }
    
    private func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Amplify configured successfully")
        } catch {
            print("Could not initialize Amplify", error)
        }
    }
}
