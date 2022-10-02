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
                .background(.white)
            Text("Search")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 5)
                .padding(.top, 20)
        }
        .frame(height: 60)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
