import SwiftUI

struct ImageUploadView: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplaying = false

    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300, maxHeight: 300)
                    .padding()
            } else {
                Text("Select an image to analyze")
                    .padding()
            }

            Button("Upload Image") {
                isImagePickerDisplaying = true
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .sheet(isPresented: $isImagePickerDisplaying) {
            ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
        }
    }
}

struct ImageUploadView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUploadView()
    }
}
