//
//  BibleBooksViewController.swift
//  UIKit Project
//
//  Created by Alex Leonida on 5/19/25.
//

//
//  BibleBooksViewController.swift
//  UIKit Project
//
//  Created by Alex Leonida on 5/19/25.
//

import UIKit
// subscription = link between data source & data for updates
import Combine

class BibleBooksViewController: UITableViewController {
    
    // holds list of tuples (id, book)
    let viewModel = BibleViewModel()
    
    // set of Combine cancellables for lifecycle of subscriptions @Published in BibleViewModel
    // AnyCancelable from Combine
    private var cancellables = Set<AnyCancellable>()

    // called after the view has been loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bible Books"
        // default UITableViewCell type
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // get data from URL
        viewModel.fetchBibleData()
        // updates the table view when the books list changes
        viewModel.$books
            .sink { [weak self] _ in
                // changes happen on the main thread
                DispatchQueue.main.async {
                    // wwhen books change, reload the table to show the updated list
                    self?.tableView.reloadData()
                }
            }
            // keep subscription alive
            .store(in: &cancellables)
    }

    // how many rows to show (one per book)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.books.count
    }

    // what to show in each row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // (id, book) tuple for the current row
        let (id, book) = viewModel.books[indexPath.row]
        // Dequeue a reusable cell
        // Reuse a cell or make a new one
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // show name of book in cell
        cell.textLabel?.text = book.name
        
        return cell
    }

    // called when the user taps a book in the list
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // get selected book
        let (_, book) = viewModel.books[indexPath.row]
        // ChapterListViewController to show the chapters of the selected book
        let vc = ChapterListViewController(book: book)
        // show new screen
        navigationController?.pushViewController(vc, animated: true)
    }
}
