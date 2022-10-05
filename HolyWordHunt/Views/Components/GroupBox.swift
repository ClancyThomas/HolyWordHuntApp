//
//  GroupBox.swift
//  ScriptureWordCounter
//
//  Created by Clancy Thomas on 10/3/22.
//

import SwiftUI

// Custom group box with a colored background
struct GroupBoxCustom: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.label
                .font(.title3)
                .fontWeight(.bold)
            configuration.content
                .frame(width: 275)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(Color(red: 176/255, green: 196/255, blue: 222/255)))
    
    }
}

