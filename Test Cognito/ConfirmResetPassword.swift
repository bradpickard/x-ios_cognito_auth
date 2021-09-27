//
//  ConfirmResetPassword.swift
//  Test Cognito
//
//  Created by Web Dev on 9/26/21.
//

import SwiftUI

struct ConfirmResetPassword: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var confirmationCode = ""
    @State var newPassword = ""
    
    let username: String
    
    var body: some View {
        VStack {
            Text("Username: \(username)")
            SecureField("New Password", text: $newPassword)
            TextField("Confirmation Code", text: $confirmationCode)
            Button(action: {
                sessionManager.confirmResetPassword(username: username, newPassword: newPassword, confirmationCode: confirmationCode)
            }, label: {
                Text("Confirm")
            })
            Spacer()
                .frame(height: 20)
//            Button(action: {
//                sessionManager.resendResetPasswordCode()
//            }, label: {
//                Text("Resend")
//            })
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ConfirmResetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmResetPassword(username: "Kola")
    }
}
