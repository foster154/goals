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
    var progressEntries = [ProgressEntry]()
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as! String
        progressEntries = aDecoder.decodeObjectForKey("ProgressEntries") as! [ProgressEntry]
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(progressEntries, forKey: "ProgressEntries")
    }
}
