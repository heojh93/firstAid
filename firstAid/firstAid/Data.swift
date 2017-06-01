//
//  Data.swift
//  firstAid
//
//  Created by heoju on 2017. 5. 22..
//  Copyright © 2017년 HJ. All rights reserved.
//

import Foundation

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
    // 문제 한개당 달려있는 답변페이지.
    var questionPage:[AddQuestionPage] = []
    
    init(book:BookData, chapter:Int, number questionNumber:Int, tag questionTag:String, answer numberOfAnswer:Int){
        self.chapter = chapter
        self.questionNumber = questionNumber
        self.questionTag = questionTag
        self.numberOfAnswer = numberOfAnswer
        super.init(bookName: book.bookName,bookWriter: book.bookWriter)
    }
}

class AddQuestionPage{
    var tag:String
    var title:String
    var text: String
    var image:String?
    
    init(question:Question, title:String, tag:String, text:String){
        self.title = title
        self.text = text
        self.tag = tag
    }
    
    init(question:Question, title:String, tag:String, text:String, image:String){
        self.title = title
        self.text = text
        self.tag = tag
        self.image = image
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
var question20 = Question(book: algorithm, chapter: 2, number: 1, tag: "#a #b #c", answer: 1)
var question21 = Question(book: algorithm, chapter: 2, number: 2, tag: "#a #b #c", answer: 2)
var question22 = Question(book: algorithm, chapter: 2, number: 3, tag: "#b #c", answer: 1)
var question23 = Question(book: algorithm, chapter: 2, number: 5, tag: "#a #b #c", answer: 0)

var question110 = Question(book: automata, chapter: 1, number: 1, tag: "#auto", answer: 0)
var question111 = Question(book: automata, chapter: 1, number: 3, tag: "#auto", answer: 0)

var addQuestionPage00 = AddQuestionPage(question: question10, title: "나 질문있다 왈왈", tag: "어렵다 3학년 1학기",
 text: "안녕하세요 반가워요 다시 만나요 즐거웠어요 잘가요")
var addQuestionPage01 = AddQuestionPage(question: question11, title: "이거 어떻게 푸냐", tag: "아우 참나",
                                        text: "이게 이렇게 이렇게 되서 이렇게 되는거 같은데 아닌가요? 나 좀 멍청한듯...")


