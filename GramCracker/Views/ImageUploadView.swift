import SwiftUI

import Foundation

struct ImageAnalysisResponse: Decodable {
    var labels: [Label]
    var caption: String

    struct Label: Decodable {
        var Name: String
        var Confidence: Double
    }
}
struct ImageUploadView: View {
    @ObservedObject var coordinator: NavigationCoordinator
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplaying = false
    @State private var uploadMessage: String = ""
    @State private var shouldUploadImage = false  // New state to track if the image should be uploaded
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var caption: String? = nil // Ensure this is an optional
    @State private var navigateToCaptionView = false
    @State private var selectedCaption: String?
    @State private var showCaptionView = false
    @State private var isLoading = false  // Track loading state



    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .center){
                Color.bgGray
                .edgesIgnoringSafeArea(.all)
                VStack (spacing: 20) {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300, maxHeight: 300)
                            .padding()
                    } else {
//                        Text("Caption Generator")
//                            .padding()
                        Button("Select Image") {
                            isImagePickerDisplaying = true
                        }
                        .padding()
                        .font(.system(size: 24))
                        .frame(width: 300, height: 300) // Adjust the size as needed
                        .foregroundColor(.blue) // Text color
                        .overlay(
                            RoundedRectangle(cornerRadius: 8) // Apply a corner radius as needed
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [10])) // This creates the dotted line effect
                                .foregroundColor(.blue)
                        )
                        .cornerRadius(8)
                    }
                    
                    
//                    Text(uploadMessage)
//                        .foregroundColor(Color.green)
                    
                    Button(action: {
                        if selectedImage != nil {
                            uploadImage()
                        }
                    }) {
                        HStack {
                            Image(systemName: "gear") // Use the gear icon from SF Symbols
                                .foregroundColor(.white) // Set the color of the icon
                            Text("Generate Captions")
                        }
                    }
                        .padding()
                        .frame(maxWidth: 300)
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .background(Color.appSecondary)
                        .cornerRadius(8)
                    if isLoading {
                                        ProgressView() // Or replace with your custom GIF loader view
                                            .scaleEffect(1.5, anchor: .center)
                                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {
                    // Call goBack on the coordinator
                    coordinator.goBack()
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Back")
                    }
                })
                .sheet(isPresented: $isImagePickerDisplaying, onDismiss: checkImageSelection) {
                    ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
                }
                VStack{
                    Spacer()
                    BottomNavigationView(coordinator: coordinator)
                }
            }
           
        }
    }


            func checkImageSelection() {
                if selectedImage != nil {
                    uploadMessage = "Tap 'Upload Image' to analyze the selected image."
                }
            }

    
    private func uploadImage() {
        isLoading = true  // Start loading
        guard let selectedImage = selectedImage,
              let imageData = selectedImage.jpegData(compressionQuality: 0.9) else {
            uploadMessage = "Image is not available or cannot be converted to JPEG."
            return
        }
        
        // Check if the imageData size exceeds 100MB
        if imageData.count > 100 * 1024 * 1024 {
            uploadMessage = "Image size should be less than 100MB."
            return
        }
        
        // Prepare URL
        let url = URL(string: "https://api.gramcracker.io/analyze-image")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        // Start Boundary
        let startBoundary = "--\(boundary)\r\n"
        body.append(Data(startBoundary.utf8))

        // Content-Disposition
        let contentDisposition = "Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n"
        body.append(Data(contentDisposition.utf8))

        // Content-Type
        let contentType = "Content-Type: image/jpeg\r\n\r\n"
        body.append(Data(contentType.utf8))

        // Image Data
        body.append(imageData)

        // New Line after data
        let newLine = "\r\n"
        body.append(Data(newLine.utf8))

        // End Boundary
        let endBoundary = "--\(boundary)--\r\n"
        body.append(Data(endBoundary.utf8))

        
        // Create the upload task
        let task = URLSession.shared.uploadTask(with: request, from: body) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false  // Stop loading
                if let error = error {
                                    self.uploadMessage = "Upload failed: \(error.localizedDescription)"
                                } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                                    self.navigateToCaptionView = true  // Trigger navigation
                                    self.uploadMessage = "Upload successful!"
                                    if let responseData = data {
                                                            let decoder = JSONDecoder()
                                                            do {
                                                                let analysisResponse = try decoder.decode(ImageAnalysisResponse.self, from: responseData)
                                                                self.caption = analysisResponse.caption // Update caption to trigger navigation
                                                                self.uploadMessage = "Upload successful!"
                                                                print("Caption set successfully: \(self.caption ?? "No Caption")")
                                                                // Navigate using the coordinator
                                                                self.coordinator.navigate(to: .captionView(caption: analysisResponse.caption))
                                                            } catch {
                                                                self.uploadMessage = "Failed to decode the response"
                                                                print("Decoding error: \(error.localizedDescription)")
                                                            }
                                                        }
                                } else if let httpResponse = response as? HTTPURLResponse {
                                    self.uploadMessage = "Upload failed with unexpected response: \(httpResponse.statusCode)"
                                }
                            
            }
        }
        
        // Start the upload task
        task.resume()
    }
}

struct ImageUploadView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUploadView(coordinator: NavigationCoordinator())
    }
}
