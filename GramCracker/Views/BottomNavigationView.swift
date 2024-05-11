import SwiftUI

struct BottomNavigationView: View {
    @ObservedObject var coordinator: NavigationCoordinator
    var body: some View {
        HStack {
            // User profile button
            Button(action: {
                print("User Profile tapped")
                // Add navigation logic or action
                coordinator.navigate(to: .homeScreen)  // Example navigation

            }) {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            .frame(maxWidth: .infinity)

            // Main action button
            Button(action: {
                print("Main action tapped")
                // Add main action logic
                coordinator.navigate(to: .imageUpload)
                
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.blue)  // Primary color
                    .padding(.bottom, 50)  // Offset to the top
            }
            .frame(maxWidth: .infinity)

            // Hamburger menu button
            Button(action: {
                print("Menu tapped")
                // Add menu navigation logic or action
            }) {
                Image(systemName: "list.bullet")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 70)  // Set the height of the navigation bar
        .background(Color.white)  // Light background color
        .edgesIgnoringSafeArea(.bottom)  // Extend to the bottom edge of the screen
    }
}

struct BottomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigationView(coordinator: NavigationCoordinator())
    }
}
