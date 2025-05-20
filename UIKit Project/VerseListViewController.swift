//
//  VerseListViewController.swift
//  UIKit Project
//
//  Created by Alex Leonida on 5/19/25.
//

import UIKit

class VerseListViewController: UITableViewController {
    // 1 for genesis, 2 for exodus etc.
    let bookId: Int
    // genesis
    let bookName: String
    // chapter number "1"
    let chapter: String
    // numbe of verses
    let verseCount: Int

    init(bookId: Int, bookName: String, chapter: String, verseCount: Int) {
        self.bookId = bookId
        self.bookName = bookName
        self.chapter = chapter
        self.verseCount = verseCount
        super.init(style: .plain)
        // set title to genesis 1
        self.title = "\(bookName) \(chapter)"
    }

    // still required
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    // one row per verse
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return verseCount
    }

    // each cell to displays chapter & verse number (ex. genesis 1:1)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let verse = indexPath.row + 1
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(bookName) \(chapter):\(verse)"
        return cell
    }

    // when the user taps a verse, take them to the app
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // verse number, + 1 bc zero indexed
        let verse = indexPath.row + 1
        // ex. should be something like olivetree://bible/1.2.3
        let urlString = "olivetree://bible/\(bookId).\(chapter).\(verse)"
        print(urlString)
        // if the Olive Tree app is installed and URL works open it
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        } else {
            // if not, print out that it's broken
            print("Something went wrong.")
        }
    }
}
