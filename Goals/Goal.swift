//
//  Goal.swift
//  Goals
//
//  Created by Mark F on 3/26/16.
//  Copyright © 2016 Bunk Bed Labs. All rights reserved.
//

import UIKit

class Goal: NSObject, NSCoding {
    var name = ""
    var amount: Double?
    var deadline: NSDate?
    var progressEntries = [ProgressEntry]()
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as! String
        amount = aDecoder.decodeObjectForKey("Amount") as? Double
        deadline = aDecoder.decodeObjectForKey("Deadline") as? NSDate
        progressEntries = aDecoder.decodeObjectForKey("ProgressEntries") as! [ProgressEntry]
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(amount, forKey: "Amount")
        aCoder.encodeObject(deadline, forKey: "Deadline")
        aCoder.encodeObject(progressEntries, forKey: "ProgressEntries")
    }
}
