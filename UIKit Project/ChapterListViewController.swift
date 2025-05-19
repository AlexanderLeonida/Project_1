//
//  ChapterListViewController.swift
//  UIKit Project
//
//  Created by Alex Leonida on 5/19/25.
//

import UIKit

// list of chapters for a selected book
class ChapterListViewController: UITableViewController {
    
    // holds the book that was selected from the previous screen
    let book: Book
    
    init(book: Book) {
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
        return book.chapters.sorted { $0.key < $1.key }
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
}
