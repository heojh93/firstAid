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

class BookData : NSObject{
    
    var bookName: String
    var bookWriter: String
    var bookImage: String!
    
    init(bookName:String, bookWriter:String, bookImage:String){
        self.bookName = bookName
        self.bookWriter = bookWriter
        self.bookImage = bookImage
    }
    init(bookName:String, bookWriter:String){
        self.bookName = bookName
        self.bookWriter = bookWriter
    }

}

var BookList:[BookData] =
    [BookData(bookName: "Algorithm",bookWriter: "abc"),
    BookData(bookName: "Automata",bookWriter: "aaa"),
    BookData(bookName: "DataStructure",bookWriter: "ddd")]






