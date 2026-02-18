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
    let primaryColor = Color(red: 0.40, green: 0.49, blue: 0.92)
    let successColor = Color(red: 0.0, green: 0.72, blue: 0.58)
    let dangerColor = Color(red: 1.0, green: 0.42, blue: 0.42)
    
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
                Text(" \(timeRemaining)s")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                    .background(Capsule().fill(Color(red: 1.0, green: 0.42, blue: 0.42)))

                Text("Score: \(correctAnswers) / \(totalAttempts)")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color(red: 0.40, green: 0.49, blue: 0.92))
                    
                Group {
                    if userFeedback == "correct" {
                        Image(systemName: "checkmark")
                            .font(.system(size: 80, weight: .bold))
                            .foregroundColor(Color(red: 0.0, green: 0.72, blue: 0.58))
                    } else if userFeedback == "wrong" {
                        Image(systemName: "xmark")
                            .font(.system(size: 80, weight: .bold))
                            .foregroundColor(Color(red: 1.0, green: 0.42, blue: 0.42))
                    }
                }
                .frame(height: 100)

                Spacer()

                Text("\(currentNumber)")
                    .font(.system(size: 120, weight: .heavy))
                    .foregroundColor(Color(red: 0.18, green: 0.20, blue: 0.21))
                    .frame(width: 250, height: 250)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))

                HStack(spacing: 20) {
                    gameButton("PRIME") { checkAnswer(userSaysPrime: true) }
                    gameButton("NOT PRIME") { checkAnswer(userSaysPrime: false) }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)

                HStack(spacing: 15) {
                    scoreCard("Correct", correctAnswers, Color(red: 0.0, green: 0.72, blue: 0.58))
                    scoreCard("Wrong", wrongAnswers, Color(red: 1.0, green: 0.42, blue: 0.42))
                    scoreCard("Total", totalAttempts, Color(red: 0.40, green: 0.49, blue: 0.92))
                }
                .padding(.horizontal, 10)

                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .onAppear { startGame() }
        .alert("Game Over", isPresented: $showDialog) {
            Button("Restart") {
                startGame()
                showDialog = false
            }
        } message: {
            Text("Correct: \(correctAnswers)\\nWrong: \(wrongAnswers)\\nTotal: \(totalAttempts)")
        }
    }
    .onDisappear { timer?.invalidate() }
    }
    
    func gameButton(_ label: String, _ action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Capsule().fill(Color(red: 0.40, green: 0.49, blue: 0.92)))
        }
    }
    
    func scoreCard(_ title: String, _ value: Int, _ color: Color) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)
            Text("\(value)")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
    }
    
    // Optimized prime number checking using sqrt limit
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
    
    // Initialize new game round
    func startGame() {
        currentNumber = Int.random(in: 2...100)
        correctAnswers = 0
        wrongAnswers = 0
        totalAttempts = 0
        timeRemaining = 5
        canAnswer = true
        startTimer()
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if canAnswer && timeRemaining > 0 {
                timeRemaining -= 1
            } else if timeRemaining == 0 && canAnswer {
                handleTimeout()
            }
        }
    }
    
    func checkAnswer(userSaysPrime: Bool) {
        let isPrimeNumber = isPrime(currentNumber)
        let isCorrect = userSaysPrime == isPrimeNumber
        updateScore(correct: isCorrect)
    }
    
    func updateScore(correct: Bool) {
        canAnswer = false
                withAnimation(.easeInOut(duration: 0.3)) {
            userFeedback = correct ? "correct" : "wrong"
        }
        correctAnswers += correct ? 1 : 0
        wrongAnswers += correct ? 0 : 1
        totalAttempts += 1
        
        if totalAttempts >= 10 {
            showDialog = true
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                resetRound()
            }
        }
    }
    
    func resetRound() {
        currentNumber = Int.random(in: 2...100)
        timeRemaining = 5
        userFeedback = ""
        canAnswer = true
        startTimer()
    }
    
    func handleTimeout() {
        canAnswer = false
        userFeedback = "wrong"
        wrongAnswers += 1
        totalAttempts += 1
        
        if totalAttempts >= 10 {
            showDialog = true
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                resetRound()
            }
        }
    }
}

struct PrimeGameView_Previews: PreviewProvider {
    static var previews: some View {
        PrimeGameView()
    }
}