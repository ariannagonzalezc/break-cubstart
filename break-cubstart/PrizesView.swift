//
//  ContentView.swift
//  break-cubstart
//
//  Created by Arianna Gonzalez Cisneros on 4/23/25.
//

import SwiftUI


struct PrizesView: View {
    @State private var goToNewTimer = false
    @State private var selectedBox: Int? = nil
    @State private var goToHome = false
    @State private var goToNewCollection = false
    let image = Image("smiski")

    var body: some View {
        NavigationView {
            ZStack {
                Color.teal.opacity(0.6)
                    .ignoresSafeArea()

                VStack(alignment: .center) {
                    topBar

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

                    PrizeGridView(selectedBox: $selectedBox)

                    Spacer().frame(height: 60)

                    buttonSection

                    Spacer()
                }
            }
        }
    }

    private var topBar: some View {
        HStack {
            Button(action: {
                goToHome = true
            }) {
                Image(systemName: "house.fill")
                    .font(.title)
                    .padding()
            }
            NavigationLink(destination: HomeView(), isActive: $goToHome) {
                EmptyView()
            }
            Spacer()
        }
    }

    private var buttonSection: some View {
        VStack(spacing: 12) {
            Button(action: {
                goToNewCollection = true
            }) {
                Text("View Collection")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.mint)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            NavigationLink(destination: CollectionScreen(), isActive: $goToNewCollection) {
                EmptyView()
            }

            Button(action: {
                goToNewTimer = true
            }) {
                Text("New Timer")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.mint)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }

            NavigationLink(destination: NewTimerScreen(), isActive: $goToNewTimer) {
                EmptyView()
            }
        }
        .padding(.horizontal, 60)
    }
}

struct PrizeGridView: View {
    @Binding var selectedBox: Int?

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    let boxIndices = [0, 1, 2, 3]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 70) {
            ForEach(boxIndices, id: \.self) { index in
                Button(action: {
                    if selectedBox == nil {
                        selectedBox = index
                    }
                }) {
                    Group {
                        if selectedBox == index {
                            Image("smiski")
                                .resizable()
                                .scaledToFit()
                        } else {
                            Image(systemName: "shippingbox.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.brown)
                        }
                    }
                    .frame(width: 80, height: 80)
                }
                .disabled(selectedBox != nil && selectedBox != index)
            }
        }
        .padding()
        .background(Color.cyan.opacity(0.3))
        .cornerRadius(20)
        .padding(.horizontal, 40)
        .animation(.easeInOut, value: selectedBox)
    }
}


struct NewTimerScreen: View {
    var body: some View {
        NewTimerView()
    }
}

struct CollectionScreen: View {
    var body: some View {
        CollectionView()
    }
}


struct ContentViewPreview: PreviewProvider {
    static var previews: some View {
        PrizesView()
    }
}
