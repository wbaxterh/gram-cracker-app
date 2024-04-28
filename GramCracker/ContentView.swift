//
//  ContentView.swift
//  GramCracker
//
//  Created by Wes Huber on 4/28/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("HelloWorld")
            .padding()  // Adds some padding around the text for better UI appearance
            .font(.title)  // Sets the font style to title for better visibility
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
