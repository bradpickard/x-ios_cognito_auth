//
//  ConfirmationView.swift
//  Test Cognito
//
//  Created by Web Dev on 9/25/21.
//

import SwiftUI

struct ConfirmationView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var confirmationCode = ""
    
    let username: String
    
    var body: some View {
        VStack {
            Text("Username: \(username)")
            TextField("Confirmation Code", text: $confirmationCode	)
            Button(action: {
                sessionManager.confirm(username: username, code: confirmationCode)
            }, label: {
                Text("Confirm")
            })
            Spacer()
                .frame(height: 20)
            Button(action: {
                sessionManager.resendSignUpCode(username: username)
            }, label: {
                Text("Resend")
            })
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(username: "Kilo Loco")
    }
}
