import SwiftUI

struct SignInView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var authenticationFailed: Bool = false
    @State private var isAuthenticated: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(5)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(5)

                Button("Sign In") {
                    signIn()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(5)
                
                if authenticationFailed {
                    Text("Incorrect Username or Password!")
                        .foregroundColor(.red)
                }
            }
            .padding()
            .navigationDestination(isPresented: $isAuthenticated) {
                HomeScreen()
            }
        }
    }
    
    private func signIn() {
        if username == "admin" && password == "Wakezeach2024!" {
            isAuthenticated = true
            print("Authentication Successful")
        } else {
            authenticationFailed = true
            print("Authentication Failed")
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
