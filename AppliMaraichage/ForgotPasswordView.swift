//
//  ForgotPasswordView.swift
//  AppliMaraichage
//
//  Created by Nicolas on 08/06/2022.
//

import SwiftUI
import Firebase

struct ForgotPasswordView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @State var email = ""
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 16) {
                
                Text("Une fois le bouton cliqué, un e-mail permettant de réinitialiser le mot de passe vous sera envoyé (pensez à vérifier les spams)")
                    .multilineTextAlignment(.center)
                
                
                
                HStack(spacing: 15){
                    
                    Image(systemName: "envelope.fill")
                        .foregroundColor(Color("Color1"))
                    TextField("Adresse e-mail", text: self.$email)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.vertical, 30)
                
                Button(action: {
                    guard !email.isEmpty else {
                        return
                    }
                    viewModel.forgotPassword(email: email)
                }) {
                    Text("Envoyer")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .padding(.horizontal, 50)
                        .background(Color("Color1"))
                        .clipShape(Capsule())
                        // shadow...
                        .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                }
                Spacer()
            }
            .padding(.horizontal, 15)
            
            
        }.navigationTitle("Mot de passe oublié")
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
