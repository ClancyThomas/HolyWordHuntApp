//
//  SearchView.swift
//  HolyWordHunt
// #5976b3 rgb(89,118,179) -- POTENTIAL COLOR
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
            
            if (totalCount != 0) {
                GroupBox(label: Label("Results", systemImage: "lightbulb")) {
                    Text("Found in: \(wordCount) verses")
                        .padding(.top, 5)
                    Text("Total: \(totalCount) verses")
                    Text("\(Double(wordCount)/Double(totalCount)*100,specifier:"%.2f")% of verses")
                        .padding(.bottom, 20)
                    HStack {
                        Button("Save") {
                            databaseWorker.insertSavedSearch(word: wordToSearch, wordCount: wordCount, totalVerseCount: totalCount, ot: oldTestament, nt: newTestament, bom: bookOfMormon, dc: doctrineAndCovenants, pgp: pearlOfGreatPrice)
                        }
                        .padding(8)
                        .background((Color(red: 179/255, green: 150/255, blue: 89/255)))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .padding(.trailing, 15)
                        .fontWeight(.bold)
                        Button("Clear") {
                            totalCount = 0
                            wordCount = 0
                            wordToSearch = ""
                            bookOfMormon = false
                            doctrineAndCovenants = false
                            pearlOfGreatPrice = false
                            oldTestament = false
                            newTestament = false
                        }
                        .padding(8)
                        .background((Color(red: 179/255, green: 150/255, blue: 89/255)))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                    }
                }
                .groupBoxStyle(GroupBoxCustom())
                .padding(.bottom, 25)
            }
            
            VStack {
                Text("Select Which Books to Search")
                    .font(.title2)
                    .fontWeight(.bold)
                Toggle(isOn: $oldTestament) {
                    Text("Old Testament").frame(width: 185)
                }
                    .toggleStyle(.button)
                    .frame(width:210)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 179/255, green: 150/255, blue: 89/255), lineWidth:2)
                    )
                    .foregroundColor(.black)
                    .padding(5)
                Toggle(isOn: $newTestament) {
                    Text("New Testament").frame(width: 185)
                }
                    .toggleStyle(.button)
                    .frame(width:210)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 179/255, green: 150/255, blue: 89/255), lineWidth:2)
                    )
                    .foregroundColor(.black)
                    .padding(5)
                Toggle(isOn: $bookOfMormon) {
                    Text("Book of Mormon").frame(width: 185)
                }
                    .toggleStyle(.button)
                    .frame(width:210)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 179/255, green: 150/255, blue: 89/255), lineWidth:2)
                    )
                    .foregroundColor(.black)
                    .padding(5)
                Toggle("Doctrine and Covenants", isOn: $doctrineAndCovenants)
                    .frame(width:210)
                    .toggleStyle(.button)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 179/255, green: 150/255, blue: 89/255), lineWidth:2)
                    )
                    .foregroundColor(.black)
                    .padding(5)
                Toggle(isOn: $pearlOfGreatPrice) {
                    Text("Pearl of Great Price").frame(width: 185)
                    }
                    .frame(width:210)
                    .toggleStyle(.button)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 179/255, green: 150/255, blue: 89/255), lineWidth:2)
                    )
                    .foregroundColor(.black)
                    .padding(5)
            } // VStack for books
    
            Button("Search Now") {
                
                wordCount = databaseWorker.queryWord(word: wordToSearch, ot: oldTestament, nt: newTestament, bom: bookOfMormon, dc: doctrineAndCovenants, pgp: pearlOfGreatPrice)
                
                totalCount = databaseWorker.queryBooks(ot: oldTestament, nt: newTestament, bom: bookOfMormon, dc: doctrineAndCovenants, pgp: pearlOfGreatPrice)
                
            }
            .buttonStyle(SearchButton())
            .padding(.top, 30)
            
        } // ScrollView
        .frame(maxWidth: .infinity)
        .overlay(NavigationBar(title: "Search"))
    
    } // Body
    
} // View

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
