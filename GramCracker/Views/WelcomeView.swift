import SwiftUI

struct WelcomeView: View {
    @State private var isShowingSignIn = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image("Logos")  // Ensure this matches the exact name in your asset catalog
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                Text("Welcome to GramCracker.io")
                    .font(.title)
                    .fontWeight(.bold)

                Button("Sign In") {
                    isShowingSignIn = true
                }
                .padding()
                .frame(width: 250)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)

                Button("Register") {
                    print("Register tapped")
                    // Handle register action
                }
                .padding()
                .frame(width: 250)
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(10)
            }
            .padding()
            .navigationDestination(isPresented: $isShowingSignIn) {
                SignInView()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
