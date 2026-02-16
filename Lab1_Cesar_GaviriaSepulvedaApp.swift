//
//  Lab1_Cesar_GaviriaSepulvedaApp.swift
//  ID: 101521980
//  Prime Number Game
//  Created on Feb 16, 2026
//

import SwiftUI

@main
struct Lab1_Cesar_GaviriaSepulvedaApp: App {
    var body: some Scene {
        WindowGroup {
            PrimeGameView()
        }
    }
}

struct PrimeGameView: View {
    var body: some View {
        Text("Prime Number Game")
            .font(.largeTitle)
    }
}

struct PrimeGameView_Previews: PreviewProvider {
    static var previews: some View {
        PrimeGameView()
    }
}