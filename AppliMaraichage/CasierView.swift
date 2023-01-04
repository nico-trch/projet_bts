//
//  CasierView.swift
//  ProjetMaraicher
//
//  Created by Nicolas on 14/03/2022.
//

import SwiftUI

// MARK: - BARRE DE MENUS
struct CasierView: View {
    var body: some View {
        
            TabView() {
                
                NavigationView {
                    CasierList()
                        .navigationBarTitle("Casiers")
                }
                .tabItem { Label("État des casiers", systemImage: "square.grid.3x3") }
                
                NavigationView {
                    parametreView()
                        .navigationBarTitle("Paramètres")
                }
                .tabItem { Label("Paramètres", systemImage: "gear") }
                
            }
    }
}



// MARK: - VUE DES CASIERS
struct CasierList: View {
    
    @State var Casiers: [Casier] = []
    @EnvironmentObject var viewModel : AppViewModel
    
    var body: some View {
        ZStack {
            // Liste
            List(Casiers) { casier in
                HStack {
                    if (casier.etat == "0") {
                        Circle()
                            .fill(.green)
                            .frame(width: 30, height: 30)
                    } else {
                        Circle()
                            .fill(.red)
                            .frame(width: 30, height: 30)
                    }
                    
                    //Spacer()
                    
                    //Afficher les noms des casiers
                    Text(casier.casier)
                        .font(Font.system(.title3))
                        .bold()
                    
                    Spacer()
                    
                    VStack {
                        //Espace entre cette partie et le nom des casiers
                        Spacer()
                        
                        //Si l'état d'un casier est égal à zéro alors on affiche Casier plein
                        if (casier.etat == "0") {
                            Text("Casier plein")
                                .font(Font.system(size: 20))
                                .bold()
                        //Sinon on affiche Casier vide
                        } else {
                            Text("Casier vide")
                                .font(Font.system(size: 20))
                                .bold()
                        }
                        Spacer()
                        
                        Text("Dernière ouverture :")
                            .underline()
                        //Afficher l'horodatage des casiers
                        Text(casier.horodate)
                    }
                }
            }
                .onAppear {
                    Api().decode { (Casiers) in
                        self.Casiers = Casiers
                    }
                }
                .refreshable {
                Api().decode { (Casiers) in
                self.Casiers = Casiers
                }
            }
        }
    }
}



// MARK: - VUE DES PARAMÈTRES
struct parametreView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            List {
                // DÉCONNEXION
                Button(action: { viewModel.signOut() })
                {
                    Label("Déconnexion", systemImage: "rectangle.portrait.and.arrow.right.fill" )
                }
            
                
                // PARAMÈTRES DES NOTIFS
                Button(action: { showingSheet.toggle() })
                {
                    Label("Notifications", systemImage: "bell.badge.fill")
                }
                .sheet(isPresented: $showingSheet) {
                    parametreNotif()
                }
            }
        }
    }
}

// MARK: - PARAMÈTRES DES NOTIFCATIONS
struct parametreNotif: View {
    
    @State private var showGreeting = false
    
    var body: some View {
        VStack {
            
            Toggle("Activer les notifcations", isOn: $showGreeting)
                .padding()
            if showGreeting {
                Text("Hello World!")
            }
            
            Button("Envoyer la notif !") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default

                // AFFICHER LA NOTIFICATION DANS 5 SECONDES
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                // CHOISIR UN IDENTIFIANT AU HASARD
                let request = UNNotificationRequest(identifier: UUID().uuidString,
                                                    content: content,
                                                    trigger: trigger)

                // AJOUTER LA DEMANDE DE NOTIFICATION
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}



// MARK: - PREVIEW DE L'APPLICATION
struct CasierView_Previews: PreviewProvider {
    static var previews: some View {
        CasierView()
            .previewInterfaceOrientation(.portrait)
            //.preferredColorScheme(.dark)
    }
}
