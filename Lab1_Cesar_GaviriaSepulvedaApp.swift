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
        ZStack {
            Color(red: 0.95, green: 0.97, blue: 0.98)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Timer 
                Text("⏱️ \(timeRemaining)s")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                    .background(
                        Capsule()
                            .fill(Color(red: 1.0, green: 0.42, blue: 0.42))
                            .shadow(color: .red.opacity(0.3), radius: 10)
                    )
                    .padding(.top, 30)

                // score tracker
                Text("Score: \(correctAnswers) / \(totalAttempts)")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color(red: 0.40, green: 0.49, blue: 0.92))
                    

                Spacer()

                // Number card
                Text("\(currentNumber)")
                    .font(.system(size: 120, weight: .heavy))
                    .foregroundColor(Color(red: 0.18, green: 0.20, blue: 0.21))
                    .frame(width: 250, height: 250)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 10)
                    )
                
                // score tracker
                Text("Score: \(correctAnswers) / \(totalAttempts)")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color(red: 0.40, green: 0.49, blue: 0.92))
                    

                Spacer()
            }
            .padding(.horizontal, 30)
        }
        .onAppear { startTimer() }
        .onDisappear { timer?.invalidate() }
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
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if canAnswer {
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    handleTimeout()
                }
            }
        }
    }
    
    func handleTimeout() {
        guard canAnswer else { return }
        canAnswer = false
    }
}

struct PrimeGameView_Previews: PreviewProvider {
    static var previews: some View {
        PrimeGameView()
    }
}