//
//  ChapterListViewController.swift
//  UIKit Project
//
//  Created by Alex Leonida on 5/19/25.
//

import UIKit

// list of chapters for a selected book
class ChapterListViewController: UITableViewController {
    
    // holds book Id for URL pass to Olive Tree url
    let bookId: Int
    // holds the book that was selected from the previous screen
    let book: Book
    
    init(book: Book, bookId: Int) {
        self.bookId = bookId
        self.book = book
        super.init(style: .plain) // superclass initializer plain table style
        self.title = book.name // set screen title to the book's name (ex. "genesis")
    }

    // this is apparently required
    required init?(coder: NSCoder) {
        fatalError("fatal error")
    }

    // returns the book's sorted chapters ["1": "31", "2": "25"]
    var sortedChapters: [(String, String)] {
        book.chapters.sorted { (Int($0.key) ?? 0) < (Int($1.key) ?? 0) }
    }

    // tells the table how many rows (chapters) to show
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedChapters.count
    }

    // creates a table cell for each chapter row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get the chapter number and verse count for this row
        let (chapter, verses) = sortedChapters[indexPath.row]

        // create a new cell with a subtitle style (title + subtitle)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)

        // set the main label to show the chapter number
        cell.textLabel?.text = "Chapter \(chapter)"

        // set the subtitle label to show how many verses are in the chapter
        cell.detailTextLabel?.text = "\(verses) verses"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let (chapter, verseCountStr) = sortedChapters[indexPath.row]
        if let verseCount = Int(verseCountStr) {
            let vc = VerseListViewController(
                bookId: bookId,
                bookName: book.name,
                chapter: chapter,
                verseCount: verseCount
            )
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
