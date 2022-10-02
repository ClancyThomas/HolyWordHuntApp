//
//  SearchView.swift
//  HolyWordHunt
//
//  Created by Clancy Thomas on 10/1/22.
//

import SwiftUI

// Custom button with a simple animation
struct CustomButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2)
            .fontWeight(.bold)
            .padding()
            .frame(width: 300, height: 60)
            .background(Color(red: 179/255, green: 150/255, blue: 89/255))
            .foregroundColor(.black)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeIn(duration: 0.1), value: 0.98)
    }
}

struct SearchView: View {
    
    @FocusState private var focus: Bool
    @State var wordToSearch = ""
    @State var bookOfMormon = false
    @State var doctrineAndCovenants = false
    @State var pearlOfGreatPrice = false
    @State var oldTestament = false
    @State var newTestament = false
    @State var result = 1000
    
    var databaseWorker:DatabaseWorker = DatabaseWorker()
    
    
    var body: some View {
            VStack {
                Spacer()
                VStack {
                    Text("Enter a Word")
                        .font(.title)
                        .fontWeight(.bold)
                    TextField("Required", text: $wordToSearch)
                        .textFieldStyle(.roundedBorder)
                        .frame(width:300)
                        .padding(.bottom, 50)
                        .focused($focus)
                }
                
                // VStack that contains all the scripture book options
                VStack {
                    Text("Click on Which Books to Search")
                        .font(.title2)
                        .fontWeight(.bold)
                    Toggle("Old Testament", isOn: $oldTestament)
                        .toggleStyle(.button)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 179/255, green: 150/255, blue: 89/255), lineWidth:2)
                        )
                        .padding(5)
                    Toggle("New Testament", isOn: $newTestament)
                        .toggleStyle(.button)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 179/255, green: 150/255, blue: 89/255), lineWidth:2)
                        )
                        .padding(5)
                    Toggle("Book of Mormon", isOn: $bookOfMormon)
                        .toggleStyle(.button)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 179/255, green: 150/255, blue: 89/255), lineWidth:2)
                        )
                        .padding(5)
                    Toggle("Pearl of Great Price", isOn: $pearlOfGreatPrice)
                        .toggleStyle(.button)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 179/255, green: 150/255, blue: 89/255), lineWidth:2)
                        )
                        .padding(5)
                    Toggle("Doctrine and Covenants", isOn: $doctrineAndCovenants)
                        .toggleStyle(.button)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 179/255, green: 150/255, blue: 89/255), lineWidth:2)
                        )
                        .padding(5)
                }
                
                Spacer()
                Text("Result: \(result)")
                Button("Search") {
                    result = databaseWorker.query()
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
