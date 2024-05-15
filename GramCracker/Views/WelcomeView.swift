import SwiftUI

struct WelcomeView: View {
    @ObservedObject var coordinator: NavigationCoordinator
    @State private var isShowingSignIn = false

    var body: some View {
        NavigationStack {
            ZStack{
                Color.bgGray
                    .ignoresSafeArea()
                VStack(spacing: 10) {
                    Image("Logos")  // Ensure this matches the exact name in your asset catalog
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 150)
                    
                    Text("Welcome to GramCracker.io")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.appBlack)
                        .padding([.bottom], 20)
                        .multilineTextAlignment(.center)
                    
                    Button("Login") {
                        isShowingSignIn = true
                        coordinator.navigate(to: .signIn)
                    }
                    .padding(12)
                    .font(.system(size: 22))
                    .frame(width: 250)
                    .foregroundColor(Color.white)
                    .background(Color.appPrimary)
                    .cornerRadius(10)
                    .padding([.bottom], 5)
                    
                    Button("Register") {
                        print("Register tapped")
                        coordinator.navigate(to: .register)
                        // Handle register action
                    }
                    .padding(12)
                    .font(.system(size: 22))
                    .frame(width: 250)
                    .foregroundColor(Color.appSecondary)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding([.bottom], 5)
                    
                    Button(action: {
                        print("Continue as guest tapped")
                        // Handle guest navigation
                    }) {
                        HStack {
                            Text("Continue as guest")
                                Image(systemName: "chevron.right")  // System-provided right arrow icon
                            }
                            .foregroundColor(.gray)
                            .font(.system(size: 18))
                        }
                    // Button styles
                    .padding()
                }
                .padding()
                
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(coordinator: NavigationCoordinator())
    }
}
