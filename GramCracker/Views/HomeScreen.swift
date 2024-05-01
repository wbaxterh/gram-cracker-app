import SwiftUI

struct HomeScreen: View {
    @State private var isShowingImageUpload = false

    var body: some View {
        NavigationStack {
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
                    isShowingImageUpload = true
                    print("Upload Image for Analysis tapped")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(8)
            }
            .padding()
            .navigationTitle("Home Screen")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $isShowingImageUpload) {
                ImageUploadView()
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
