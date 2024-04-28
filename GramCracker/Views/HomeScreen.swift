import SwiftUI

struct HomeScreen: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button("Link Instagram Account") {
                    // Logic to link Instagram account
                    print("Link Instagram Account tapped")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)

                Button("Upload Image for Analysis") {
                    NavigationLink("Upload Image for Analysis", destination: ImageUploadView())

                    // Logic to upload image
                    print("Upload Image for Analysis tapped")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(8)
            }
            .navigationTitle("Home Screen")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
