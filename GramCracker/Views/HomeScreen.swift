import SwiftUI

struct HomeScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var coordinator: NavigationCoordinator
    @State private var isShowingImageUpload = false
    @State private var userEmail: String = UserManager.shared.userEmail ?? "user@example.com"

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top){
                Color.bgGray
                    .edgesIgnoringSafeArea(.all)
        
                VStack(spacing: 40) {
                    // Top Box Section
                    HStack {
                        VStack(alignment: .leading) {
                            Image("userProfile") // Replace "userProfile" with your actual profile image asset name
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.appLightBrand, lineWidth: 2))
                            
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                        }
                        Text(userEmail)
                        .textContentType(.none)
                        .disabled(true)
                        .font(.system(size: 14))
                        .foregroundColor(Color.appBlack)
                        
                        Spacer()
                        
                        VStack {
                            Button(action: {
                                print("Settings tapped")
                                // Logic to navigate to settings
                            }) {
                                Image(systemName: "gear") // Settings icon
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.black)
                            }
                            Text("Account Settings")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                    }
 
                    .padding(10)
                    .background(Color.white)
                    
                    Button("Link Instagram Account") {
                        // Logic to link Instagram account
                        print("Link Instagram Account tapped")
                    }
                    .padding(.vertical, 30)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.appSecondary, Color.appBrand]), startPoint: .leading, endPoint: .trailing)
                    ) // Gradient from blue to purple
                    .font(.system(size: 24, weight: .bold))

                    Button("Complete Questionnaire") {
                        // Logic to link Instagram account
                        print("Complete Questionnaire tapped")
                    }
                    .padding(.vertical, 30)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [ Color.appLightBrand, Color.appDarkAccent]), startPoint: .leading, endPoint: .trailing)
                    ) // Gradient from blue to purple
                    .font(.system(size: 24, weight: .bold))

                    Button("Configure Preferences") {
                        // Logic to link Instagram account
                        print("Configure Preferences tapped")
                    }
                    .padding(.vertical, 30)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [ Color.appPrimary, Color.appMdBrand]), startPoint: .leading, endPoint: .trailing)
                    ) // Gradient from blue to purple
                    .font(.system(size: 24, weight: .bold))

                    
//                    Button("Upload Image for Analysis") {
//                        isShowingImageUpload = true
//                        coordinator.navigate(to: .imageUpload)
//                        print("Upload Image for Analysis tapped")
//                    }
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.green)
//                    .cornerRadius(8)
//                    
                }
                
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {
                    UserManager.shared.logOut()
                    coordinator.goBack()
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Log Out")
                    }
                })
                .navigationTitle("Home Screen")
                .navigationBarTitleDisplayMode(.inline)
                VStack{
                    Spacer()
                    BottomNavigationView(coordinator: coordinator)
                }
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(coordinator: NavigationCoordinator())
    }
}
