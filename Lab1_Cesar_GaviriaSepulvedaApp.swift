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
    
    // state
    @State private var currentNumber = 67
    @State private var correctAnswers = 0
    @State private var wrongAnswers = 0
    @State private var totalAttempts = 0
    @State private var timeRemaining = 5
    @State private var userFeedback = ""
    @State private var canAnswer = true
    @State private var showDialog = false
    @State private var timer: Timer?

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