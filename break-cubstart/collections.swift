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
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.cyan.opacity(0.3))
                .padding(.horizontal, 20)
                .padding(.vertical, 40)

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(0..<24) { _ in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 60)
                }
            }
            .padding(40)
        }
        .navigationTitle("Collection")
    }
}
