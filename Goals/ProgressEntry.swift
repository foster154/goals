//
//  GoalEntry.swift
//  Goals
//
//  Created by Mark F on 3/23/16.
//  Copyright © 2016 Bunk Bed Labs. All rights reserved.
//

import Foundation

class ProgressEntry: NSObject, NSCoding {
    var text = ""
    var amount = 0.00
    var date = NSDate()
    
    class func convertStringToDateTemp(date: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yy"
        return dateFormatter.dateFromString(date)!
    }
    
    // for saving Progress Entries to file
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeObject(amount, forKey: "Amount")
        aCoder.encodeObject(date, forKey: "Date")
    }
    
    // init function if creating Progress Entry objects from the saved file
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("Text") as! String
        amount = aDecoder.decodeObjectForKey("Amount") as! Double
        date = aDecoder.decodeObjectForKey("Date") as! NSDate
        super.init()
    }
    
    override init() {
        super.init()
    }
}