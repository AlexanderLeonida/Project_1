//
//  BibleViewModel.swift
//  UIKit Project
//
//  Created by Alex Leonida on 5/19/25.
//

import Foundation

// Book with a name and chapters
// Decodable for JSONDecoder
struct Book: Decodable {
    // Genesis
    let name: String
    // 3 : 24 both strings
    let chapters: [String: String]
}

class BibleViewModel: ObservableObject {
    // published to update views when books change
    // id int to sort books by id (genesis first)
    @Published var books: [(id: Int, book: Book)] = []
    
    // URL to fetch JSON data from
    // let is constant
    let url = URL(string: "https://ot-s3-tom-hamming.s3.amazonaws.com/BibleJson.json")!

    // fetch data from URL and decode it into Book objects
    func fetchBibleData() {
        // datatask make this async
        // data from URL, _ response, error is error
        URLSession.shared.dataTask(with: url) { data, _, error in
            // swift has guards
            // check if there's an error on the URLSession, if there is, print error and return
            if let data = data, error == nil {
                do {
                    // Decode JSON dictionary [String: Book]
                    // ex. "1" : Book
                    let rawBooks = try JSONDecoder().decode([String: Book].self, from: data)
                    
                    // convert dictionary key ids to int and sort
                    // ? is optional, not nullable
                    let sortedBooks = rawBooks.compactMap { (key, book) -> (Int, Book)? in
                        // here's the if let to handle hte nullable string to int conversion
                        if let id = Int(key) {
                            return (id, book)
                        } else {
                            // if we try to pass in a non number string to id, return null
                            return nil
                        }
                        // sort by first element of first tuple vs first element of second tuple.
                        // basically just sorting by id #'s.
                    }.sorted { $0.0 < $1.0 }
                    
                    // update the published books property on the main thread
                    DispatchQueue.main.async {
                        self.books = sortedBooks
                        print("book count: \(self.books.count)")
                    }
                } catch {
                    print("error: \(error)")
                }
            } else {
                print("fetch error: \(error)")
            }
        }.resume()
    }
}


