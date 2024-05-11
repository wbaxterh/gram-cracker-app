import SwiftUI

struct HomeScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var coordinator: NavigationCoordinator
    @State private var isShowingImageUpload = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top){
                Color.bgGray
                    .edgesIgnoringSafeArea(.all)
        
                VStack(spacing: 20) {
                    // Top Box Section
                    HStack {
                        VStack(alignment: .leading) {
                            Image("userProfile") // Replace "userProfile" with your actual profile image asset name
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.black, lineWidth: 2))
                            
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                        }
                        Text("user@example.com") // Replace with dynamic email
                        
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
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                    
                    Button("Upload Image for Analysis") {
                        isShowingImageUpload = true
                        coordinator.navigate(to: .imageUpload)
                        print("Upload Image for Analysis tapped")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(8)
                    Spacer()
                    BottomNavigationView(coordinator: coordinator)
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
                .navigationTitle("Home Screen")
                .navigationBarTitleDisplayMode(.inline)
            }

        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(coordinator: NavigationCoordinator())
    }
}
