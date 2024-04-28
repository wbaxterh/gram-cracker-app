import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("Logos")  // Replace "logo" with the actual name of your logo image in your assets
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Text("Welcome to GramCracker.io")
                .font(.title)
                .fontWeight(.bold)

            Button(action: {
                print("Sign In tapped")
                // Handle sign in action
            }) {
                Text("Sign In")
                    .fontWeight(.semibold)
                    .frame(minWidth: 100, maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: {
                print("Register tapped")
                // Handle register action
            }) {
                Text("Register")
                    .fontWeight(.semibold)
                    .frame(minWidth: 100, maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
