//
//  LoginView.swift
//  Test Cognito
//
//  Created by Web Dev on 9/25/21.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var username = ""
//    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            Spacer()
            TextField("Username", text: $username)
//            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button(action: {
                sessionManager.login(username: username, password: password)
            }, label: {
                Text("Login")
            })
            
            Spacer()
            Button(action: {
                sessionManager.showResetPassword()
            }, label: {
                Text("Forgot password")
            })
            Button(action: sessionManager.showSignUp, label: {
                Text("Don't have an account. Sign Up")
            })
            
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
