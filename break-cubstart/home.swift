import SwiftUI

//<<<<<<< HEAD
//struct home: View {
//=======
struct HomeView: View {
//>>>>>>> ab7bb0381c07b2160db44ef3678e68b65709cd5e
    @State private var isPressed = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient background
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.0)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 30) {
                    Text("Welcome")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 5)

                    Text("Tap the logo to break.")
                        .foregroundColor(.white.opacity(0.85))
                        .font(.headline)

                    // Tappable logo button
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isPressed = true
                        }
                    }) {
                        Image("Break Command in Code")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 220, height: 220)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 5, y: 5)
                            .scaleEffect(isPressed ? 0.95 : 1.0)
                    }

                    // Hidden NavigationLink triggered by `isPressed`
                    NavigationLink(destination: NewTimerView(), isActive: $isPressed) {
                        EmptyView()
                    }
                }
                .padding()
            }
        }
    }
}
#Preview {
//<<<<<<< HEAD
//    home()
//=======
//    HomeView()
//>>>>>>> ab7bb0381c07b2160db44ef3678e68b65709cd5e
}
