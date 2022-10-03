//
//  SearchView.swift
//  HolyWordHunt
//
//  Created by Clancy Thomas on 10/1/22.
//

import SwiftUI



struct SearchView: View {
    
    @FocusState private var focus: Bool
    @State var wordToSearch = ""
    @State var bookOfMormon = false
    @State var doctrineAndCovenants = false
    @State var pearlOfGreatPrice = false
    @State var oldTestament = false
    @State var newTestament = false
    @State var wordCount = 0
    @State var totalCount = 0
    @State var percentage = 0.00
    
    var databaseWorker:DatabaseWorker = DatabaseWorker()
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            TextField("Enter a word or phrase", text: $wordToSearch)
                .frame(width:275)
                .padding(.all, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 179/255, green: 150/255, blue: 89/255), lineWidth:4)
                )
                .background((Color(red: 240/255, green: 240/255, blue: 240/255)))
                .padding(.bottom, 30)
                .padding(.top, 100)
                .focused($focus)
            
            if (wordCount != 0 && totalCount != 0) {
                Text("Total verses: \(totalCount)")
                Text("Found in: \(wordCount) verses")
                Text("\(round((Double(wordCount)/Double(totalCount))*100),specifier:"%.2f")% of verses")
                        .padding(.bottom, 30)
            }
            
                VStack {
                    Text("Select Which Books to Search")
                        .font(.title2)
                        .fontWeight(.bold)
                    Toggle("Old Testament", isOn: $oldTestament)
                        .toggleStyle(.button)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 179/255, green: 150/255, blue: 89/255), lineWidth:2)
                        )
                        .foregroundColor(.black)
                        .padding(5)
                    Toggle("New Testament", isOn: $newTestament)
                        .toggleStyle(.button)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 179/255, green: 150/255, blue: 89/255), lineWidth:2)
                        )
                        .foregroundColor(.black)
                        .padding(5)
                    Toggle("Book of Mormon", isOn: $bookOfMormon)
                        .toggleStyle(.button)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 179/255, green: 150/255, blue: 89/255), lineWidth:2)
                        )
                        .foregroundColor(.black)
                        .padding(5)
                    Toggle("Pearl of Great Price", isOn: $pearlOfGreatPrice)
                        .toggleStyle(.button)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 179/255, green: 150/255, blue: 89/255), lineWidth:2)
                        )
                        .foregroundColor(.black)
                        .padding(5)
                    Toggle("Doctrine and Covenants", isOn: $doctrineAndCovenants)
                        .toggleStyle(.button)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 179/255, green: 150/255, blue: 89/255), lineWidth:2)
                        )
                        .foregroundColor(.black)
                        .padding(5)
                } // VStack for books
    
            Button("Search Now") {
                wordCount = databaseWorker.queryWord(word: wordToSearch)
                totalCount = databaseWorker.queryAll()
            }
            .buttonStyle(SearchButton())
            .padding(.top, 30)
        } // ScrollView
        .frame(maxWidth: .infinity)
        .overlay(
            NavigationBar()
        )
    } // Body
} // View

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
