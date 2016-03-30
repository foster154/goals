//
//  GoalDetailViewController.swift
//  Goals
//
//  Created by Mark F on 3/26/16.
//  Copyright © 2016 Bunk Bed Labs. All rights reserved.
//

import UIKit

protocol GoalDetailViewControllerDelegate: class {
    func goalDetailViewControllerDidCancel(controller: GoalDetailViewController)
    func goalDetailViewController(controller: GoalDetailViewController, didFinishAddingGoal goal: Goal)
    func goalDetailViewController(controller: GoalDetailViewController, didFinishEditingGoal goal: Goal)
}

class GoalDetailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var goalTitleField: UITextField!
    @IBOutlet weak var goalAmountField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: GoalDetailViewControllerDelegate?

    var goalToEdit: Goal?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let goal = goalToEdit {
            title = "Edit Goal"
            goalTitleField.text = goal.name
            doneBarButton.enabled = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        goalTitleField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        delegate?.goalDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let goal = goalToEdit {
            goal.name = goalTitleField.text!
            goal.amount = Double(goalAmountField.text!)!
            delegate?.goalDetailViewController(self, didFinishEditingGoal: goal)
        } else {
            let goal = Goal(name: goalTitleField.text!)
            goal.amount = Double(goalAmountField.text!)!
            delegate?.goalDetailViewController(self, didFinishAddingGoal: goal)
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = goalTitleField.text!
        //print(oldText)
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        //print(newText)
        doneBarButton.enabled = (newText.length > 0)
        return true
    }
}
