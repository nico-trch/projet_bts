//
//  AppViewModel.swift
//  AppliMaraichage
//
//  Created by Nicolas on 22/04/2022.
//

import Foundation
import Firebase
import Combine

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    @Published var signedIn = false
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    //Fonction CONNEXION
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                //Succès
                self?.signedIn = true
            }
        }
    }
    
    // Fonction INSCRIPTION
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                //Succès
                self?.signedIn = true
            }
        }
    }
    
    // Fonction DÉCONNEXION
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }
    
    // Fonction MOT DE PASSE OUBLIÉ
    func forgotPassword(email: String) {
        auth.sendPasswordReset(withEmail: email) { error in
          // ...
        }
    }    
}



