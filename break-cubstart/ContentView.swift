//
//  ContentView.swift
//  break-cubstart
//
//  Created by Arianna Gonzalez Cisneros on 4/23/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.teal.opacity(0.6)
                .ignoresSafeArea() // Extend the color to fill the entire screen

            VStack(alignment: .center) {
                // Top-left home icon
                HStack {
                    Image(systemName: "house.fill")
                        .font(.title)
                        .padding()
                    Spacer()
                }

                Spacer().frame(height: 10)

                // Title
                Text("Get Your Reward!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white) // Optional: to make it visible on teal
                    .padding(.bottom, 20)

                // Blue reward box
                VStack(spacing: 16) {
                    Text("Timer Complete!")
                        .font(.headline)
                        .fontWeight(.bold)

                    Text("Choose your prize")
                        .font(.subheadline)

                    // Grid of boxes
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(0..<4) { _ in
                            Image(systemName: "shippingbox.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .foregroundColor(.brown)
                        }
                    }
                }
                .padding()
                .background(Color.cyan.opacity(0.3))
                .cornerRadius(20)
                .padding(.horizontal)

                Spacer().frame(height: 30)

                // Buttons
                VStack(spacing: 12) {
                    Button(action: {
                        // Handle view collection
                    }) {
                        Text("View Collection")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.mint.opacity(1))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }

                    Button(action: {
                        // Handle new timer
                    }) {
                        Text("New Timer")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.mint.opacity(1))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                }
                .padding(.horizontal, 60)

                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
