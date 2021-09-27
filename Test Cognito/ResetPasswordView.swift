//
//  ResetPasswordView.swift
//  Test Cognito
//
//  Created by Web Dev on 9/26/21.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var email = ""
    
    var body: some View {
        TextField("Email", text: $email)
        
        Button(action: {
            sessionManager.resetPassword(username: email)
        }, label: {
            Text("Next")
        })
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
