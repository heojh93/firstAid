//
//  Data.swift
//  firstAid
//
//  Created by heoju on 2017. 5. 22..
//  Copyright © 2017년 KimMJ. All rights reserved.
//

import Foundation

class Project: NSObject {
    
    var projectId: Int
    var name: String
    
    init(projectId: Int, name: String) {
        self.projectId = projectId
        self.name = name
    }
}
