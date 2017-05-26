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


class Book{
  
  var imageURL:String;
  var title:String;
  var author:String;
  var exercises:[Exercise];
  
  init(){}
}

class Exercise{
  var exercise_num:String;
  var tags:[String];
  var questions:[Questions];

  init(){}
}

class Questions{
  var imageURL:String;
  var title:String;
  var answers:[Answer];
  var text:String;
  
  init(){}
}

class Answer{
  var imageURL:String;
  var text:String;

  init(){}
}

