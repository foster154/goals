//
//  Goal.swift
//  Goals
//
//  Created by Mark F on 3/26/16.
//  Copyright © 2016 Bunk Bed Labs. All rights reserved.
//

import UIKit

class Goal: NSObject {
    var name = ""
    
    init(name: String) {
        self.name = name
        super.init()
    }
}
