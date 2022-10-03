//
//  NavigationBar.swift
//  HolyWordHunt
//
//  Created by Clancy Thomas on 10/2/22.
//

import SwiftUI

struct NavigationBar: View {
    
    
    var body: some View {
        ZStack {
            Color.clear
                .background(Color(red: 179/255, green: 150/255, blue: 89/255))
            HStack{
                Text("Search")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 5)
            }
        }
        .frame(height: 50)
        .frame(maxHeight: .infinity, alignment: .top)
            
        
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
