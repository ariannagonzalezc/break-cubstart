//
//  timer.swift
//  break-cubstart
//
//  Created by Emily Xu on 4/30/25.
//

import SwiftUI

struct NewTimerView: View {
    @State var selectedMinutes = 25.0
    @State var timeRemaining = 25 * 60
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var isActive = false
    @State var showResetConfirmation = false
    @State var showTimeSelection = false
    @State var navigate = false;
    @State private var showPrizeView = false
    @Environment (\.scenePhase) var ScenePhase
    @State private var appState: String = "Active"
    
    
    
    
    var totalTime: Int {
        Int(selectedMinutes) * 60
    }
    
    var body: some View {
        VStack {
            Text("App State: \(appState)")
                .onChange(of: ScenePhase) { newPhase in
                    switch newPhase {
                    case .active:
                        appState = "active"
                        navigate = true
                        
                    case .inactive:
                        appState = "Inactive"
                        NavigationLink(destination: puzzleUIView(timeRemaining: TimeInterval(timeRemaining)), isActive: $navigate) {
                            EmptyView()
                            
                        }

                    case .background:
                        appState = "Background"
                        
                    }
                }
        }
        if (navigate) {
            NavigationLink(destination: puzzleUIView(timeRemaining: TimeInterval(timeRemaining)), isActive: $navigate) {
                EmptyView()
                
            }
        }
    
            
        NavigationView {
            VStack {
                // Time selection controls
                if showTimeSelection {
                    VStack {
                        Text("Set Timer: \(Int(selectedMinutes)) min")
                            .font(.headline)
                        
                        Slider(value: $selectedMinutes, in: 1...60, step: 1)
                            .onChange(of: selectedMinutes) { newValue in
                            stopTimer()
                        }
                            .padding(.horizontal)
                            .accentColor(.red)
                        
                        Button("Apply") {
                            timeRemaining = totalTime
                            showTimeSelection = false
                            isActive = true
                            
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.bottom)
                    }
                    .transition(.move(edge: .top))
                }
                
                // Centered progress indicator with timer
                Spacer()
                
                ZStack {
                    // Background circle
                    Circle()
                        .stroke(lineWidth: 10)
                        .opacity(0.3)
                        .foregroundColor(.gray)
                    
                    // Progress arc
                    Circle()
                        .trim(from: 0.0, to: CGFloat(1 - Double(timeRemaining) / Double(totalTime)))
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.green)
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear, value: timeRemaining)
                    
                    // Centered timer text
                    VStack {
                        Text("Progress")
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        Text(timeString(time: timeRemaining))
                            .font(.system(size: 48, weight: .bold, design: .default))
                    }
                }
                .frame(width: 250, height: 250)
                
                Spacer()
                
                // Break button
                Button(action: {
                        breakAction()
                        navigate = true }) {
                           Text("break ();")
                               .font(.title2)
                               .fontWeight(.semibold)
                               .foregroundColor(.white)
                               .frame(width: 200, height: 50)
                               .background(Color.blue)
                               .cornerRadius(10)
                           }
                NavigationLink(destination: puzzleUIView(timeRemaining: TimeInterval(timeRemaining)), isActive: $navigate) {
                    EmptyView()
                    
                }
                .onDisappear {

                
                }
//                .onAppear {
//                    updateCountdown()
//                }
//<<<<<<< HEAD
//=======
                NavigationLink(destination: PrizesView(), isActive: $showPrizeView) {
                    EmptyView()
                    
                }
//>>>>>>> ab7bb0381c07b2160db44ef3678e68b65709cd5e
                .padding()
                // Reset button and confirmation
                
                
                VStack {
                    if showResetConfirmation {
                        Text("Do you want to reset?")
                            .font(.headline)
                            .padding(.bottom, 8)
                            .transition(.opacity)
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                resetTimer()
                                showResetConfirmation = false
                            }) {
                                Text("Yes")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(8)
                            }
                            
                            Button(action: {
                                withAnimation {
                                    showResetConfirmation = false
                                }
                            }) {
                                Text("No")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(8)
                            }
                        }
                    } else {
                        HStack(spacing: 20) {
                            Button(action: {
                                withAnimation {
                                    showTimeSelection.toggle()
                                }
                            }) {
                                Text("Set Time")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(height: 50)
                                    .padding(.horizontal)
                                    .background(Color.gray)
                                    .cornerRadius(10)
//                                isActive = false
                            }
                            
                            Button(action: {
                                withAnimation {
                                    showResetConfirmation = true
                                }
                            }) {
                                Text("Reset")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(height: 50)
                                    .padding(.horizontal)
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding(.bottom, 30)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .onReceive(timer) { _ in
                if isActive && timeRemaining > 0 {
                    timeRemaining -= 1
                } else if timeRemaining == 0 {
                    isActive = false
                    showPrizeView = true
                }
            }
            .onAppear {
                timeRemaining = totalTime
                isActive = true
            }
            .animation(.easeInOut, value: showTimeSelection)

        }
    }
    
    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func breakAction() {
//        isActive.toggle()
        stopTimer()
    }
    
    func resetTimer() {
        timeRemaining = totalTime
        isActive = true
    }
    func stopTimer() {
        timeRemaining = totalTime
        isActive = false
    }
//    func startTimer() {
//        stopTimer()
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//            if isActive && timeRemaining > 0 {
//                timeRemaining -= 1
//            } else {
//                stopTimer()
//            }
//        }
//    }
}

struct NewTimerView_Previews: PreviewProvider {
    static var previews: some View {
        NewTimerView()
    }
}
