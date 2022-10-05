//
//  SearchButton.swift
//  HolyWordHunt
//
//  Created by Clancy Thomas on 10/2/22.
//

import SwiftUI

// Custom button with a simple animation
struct SearchButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .padding()
            .frame(width: 300, height: 60)
            .background(Color(red: 179/255, green: 150/255, blue: 89/255))
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeIn(duration: 0.1), value: 0.98)
    }
}

