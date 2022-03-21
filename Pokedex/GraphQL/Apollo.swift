//
//  Apollo.swift
//  Pokedex
//
//  Created by Edson Lipa on 21/03/22.
//

import Foundation
import Apollo

class Network {
    static let shared  = Network()
    lazy var apollo = ApolloClient(url: URL(string: "https://dex-server.herokuapp.com/")!)
}
