//
//  puzzleUIView.swift
//  break-cubstart
//
//  Created by Emily Xu on 4/30/25.
//

import SwiftUI

struct puzzleUIView: View {
    let mainCode = """
    def double(x):
        return 2 * x
    def square(f):
        return lambda x: f(x) * f(x)
    def inc(f):
        return lambda x: f(x + 1)
    def triple(f):
        return lambda x: f(f(f(x)))
    def put(x):
        return lambda f: f(x)
    
    one = put(1)
    triple(print)(5)
    """
    
    let allQuestions = [
        (
            question: "What is displayed by the last line?",
            answer: "5\nNone\nNone",
            explanation: "The triple function applies print three times to 5. First print(5) displays 5 and returns None. Then print(None) displays None and returns None. Finally print(None) displays None again."
        ),
        (
            question: "What would be displayed by evaluating print(one(square(double)))",
            answer: "4",
            explanation: "one(1) applies square(double) to 1. double(1) returns 2, then square returns 2*2 = 4."
        ),
        (
            question: "What would be displayed by evaluating print(inc(put)(1)(triple(double)))",
            answer: "16",
            explanation: "inc(put)(1) becomes put(2). Then triple(double) applied to 2: double(2)=4, double(4)=8, double(8)=16."
        )
    ]
    
    @State private var currentQuestionIndex = Int.random(in: 0..<3)
    @State private var userAnswer = ""
    @State private var feedback = ""
    @State private var showCorrectAnswer = false
    @State private var showNewQuestionButton = false
    @State private var isShowingFullScreenCover = true
    @State var navigate = false

    
    var body: some View {
        VStack(spacing: 20) {
            // Main code display
            Group {
                Text("61A sp25 midterm 1")
                    .font(.title)
                    .padding(.top)
                
                Text(mainCode)
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            
            // Current question display
            VStack(alignment: .leading, spacing: 15) {
                Text("Question:")
                    .font(.headline)
                
                Text(allQuestions[currentQuestionIndex].question)
                    .font(.body)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadius(8)
                
                TextField("Your answer", text: $userAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                if showCorrectAnswer {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Correct answer:")
                            .font(.subheadline)
                        Text(allQuestions[currentQuestionIndex].answer)
                            .foregroundColor(.green)
                            .fontWeight(.semibold)
                        Text(allQuestions[currentQuestionIndex].explanation)
                            .font(.caption)
                            .scaledToFill()
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                Text(feedback)
                    .foregroundColor(feedback == "Correct!" ? .green : .red)
                    .fontWeight(.medium)
            }
            .padding(.horizontal)
            
            // Action buttons
            HStack(spacing: 20) {
                Button(action: checkAnswer) {
                    Text("Submit Answer")
                        .frame(minWidth: 120)
                }
                .buttonStyle(.borderedProminent)
                .disabled(userAnswer.isEmpty)
                
                NavigationStack {
                    if showNewQuestionButton {
                        Button(action:  {
                            navigate = true
                            
                        }) {
                            Text("Continue")
                                .frame(minWidth: 120)
                        }
                        .fullScreenCover(isPresented: $navigate) {
                            PrizesView()
                        }
//                        NavigationLink(destination: ContentView(), isActive: $navigate) {
//                            EmptyView()
//                        }
                    }
                }
            }
            .padding(.bottom)
            
            Spacer()
        }
    }
    
    func checkAnswer() {
        let correctAnswer = allQuestions[currentQuestionIndex].answer
        if userAnswer.trimmingCharacters(in: .whitespacesAndNewlines) == correctAnswer {
            feedback = "Correct!"
        } else {
            feedback = "Better Luck Next Time!"
        }
        showCorrectAnswer = true
        showNewQuestionButton = true
        
    }
    
    func newRandomQuestion() {
        var newIndex = currentQuestionIndex
        while newIndex == currentQuestionIndex {  // Ensure we get a different question
            newIndex = Int.random(in: 0..<allQuestions.count)
        }
        currentQuestionIndex = newIndex
        userAnswer = ""
        feedback = ""
        showCorrectAnswer = false
        showNewQuestionButton = false
    }
}

struct puzzleUIView_Previews: PreviewProvider {
    static var previews: some View {
        puzzleUIView()
    }
}
