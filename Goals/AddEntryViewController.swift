//
//  AddEntryViewController.swift
//  Goals
//
//  Created by Mark F on 3/24/16.
//  Copyright © 2016 Bunk Bed Labs. All rights reserved.
//

import Foundation
import UIKit

protocol AddEntryViewControllerDelegate: class {
    func addEntryViewControllerDidCancel(controller: AddEntryViewController)
    func addEntryViewController(controller: AddEntryViewController, didFinishAddingEntry entry: ProgressEntry)
    func addEntryViewController(controller: AddEntryViewController, didFinishEditingEntry entry: ProgressEntry)
}

class AddEntryViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {
    
    weak var delegate: AddEntryViewControllerDelegate?
    var entryToEdit: ProgressEntry?
    
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        amountField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        if let entry = entryToEdit {
            title = "Edit Entry"
            amountField.text = String(entry.amount)
            textField.text = entry.text
            doneBarButton.enabled = true
        }
    }
    
    @IBAction func cancel() {
        delegate?.addEntryViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        
        if let entry = entryToEdit {
            entry.amount = Double(amountField.text!)!
            entry.text = textField.text
            delegate?.addEntryViewController(self, didFinishEditingEntry: entry)
        } else {
            let entry = ProgressEntry()
            entry.text = textField.text
            entry.amount = Double(amountField.text!)!
            entry.date = NSDate()
            delegate?.addEntryViewController(self, didFinishAddingEntry: entry)
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    //Enable Done bar button if amount changes
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

        let oldAmount: NSString = amountField.text!
        let newAmount: NSString = oldAmount.stringByReplacingCharactersInRange(range, withString: string)
        
        doneBarButton.enabled = (newAmount.length > 0)
        
        return true
    }
    
    //Enable Done bar button if description changes
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        let oldDescription: NSString = textField.text!
        let newDescription: NSString = oldDescription.stringByReplacingCharactersInRange(range, withString: text)
        
        doneBarButton.enabled = (newDescription.length > 0)
        
        return true
    }
    
}
