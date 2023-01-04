//
//  ContentView.swift
//  AppliMaraichage
//
//  Created by Nicolas on 20/04/2022.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        
        ZStack {
            
            //Si utilisateur est deja connecté
            
            if viewModel.signedIn {
                
                //On afficher CasierView
                
                CasierView()
            }
            //Sinon on affiche l'écran d'acceuil
            
            else {
                Home()
                    .preferredColorScheme(.dark)
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}



struct Home : View {
    @State var email = ""
    @State var password = ""
    @State var index = 0
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                Image("logoFestinElianLight")
                    .resizable()
                    .frame(width: 350, height: 100)
                    //.padding(.bottom, 60)
                ScrollView {
                    ZStack {
                        Inscription(index: self.$index)
                        //Changer ordre des vues ...
                            .zIndex(Double(self.index))
                        Login(index: self.$index)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 70)
                    }
            }.padding(.top, 50)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppViewModel())
            
    }
}

    


