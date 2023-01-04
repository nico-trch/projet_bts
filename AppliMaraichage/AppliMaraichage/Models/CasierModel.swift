//
//  CasierModel.swift
//  ProjetMaraicher
//
//  Created by Nicolas on 14/03/2022.
//


import Foundation

struct Casier: Codable, Identifiable {
    let id = UUID()
    var casier: String
    var etat: String
    var horodate: String
}


class Api {
    func decode(completion: @escaping ([Casier]) -> ()) {
        guard let url = URL(string:
            "http://172.16.99.2/projetmaraicher/API2/index2") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let infocasier = try! JSONDecoder().decode([Casier].self, from: data!)
            
            DispatchQueue.main.async {
                completion(infocasier)
            }
        }
        .resume()
    }
}



