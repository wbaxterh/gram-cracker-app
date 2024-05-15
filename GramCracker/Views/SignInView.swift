import SwiftUI
import Combine

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var coordinator: NavigationCoordinator
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var authenticationFailed: Bool = false
    @State private var isAuthenticated: Bool = false
    @State private var token: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color.bgGray
                    .ignoresSafeArea()
                VStack(spacing: 15) {
                    // UI Elements as before
                    Image("Logos")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 350, height: 150)
                                        Text("Login to your account")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.appBlack)
                                            .padding([.bottom], 20)
                                            .multilineTextAlignment(.center)
                    TextField("Email", text: $username)
                                            .padding()
                                            .background(Color.formWhite)
                                            .foregroundColor(Color.appBlack)
                                            .cornerRadius(10)
                                            .autocapitalization(.none)
                                            .disableAutocorrection(true)
                    
                                        SecureField("Password", text: $password)
                                            .padding()
                                            .background(Color.formWhite)
                                            .cornerRadius(10)
                    
                                        Button("Login") {
                                            signIn()
                                        }
                                        .padding(12)
                                        .font(.system(size: 22))
                                        .frame(width: 360)
                                        .foregroundColor(Color.white)
                                        .background(Color.appPrimary)
                                        .cornerRadius(10)
                    
                    if authenticationFailed {
                        Text("Incorrect Username or Password!")
                            .foregroundColor(Color.appDanger)
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {
                    coordinator.goBack()
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Back")
                    }
                })
                .padding()
            }
        }
    }
    
    private func signIn() {
        guard let url = URL(string: "https://api.gramcracker.io/users/login") else {
            print("Invalid URL")
            return
        }
        
        let credentials = ["email": username, "password": password]
        guard let jsonData = try? JSONEncoder().encode(credentials) else {
            print("Failed to encode credentials")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    self.authenticationFailed = true
                    print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                if let decodedResponse = try? JSONDecoder().decode(AuthResponse.self, from: data) {
                    UserManager.shared.userToken = decodedResponse.token
                    UserManager.shared.userEmail = self.username
                    self.isAuthenticated = true
                    coordinator.navigate(to: .homeScreen)
                    print("Authentication Successful with token: \(decodedResponse.token)")
                } else {
                    self.authenticationFailed = true
                    print("Invalid response from the server")
                }
            }
        }.resume()
    }
}

struct AuthResponse: Codable {
    var token: String
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(coordinator: NavigationCoordinator())
    }
}




//import SwiftUI
//
//struct SignInView: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @ObservedObject var coordinator: NavigationCoordinator
//    @State private var username: String = ""
//    @State private var password: String = ""
//    @State private var authenticationFailed: Bool = false
//    @State private var isAuthenticated: Bool = false
//
//    var body: some View {
//        NavigationStack {
//            ZStack{
//                Color.bgGray
//                    .ignoresSafeArea()
//                VStack(spacing: 15) {
//                    Image("Logos")  // Ensure this matches the exact name in your asset catalog
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 350, height: 150)
//                    Text("Login to your account")
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.appBlack)
//                        .padding([.bottom], 20)
//                        .multilineTextAlignment(.center)
//                    TextField("Email", text: $username)
//                        .padding()
//                        .background(Color.formWhite)
//                        .foregroundColor(Color.appBlack)
//                        .cornerRadius(10)
//                        .autocapitalization(.none)
//                        .disableAutocorrection(true)
//                    
//                    SecureField("Password", text: $password)
//                        .padding()
//                        .background(Color.formWhite)
//                        .cornerRadius(10)
//                    
//                    Button("Login") {
//                        signIn()
//                    }
//                    .padding(12)
//                    .font(.system(size: 22))
//                    .frame(width: 360)
//                    .foregroundColor(Color.white)
//                    .background(Color.appPrimary)
//                    .cornerRadius(10)
//                    
//                    if authenticationFailed {
//                        Text("Incorrect Username or Password!")
//                            .foregroundColor(Color.appDanger)
//                    }
//                }
//                .navigationBarBackButtonHidden(true)
//                .navigationBarItems(leading: Button(action: {
//                    //                            self.presentationMode.wrappedValue.dismiss()
//                    coordinator.goBack()
//                    
//                }) {
//                    HStack {
//                        Image(systemName: "arrow.left")
//                        Text("Back")
//                    }
//                })
//                .padding()
//                //            .navigationDestination(isPresented: $isAuthenticated) {
//                //                HomeScreen()
//                //            }
//            }
//        }
//    }
//    
//    private func signIn() {
//        if username == "admin" && password == "Wakezeach2024!" {
//            isAuthenticated = true
//            coordinator.navigate(to: .homeScreen)
//            print("Authentication Successful")
//        } else {
//            authenticationFailed = true
//            print("Authentication Failed")
//        }
//    }
//}
//
//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView(coordinator: NavigationCoordinator())
//    }
//}
