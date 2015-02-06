//
//  BooksTableViewController.swift
//  Seuss
//
//  Created by Richard Turton on 13/11/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit
import CoreData

class BooksTableViewController: UITableViewController {
    
    //MARK: Lifecycle
    
    var dataLoaded = false
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !dataLoaded {
            displayActivity(1){
                createBooks(self.coreDataStack.context)
                self.dataLoaded = true
            }
        }
    }
    
    //MARK: Fetched results
    var coreDataStack : CoreDataStack! {
        didSet {
            let resultsController = coreDataStack?.booksResultController()
            fetchedResultsDataSource = FetchedResultsDataSource()
            fetchedResultsDataSource.tableView = tableView
            fetchedResultsDataSource.resultsController = resultsController
            fetchedResultsDataSource.dequeueCell = dequeueCell
            fetchedResultsDataSource.configureCell = configureCell
            tableView.dataSource = fetchedResultsDataSource
            tableView.reloadData()
        }
    }
    
    var fetchedResultsDataSource : FetchedResultsDataSource! = nil
    
    let dequeueCell : DequeueCell = {
        (tableView: UITableView, indexPath:NSIndexPath) in
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        return cell
    }
    
    let configureCell : ConfigureCell = {
        (cell : UITableViewCell, indexPath:NSIndexPath, object:AnyObject!) in
        let bookCell = cell as? BookCell
        if let book = object as? Book {
            bookCell?.titleLabel.text = book.title
            bookCell?.yearLabel.text = "\(book.year)"
            bookCell?.coverImage.image = book.image
            bookCell?.ratingLabel.text = book.ratingString
            bookCell?.reviewField.text = book.review
        }
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath == tableView.indexPathForSelectedRow() {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            tableView.beginUpdates()
            tableView.endUpdates()
            return nil
        }
        return indexPath
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == tableView.indexPathForSelectedRow() {
            return 160.0
        } else {
            return 80.0
        }
    }
    
    // MARK: Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForCell(sender as UITableViewCell) {
                let book = fetchedResultsDataSource.resultsController!.objectAtIndexPath(indexPath) as Book
                let detailVC = segue.destinationViewController as BookDetailViewController
                detailVC.book = book
            }
        }
    }
    
    // MARK: Actions
    
    @IBAction func refresh(sender: AnyObject) {
        displayActivity(2){}
    }
    
    @IBAction func adjustRating(sender: UISegmentedControl) {
        if let indexPath = tableView.indexPathForView(sender) {
            view.endEditing(true)
            let book = fetchedResultsDataSource.resultsController!.objectAtIndexPath(indexPath) as Book
            let increment = sender.selectedSegmentIndex == 0 ? -1 : 1
            var newRating = book.rating.integerValue + increment
            newRating = max(0, newRating)
            newRating = min(5, newRating)
            book.rating = newRating
        }
    }
}

extension BooksTableViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if let indexPath = tableView.indexPathForView(textField) {
            let book = fetchedResultsDataSource.resultsController!.objectAtIndexPath(indexPath) as Book
            book.review = textField.text
        }
    }
}