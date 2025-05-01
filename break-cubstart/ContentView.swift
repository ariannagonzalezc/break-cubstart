//
//  ContentView.swift
//  break-cubstart
//
//  Created by Arianna Gonzalez Cisneros on 4/23/25.
//

import SwiftUI

struct ContentView: View {
    @State private var goToNewTimer = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.teal.opacity(0.6)
                    .ignoresSafeArea()

                VStack(alignment: .center) {
                    HStack {
                        Button(action: {
                        }) {
                            Image(systemName: "house.fill")
                                .font(.title)
                                .padding()
                            Spacer()
                        }
                    }

                    Spacer().frame(height: 30)

                    Text("Timer Complete!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 10)

                    Text("Choose Your Prize :)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.bottom, 40)

                    VStack {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 70) {
                            ForEach(0..<4) { _ in
                                Button(action: {
                                }) {
                                    Image(systemName: "shippingbox.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(.brown)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.cyan.opacity(0.3))
                    .cornerRadius(20)
                    .padding(.horizontal, 40)

                    Spacer().frame(height: 60)

                    VStack(spacing: 12) {
                        Button(action: {
                        }) {
                            Text("View Collection")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.mint.opacity(1))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }

                        Button(action: {
                            goToNewTimer = true
                        }) {
                            Text("New Timer")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.mint.opacity(1))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }

                        NavigationLink(destination: NewTimerView(), isActive: $goToNewTimer) {
                            EmptyView()
                        }
                    }
                    .padding(.horizontal, 60)

                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
