import SwiftUI

struct CaptionView: View {
    var caption: String
    @ObservedObject var coordinator: NavigationCoordinator
    @Environment(\.presentationMode) var presentationMode
    @State private var showToast = false // State to manage toast visibility

    
    // Parse the caption into separate sections
    var captions: [String] {
        // Adjust regex to match your pattern, ensuring it handles each new entry correctly
        print("Raw caption", caption)
        let splitPattern = "\\d+:\\s" //"\n\n(\\d+):"
        return splitString(usingRegex: splitPattern)
    }
    
    
    var body: some View {
        ZStack(alignment: .top){
            Color.bgGray
                .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                    ForEach(captions, id: \.self) { captionPart in
                        HStack {
                            Text(captionPart.trimmingCharacters(in: .whitespacesAndNewlines))
                                .padding()
                                .font(.body)  // Adjust font size as needed
                                .background(Color.gray.opacity(0.2)) // Light grey background
                                .cornerRadius(8)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity) // Expand to fill the available width
                            
                            
                            Spacer()
                            
                            Button(action: {
                                UIPasteboard.general.string = captionPart
                                showToast = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    showToast = false
                                }
                                print("Copied caption: \(captionPart)")
                            }) {
                                Image(systemName: "doc.on.doc")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                    } // end Hstack
                    Spacer()
                    BottomNavigationView(coordinator: coordinator)
            } // end scrollview
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toast(isShowing: $showToast, text: Text("Copied!"))
            
            
           
        } //end zstack
        .navigationTitle("Generated Captions")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            // Log navigation action
            print("Navigating back using coordinator")
            coordinator.goBack()
        }) {
            HStack {
                Image(systemName: "arrow.left")
                Text("Back")
            }
        })
    } // end view
    
    func splitString(usingRegex pattern: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let nsrange = NSRange(caption.startIndex..., in: caption)
            let matches = regex.matches(in: caption, options: [], range: nsrange)
            
            var parts = [String]()
            var start = caption.startIndex
            for match in matches {
                let range = Range(match.range, in: caption)!
                let part = String(caption[start..<range.lowerBound]).trimmingCharacters(in: .whitespacesAndNewlines)
                if !part.isEmpty {
                    parts.append(part)
                }
                start = range.upperBound
            }
            // Handle the last segment after the last match
            if start < caption.endIndex {
                let lastPart = String(caption[start...]).trimmingCharacters(in: .whitespacesAndNewlines)
                if !lastPart.isEmpty {
                    parts.append(lastPart)
                }
            }
            
            return parts
        } catch {
            print("Regex error: \(error.localizedDescription)")
            return []
        }
    }
}

// Toast view modifier
struct Toast: ViewModifier {
    @Binding var isShowing: Bool
    let text: Text

    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                text
                    .padding()
                    .background(Color.secondary)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.5), value: isShowing)
            }
        }
    }
}

// Helper extension to easily add toast messages to any view
extension View {
    func toast(isShowing: Binding<Bool>, text: Text) -> some View {
        self.modifier(Toast(isShowing: isShowing, text: text))
    }
}

struct CaptionView_Previews: PreviewProvider {
    static var previews: some View {
        CaptionView(caption: "\n\n1: A beautiful sunset over the hills. #sunset #nature\n\n2: A lone tree in a vast field, under the clear blue sky. #nature #beauty\n\n3: A starry night with a clear view of the Milky Way. #stars #night", coordinator: NavigationCoordinator())
    }
}
