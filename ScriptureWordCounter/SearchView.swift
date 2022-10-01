//
//  SearchView.swift
//  ScriptureWordCounter
//
//  Created by Clancy Thomas on 10/1/22.
//

import SwiftUI

struct CustomButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 200, height: 50)
            .background(Color(red: 179/255, green: 150/255, blue: 89/255))
            .foregroundColor(.black)
            .fontWeight(.bold)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeIn(duration: 0.1), value: 0.98)
    }
}

struct SearchView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Search Page Here")
            Spacer()
            Button("Search") {
                // Search Action Here
            }
            .buttonStyle(CustomButton())
            Spacer()
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
