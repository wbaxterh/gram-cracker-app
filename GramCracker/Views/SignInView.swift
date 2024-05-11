import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var coordinator: NavigationCoordinator
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var authenticationFailed: Bool = false
    @State private var isAuthenticated: Bool = false

    var body: some View {
        NavigationStack {
            ZStack{
                Color.bgGray
                    .ignoresSafeArea()
                VStack(spacing: 15) {
                    Image("Logos")  // Ensure this matches the exact name in your asset catalog
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 150)
                    Text("Login to your account")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding([.bottom], 20)
                        .multilineTextAlignment(.center)
                    TextField("Email", text: $username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    Button("Login") {
                        signIn()
                    }
                    .padding(12)
                    .font(.system(size: 22))
                    .frame(width: 360)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    if authenticationFailed {
                        Text("Incorrect Username or Password!")
                            .foregroundColor(.red)
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {
                    //                            self.presentationMode.wrappedValue.dismiss()
                    coordinator.goBack()
                    
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Back")
                    }
                })
                .padding()
                //            .navigationDestination(isPresented: $isAuthenticated) {
                //                HomeScreen()
                //            }
            }
        }
    }
    
    private func signIn() {
        if username == "admin" && password == "Wakezeach2024!" {
            isAuthenticated = true
            coordinator.navigate(to: .homeScreen)
            print("Authentication Successful")
        } else {
            authenticationFailed = true
            print("Authentication Failed")
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(coordinator: NavigationCoordinator())
    }
}
