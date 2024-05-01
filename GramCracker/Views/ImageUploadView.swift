import SwiftUI

struct ImageUploadView: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplaying = false
    @State private var uploadMessage: String = ""
    @State private var shouldUploadImage = false  // New state to track if the image should be uploaded
    @State private var showAlert = false
    @State private var alertMessage = ""

    
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
            
            Text(uploadMessage)
                .padding()
                .foregroundColor(Color.green)
            
            Button("Select Image") {
                isImagePickerDisplaying = true
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
            
            if selectedImage != nil {
                Button("Upload Image") {
                    uploadImage()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(8)
            }
        }
        .sheet(isPresented: $isImagePickerDisplaying, onDismiss: checkImageSelection) {
            ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Upload Response"),
                message: Text(alertMessage),
                dismissButton: .default(Text("Close"))
            )
        }
    }
    
    func checkImageSelection() {
        if selectedImage != nil {
            uploadMessage = "Tap 'Upload Image' to analyze the selected image."
        }
    }
    
    private func uploadImage() {
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
                if let error = error {
                    uploadMessage = "Upload failed: \(error.localizedDescription)"
                } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    uploadMessage = "Upload successful!"
                    if let responseData = data, let responseString = String(data: responseData, encoding: .utf8) {
                        alertMessage = "Response Data: \(responseString)"
                                        showAlert = true  // Show the alert when the data is received
                    }
                } else if let httpResponse = response as? HTTPURLResponse {
                    uploadMessage = "Upload failed with unexpected response: \(httpResponse.statusCode)"
                    // Log full response details
                                let statusCode = httpResponse.statusCode
                                let headers = httpResponse.allHeaderFields
                                var responseDetails = "HTTP Status Code: \(statusCode)\nHeaders: \(headers)"
                                
                                // Convert Data to a readable String format if possible
                                if let responseData = data, let responseString = String(data: responseData, encoding: .utf8) {
                                    responseDetails += "\nResponse Body: \(responseString)"
                                }
                                
                                // Update uploadMessage with the complete response details for debugging
                                uploadMessage = "Upload failed with unexpected response: \(responseDetails)"
                                
                                // Optional: log to the console
                                print("Complete HTTP Response: \(responseDetails)")
                }
            }
        }
        
        // Start the upload task
        task.resume()
    }
}

struct ImageUploadView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUploadView()
    }
}
