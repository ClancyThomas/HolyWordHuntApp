//
//  NavigationBar.swift
//  HolyWordHunt
//
//  Created by Clancy Thomas on 10/2/22.
//

import SwiftUI

struct NavigationBar: View {
    
    var title: String
    
    var body: some View {
        ZStack {
            
            Color.clear
                .background(Color(red: 179/255, green: 150/255, blue: 89/255))
            
            HStack{
                
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 5)
                
            }
            
        } // ZStack
        .frame(height: 50)
        .frame(maxHeight: .infinity, alignment: .top)
            
    } // Body
} // View

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(title: "Hello")
    }
}
