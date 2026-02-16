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
    
    // Prime check 
    func isPrime(_ number: Int) -> Bool {
        if number < 2 { return false }
        if number == 2 { return true }
        if number % 2 == 0 { return false }

        let limit = Int(sqrt(Double(number)))
        for i in stride(from: 3, through: limit, by: 2) {
            if number % i == 0 { return false }
        }
        return true
    }
}

struct PrimeGameView_Previews: PreviewProvider {
    static var previews: some View {
        PrimeGameView()
    }
}