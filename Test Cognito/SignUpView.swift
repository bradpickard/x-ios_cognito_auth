//
//  SignUpView.swift
//  Test Cognito
//
//  Created by Web Dev on 9/25/21.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var username = ""
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            Spacer()
            TextField("Username", text: $username)
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button(action: {
                sessionManager.singUp(username: username, email: email, password: password)
            }, label: {
                Text("Sign Up")
            })
            
            Spacer()
            Button(action: {
                sessionManager.showLogin()
            }, label: {
                Text("Already have an account. Login")
            })
            
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
