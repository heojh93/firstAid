//
//  Data.swift
//  firstAid
//
//  Created by heoju on 2017. 5. 22..
//  Copyright © 2017년 HJ. All rights reserved.
//

import Foundation
import UIKit

class BookData : NSObject{
    
    var bookName: String
    var bookWriter: String
    var bookImage: String!
    var bookQuestion:[Question] = []
    
    init(bookName:String, bookWriter:String, bookImage:String){
        self.bookName = bookName
        self.bookWriter = bookWriter
        self.bookImage = bookImage
    }
    init(bookName:String, bookWriter:String){
        self.bookName = bookName
        self.bookWriter = bookWriter
    }
    func addQuestion(_ question:Question) -> Void{
        self.bookQuestion.append(question)
    }

}

class Question : BookData{
    
    var chapter: Int
    var questionNumber: Int
    var questionTag: String
    var numberOfAnswer: Int
    var questionPage: [QuestionPage] = []
    
    init(book:BookData, chapter:Int, number questionNumber:Int, tag questionTag:String, answer numberOfAnswer:Int){
        self.chapter = chapter
        self.questionNumber = questionNumber
        self.questionTag = questionTag
        self.numberOfAnswer = numberOfAnswer
        super.init(bookName: book.bookName,bookWriter: book.bookWriter)
    }
    
    func addPage(_ question:QuestionPage) -> Void{
        self.questionPage.append(question)
    }
}

// QuestionPage 추가 -> Question class구성 후, Question List에 추가, questionPage배열에 추가.
class QuestionPage{
    
    var questionNumber:Int
    var title:String
    var tag:String
    var text:String
    var image:[UIImage]?
    //var answerPage
    
    init(number questionNumber:Int, title:String, tag:String, text:String){
        self.questionNumber = questionNumber
        self.title = title
        self.tag = tag
        self.text = text
    }
}

let algorithm = BookData(bookName: "Algorithm",bookWriter: "abc")
let automata = BookData(bookName: "Automata",bookWriter: "aaa")
let datastructure = BookData(bookName: "DataStructure",bookWriter: "ddd")

var BookList:[BookData] = [algorithm, automata, datastructure]

var question10 = Question(book: algorithm, chapter: 1, number: 1, tag: "#a #b #c", answer: 3)
var question11 = Question(book: algorithm, chapter: 1, number: 2, tag: "#c #b #c", answer: 0)
var question12 = Question(book: algorithm, chapter: 1, number: 4, tag: "#a #b #c", answer: 2)
var question13 = Question(book: algorithm, chapter: 1, number: 10, tag: "#a #b #c", answer: 1)
var question20 = Question(book: algorithm, chapter: 2, number: 6, tag: "#a #b #c", answer: 1)
var question21 = Question(book: algorithm, chapter: 2, number: 2, tag: "#a #b #c", answer: 2)
var question22 = Question(book: algorithm, chapter: 2, number: 3, tag: "#b #c", answer: 1)
var question23 = Question(book: algorithm, chapter: 2, number: 5, tag: "#a #b #c", answer: 0)

var question110 = Question(book: automata, chapter: 1, number: 1, tag: "#auto", answer: 0)
var question111 = Question(book: automata, chapter: 1, number: 3, tag: "#auto", answer: 0)

var questionPage11 = QuestionPage(number: 1, title: "이것 좀 풀어달라!", tag: "#자 #고 #싶 #다", text: "이것을 이렇게 이렇게 풀어봤는데 이게 이것떄문에 이렇게 안되더라 이것을 어떻게 하면 좋을까?")
var questionPage12 = QuestionPage(number: 7, title: "나는가수다", tag: "#솔아솔아 #푸르른 #솔아", text: "동해물과 백두산이 마르고 닳도록 하나님이 보우하사 우리나라만세!")



