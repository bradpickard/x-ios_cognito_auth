//
//  SessionView.swift
//  Test Cognito
//
//  Created by Web Dev on 9/25/21.
//

import Amplify
import SwiftUI

struct SessionView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    let user: AuthUser
    
    var body: some View {
        VStack {
            Spacer()
            Text("You signed in as \(user.username) using Amplify!!")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Spacer()
            Button(action: sessionManager.signOut, label: {
                Text("Sign Out")
            })
        }
        .padding(.trailing)
    }
}

struct SessionView_Previews: PreviewProvider {
    private struct DummyUser: AuthUser {
        let userId: String = "1"
        let username: String = "dummy"
    }
    
    static var previews: some View {
        SessionView(user: DummyUser())
    }
}
