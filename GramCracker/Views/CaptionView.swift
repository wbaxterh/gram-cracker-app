//
//  CaptionView.swift
//  GramCracker
//
//  Created by Wes Huber on 5/3/24.
//

import SwiftUI

struct CaptionView: View {
    var caption: String
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
                    Text(caption)
                        .padding()
                        .font(.body)
                        .multilineTextAlignment(.center)

                    Button("Copy Caption") {
                        UIPasteboard.general.string = caption
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
        .padding()
                .navigationTitle("Generated Caption")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true) // Hide the default back button
                .navigationBarItems(leading: Button("Back") {
                    // Custom action to navigate back
                    presentationMode.wrappedValue.dismiss()
                })
    }
}



//#Preview {
//    CaptionView(caption: <#T##String#>)
//}
