import SwiftUI

class AppViewModel: ObservableObject {
    @Published var currentPage: Page = .welcome

    enum Page {
        case welcome
        case signIn
        case home
        case imageUpload
        case captionView
    }
}
