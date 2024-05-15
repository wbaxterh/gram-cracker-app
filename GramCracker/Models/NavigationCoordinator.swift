import SwiftUI
import Foundation

extension NavigationCoordinator.Page: Equatable {
    static func == (lhs: NavigationCoordinator.Page, rhs: NavigationCoordinator.Page) -> Bool {
        switch (lhs, rhs) {
        case (.welcome, .welcome), (.signIn, .signIn), (.homeScreen, .homeScreen), (.imageUpload, .imageUpload):
            return true
        case let (.captionView(lhsCaption), .captionView(rhsCaption)):
            return lhsCaption == rhsCaption
        default:
            return false
        }
    }
}

class NavigationCoordinator: ObservableObject {
    @Published var currentPage: Page

    enum Page {
        case welcome
        case signIn
        case homeScreen
        case imageUpload
        case register
        case captionView(caption: String)
    }


    private var pageOrder: [Page] = [
        .welcome,
        .signIn,
        .register,
        .homeScreen,
        .imageUpload,
        // CaptionView dynamically navigated to.
    ]

    init(startingPage: Page = .welcome) {
        self.currentPage = startingPage
    }

    func navigate(to page: Page) {
        currentPage = page
    }

    func goBack() {
        switch currentPage {
        case .captionView:
            print("Caption view back pressed")
            currentPage = .imageUpload  // Adjust according to your app's flow
        default:
            if let index = pageOrder.firstIndex(of: currentPage), index > 0 {
                currentPage = pageOrder[index - 1]
            }
        }
    }
}
