//
//  ViewController.swift
//  Goals
//
//  Created by Mark F on 3/22/16.
//  Copyright © 2016 Bunk Bed Labs. All rights reserved.
//

import UIKit

class ProgressViewController: UITableViewController, EntryDetailViewControllerDelegate {
    
    var progressEntries: [ProgressEntry]
    let dateFormatter = NSDateFormatter()
    
    required init?(coder aDecoder: NSCoder) {
        progressEntries = [ProgressEntry]()
        super.init(coder: aDecoder)
        loadProgressEntries()
        
//        print("Documents folder is \(documentsDirectory())")
//        print("Data file path is \(dataFilePath())")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return progressEntries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GoalEntry", forIndexPath: indexPath)
        let progressEntry = progressEntries[indexPath.row]
        configureTextForCell(cell, withProgressEntry: progressEntry)
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        progressEntries.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        saveProgressEntries()
    }
    
    func configureTextForCell(cell: UITableViewCell, withProgressEntry entry: ProgressEntry) {
        let textLabel = cell.viewWithTag(1000) as! UILabel
        let amountLabel = cell.viewWithTag(1001) as! UILabel
        let dateLabel = cell.viewWithTag(1002) as! UILabel
        textLabel.text = entry.text
        amountLabel.text = String(entry.amount)
        dateFormatter.dateFormat = "dd MMM yy"
        dateLabel.text = dateFormatter.stringFromDate(entry.date)
    }

    func entryDetailViewControllerDidCancel(controller: EntryDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func entryDetailViewController(controller: EntryDetailViewController, didFinishAddingEntry entry: ProgressEntry) {
        
        let newRowIndex = progressEntries.count
        progressEntries.append(entry)
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        dismissViewControllerAnimated(true, completion: nil)
        saveProgressEntries()
    }
    
    func entryDetailViewController(controller: EntryDetailViewController, didFinishEditingEntry entry: ProgressEntry) {
        if let index = progressEntries.indexOf(entry) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                configureTextForCell(cell, withProgressEntry: entry)
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
        saveProgressEntries()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddEntry" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! EntryDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditEntry" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! EntryDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.entryToEdit = progressEntries[indexPath.row]
            }
        }
    }
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return (documentsDirectory() as NSString).stringByAppendingPathComponent("Checklists.plist")
    }
    
    func saveProgressEntries() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(progressEntries, forKey: "ProgressEntries")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadProgressEntries() {
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                progressEntries = unarchiver.decodeObjectForKey("ProgressEntries") as! [ProgressEntry]
                unarchiver.finishDecoding()
            }
        }
    }
}














