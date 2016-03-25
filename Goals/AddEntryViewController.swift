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
}

class AddEntryViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {
    
    weak var delegate: AddEntryViewControllerDelegate?
    
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        amountField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        delegate?.addEntryViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        
        let entry = ProgressEntry()
        entry.text = textField.text
        entry.amount = Double(amountField.text!)!
        entry.date = NSDate()
        // print("Contents of the fields... Amount: \(amountField.text!), Description: \(textField.text)")
        
        delegate?.addEntryViewController(self, didFinishAddingEntry: entry)
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
