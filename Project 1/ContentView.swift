//
//  ContentView.swift
//  Project 1
//
//  Created by Alex Leonida on 5/19/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = BibleViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.books, id: \.id) { (id, book) in
                NavigationLink(destination: ChapterListView(book: book)) {
                    Text(book.name)
                }
            }
            .navigationTitle("Bible Books")
        }
        .onAppear {
            viewModel.fetchBibleData()
        }
    }
}

struct ChapterListView: View {
    let book: Book

    var body: some View {
        List(book.chapters.sorted(by: { $0.key < $1.key }), id: \.key) { chapter, verseCount in
            Text("Chapter \(chapter): \(verseCount) verses")
        }
        .navigationTitle(book.name)
    }
}


#Preview {
    ContentView()
}
