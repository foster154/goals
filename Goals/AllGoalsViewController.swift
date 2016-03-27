//
//  AllGoalsViewController.swift
//  Goals
//
//  Created by Mark F on 3/26/16.
//  Copyright © 2016 Bunk Bed Labs. All rights reserved.
//

import UIKit

class AllGoalsViewController: UITableViewController, GoalDetailViewControllerDelegate {
    
    var goals: [Goal]
    
    required init?(coder aDecoder: NSCoder) {
        goals = [Goal]()
        super.init(coder: aDecoder)
        
        var goal = Goal(name: "Mountain Bike 200mi")
        goals.append(goal)
        
        goal = Goal(name: "Study iOS 300h")
        goals.append(goal)
        
        goal = Goal(name: "Read 18 books")
        goals.append(goal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // ## Instead of using a prototype cell, we are creating the cells in code.
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let cell = cellForTableView(tableView)
        let goal = goals[indexPath.row]
        cell.textLabel!.text = goal.name
        return cell
    }
    
    func cellForTableView(tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "Cell"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let goal = goals[indexPath.row]
        performSegueWithIdentifier("ShowProgress", sender: goal)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowProgress" {
            let controller = segue.destinationViewController as! ProgressViewController
            controller.goal = sender as! Goal
        } else if segue.identifier == "AddGoal" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! GoalDetailViewController
            controller.delegate = self
            controller.goalToEdit = nil
        }
    }
    
    func goalDetailViewControllerDidCancel(controller: GoalDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func goalDetailViewController(controller: GoalDetailViewController, didFinishAddingGoal goal: Goal) {
        let newRowIndex = goals.count
        goals.append(goal)
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func goalDetailViewController(controller: GoalDetailViewController, didFinishEditingGoal goal: Goal) {
        if let index = goals.indexOf(goal) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                cell.textLabel!.text = goal.name
            }
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        goals.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    


}
