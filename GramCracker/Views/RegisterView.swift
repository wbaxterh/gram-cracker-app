//
//  RegisterView.swift
//  GramCracker
//
//  Created by Wes Huber on 5/14/24.
//

import SwiftUI
import Combine

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var coordinator: NavigationCoordinator
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var registrationFailed: Bool = false
    @State private var isAuthenticated: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.bgGray
                    .ignoresSafeArea()
                VStack(spacing: 15) {
                    Image("Logos")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 150)
                    Text("Register a new account")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.appBlack)
                        .padding([.bottom], 20)
                        .multilineTextAlignment(.center)
                    TextField("Email", text: $email)
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
                    
                    Button("Register") {
                        register()
                    }
                    .padding(12)
                    .font(.system(size: 22))
                    .frame(width: 360)
                    .foregroundColor(Color.white)
                    .background(Color.appPrimary)
                    .cornerRadius(10)
                    
                    if registrationFailed {
                        Text("Registration Failed. Please try again!")
                            .foregroundColor(Color.appDanger)
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {
                    coordinator.currentPage = .welcome
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
    
    private func register() {
        guard let url = URL(string: "https://api.gramcracker.io/users/register") else {
            print("Invalid URL")
            return
        }
        
        let userDetails = ["email": email, "password": password]
        guard let jsonData = try? JSONEncoder().encode(userDetails) else {
            print("Failed to encode user details")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    self.registrationFailed = true
                    print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                if let decodedResponse = try? JSONDecoder().decode(AuthResponse.self, from: data) {
                    UserManager.shared.userToken = decodedResponse.token
                    UserManager.shared.userEmail = self.email
                    self.isAuthenticated = true
                    coordinator.navigate(to: .homeScreen)
                    print("Registration Successful with token: \(decodedResponse.token)")
                } else {
                    self.registrationFailed = true
                    print("Invalid response from the server")
                }
            }
        }.resume()
    }
}

//struct AuthResponse: Codable {
//    var token: String
//}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(coordinator: NavigationCoordinator())
    }
}
