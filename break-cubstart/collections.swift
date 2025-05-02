//
//  collections.swift
//  break-cubstart
//
//  Created by Emily Xu on 4/30/25.
//

import SwiftUI

struct CollectionView: View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)

    var body: some View {
        VStack(alignment: .center) {
            Spacer().frame(height: 30)

            Text("Your Collection")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 10)

            RoundedRectangle(cornerRadius: 20)
                .fill(Color.cyan.opacity(0.3))
                .overlay(
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(0..<24) { _ in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 60)
                        }
                    }
                    .padding()
                )
                .padding(.horizontal, 20)
                .padding(.vertical, 20)

            Spacer()
        }
        .navigationTitle("Collection")
    }
}

struct collectvieewreviews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}

