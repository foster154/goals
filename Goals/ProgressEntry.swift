//
//  GoalEntry.swift
//  Goals
//
//  Created by Mark F on 3/23/16.
//  Copyright © 2016 Bunk Bed Labs. All rights reserved.
//

import Foundation

class ProgressEntry {
    var text = ""
    var amount = 0.00
    var date = NSDate()
    
    class func convertStringToDateTemp(date: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yy"
        return dateFormatter.dateFromString(date)!
    }
}