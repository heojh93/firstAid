//
//  Data.swift
//  firstAid
//
//  Created by heoju on 2017. 5. 22..
//  Copyright © 2017년 HJ. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class BookList {
    var booklist:[BookData]
    
    init(){
        booklist = []
    }
    
    func setBookList(table:UITableView){
        
        
        Alamofire.request("http://220.85.167.57:2288/solution/textbook_list/").responseJSON { response in
            var templist:[BookData] = self.booklist
            self.booklist = []
            if let j = response.result.value {
                
                let jsons = JSON(j)
                for (_, json) in jsons {
                    
                    guard let bookName = json["title"].string else {
                        continue
                    }
                    guard let bookWriter = json["author"].string else {
                        continue
                    }
                    guard let bookImage = json["image_url"].string else {
                        continue
                    }
                    guard let bookId = json["id"].int else {
                        continue
                    }
                    
                    let book = templist.filter({( book: BookData) -> Bool in
                        return (book.bookId == bookId)
                    })
                    if book.count == 0 {
                        /*
                        if let url = URL(string:bookImage){
                            let data = try? Data(contentsOf: url)
                            let bookImageData = UIImage(data: data!)
                            self.booklist.append(BookData(bookId: bookId, bookName: bookName, bookWriter: bookWriter, bookImage: bookImage, bookImageData : bookImageData!))
                        }
                        else{
                            self.booklist.append(BookData(bookId: bookId, bookName: bookName, bookWriter: bookWriter, bookImage: bookImage))
                        }*/
                        self.booklist.append(BookData(bookId: bookId, bookName: bookName, bookWriter: bookWriter, bookImage: bookImage))
                    }
                    else {
                        self.booklist.append(book[0])
                    }
                    print("reload..")
                    table.reloadData()
                    
                }
                table.reloadData()
            }
        }
    }
}




class BookData : NSObject{
    var bookId:Int
    var bookName: String
    var bookWriter: String
    var bookImage: String!
    var bookImageData: UIImage?
    var bookQuestion:[Question] = []
    
    init(bookId:Int, bookName:String, bookWriter:String, bookImage:String, bookImageData:UIImage){
        self.bookId = bookId
        self.bookName = bookName
        self.bookWriter = bookWriter
        self.bookImage = bookImage
        self.bookImageData = bookImageData
    }
    init(bookId:Int, bookName:String, bookWriter:String, bookImage:String){
        self.bookId = bookId
        self.bookName = bookName
        self.bookWriter = bookWriter
        self.bookImage = bookImage
    }
    init(bookId:Int, bookName:String, bookWriter:String){
        self.bookId = bookId
        self.bookName = bookName
        self.bookWriter = bookWriter
    }
    func addQuestion(_ question:Question) -> Void{
        
        self.bookQuestion.append(question)
    }
}


class QuestionList{
    var questionlist:[Question]
    
    init(){
        questionlist = []
    }
    
    func setQuestionList(bookId:Int, table:UITableView){
        self.questionlist.removeAll()
        let url:String = "http://220.85.167.57:2288/solution/textbook/" + String(bookId) + "/problem_list/"
        Alamofire.request(url).responseJSON { response in
            
            if let j = response.result.value {
                let jsons = JSON(j)
                for (_, json) in jsons {
                    
                    guard let questionId = json["id"].int else {
                        continue
                    }
                    guard let questionNumber = json["number"].int else {
                        continue
                    }
                    guard let questionTag = json["tag"].string else {
                        continue
                    }
                    guard let numberOfAnswer = json["answer_number"].int else {
                        continue
                    }
                    guard let numberOfQuest = json["quest_number"].int else {
                        continue
                    }
                    self.questionlist.append(Question(questionId:questionId, number:questionNumber, tag:questionTag, quest: numberOfQuest, answer:numberOfAnswer))
                    table.reloadData()
                }

            }
        }
    }
}


class Question{
    var questionId:Int
    var questionNumber: Int
    var questionTag: String
    var numberOfQuest: Int
    var numberOfAnswer: Int
    
    var questionPage: [QuestionPage] = []
    
    init(questionId:Int, number questionNumber:Int, tag questionTag:String, quest numberOfQuest:Int, answer numberOfAnswer:Int){
        self.questionId = questionId
        self.questionNumber = questionNumber
        self.questionTag = questionTag
        self.numberOfQuest = numberOfQuest
        self.numberOfAnswer = numberOfAnswer
    }
    
    func addPage(_ question:QuestionPage) -> Void{
        self.questionPage.append(question)
    }
    
    
}

class QnAList{
    var qnalist:[QuestionPage]
    
    init(){
        qnalist = []
    }
    
    func setQnAList(problemId:Int, table:UITableView){
        self.qnalist.removeAll()
        
        var url = "http://220.85.167.57:2288/solution/problem/" + String(problemId) + "/"
        Alamofire.request(url).responseJSON { response in
            
            if let j = response.result.value {
                
                let jsons = JSON(j)
                for (_, json) in jsons {
                    guard let questionPageId = json["id"].int else {
                        continue
                    }
                    guard let title = json["title"].string else {
                        continue
                    }
                    guard let tag = json["tag"].string else {
                        continue
                    }
                    guard let text = json["content"].string else {
                        continue
                    }
                    guard let answerPages = json["answer_list"].array else {
                        continue
                    }
                    var question = QuestionPage(questionPagdId: questionPageId, number: 0, title: title, tag: tag, text: text)
                    
                    for answer in answerPages{
                        guard let answerId = answer["id"].int else {
                            continue
                        }

                        guard let text = answer["content"].string else {
                            continue
                        }
                        guard let boom = answer["like"].int else {
                            continue
                        }
                        var answerPage = AnswerPage(text: text, boom: boom, answerId: answerId)
                        question.answerPage.append(answerPage)
                    }
                    self.qnalist.append(question)
                    table.reloadData()
                }
            }
        }
    }
}


// QuestionPage 추가 -> Question class구성 후, Question List에 추가, questionPage배열에 추가.
class QuestionPage{
    
    var questionPageId:Int
    var questionNumber:Int
    var title:String
    var tag:String
    var text:String
    var image:[UIImage]?
    var answerPage:[AnswerPage] = []
    
    init(number questionNumber:Int, title:String, tag:String, text:String){
        self.questionPageId = 0
        self.questionNumber = questionNumber
        self.title = title
        self.tag = tag
        self.text = text
    }
    
    init(questionPagdId:Int, number questionNumber:Int, title:String, tag:String, text:String){
        self.questionPageId = questionPagdId
        self.questionNumber = questionNumber
        self.title = title
        self.tag = tag
        self.text = text
    }
    
    func addAnswer(_ answer:AnswerPage)->Void{
        self.answerPage.append(answer)
    }
}

class AnswerPage{
    
    var answerId:Int = 0
    var boom:Int = 0
    var text:String
    var image:[UIImage]?
    
    init(text:String){
        self.text = text
    }
    init(text:String, boom:Int, answerId:Int){
        self.text = text
        self.boom = boom
        self.answerId = answerId
    }
}
/*
let algorithm = BookData(bookId: 100, bookName: "Algorithm",bookWriter: "abc")
let automata = BookData(bookId: 200, bookName: "Automata",bookWriter: "aaa")
let datastructure = BookData(bookId: 300, bookName: "DataStructure",bookWriter: "ddd")

//var BookList:[BookData] = [] // = [algorithm, automata, datastructure]

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
*/
var questionPage11 = QuestionPage(number: 1, title: "이것 좀 풀어달라!", tag: "#자 #고 #싶 #다", text: "이것을 이렇게 이렇게 풀어봤는데 이게 이것떄문에 이렇게 안되더라 이것을 어떻게 하면 좋을까?")
var questionPage12 = QuestionPage(number: 1, title: "나는가수다", tag: "#솔아솔아 #푸르른 #솔아", text: "동해물과 백두산이 마르고 닳도록 하나님이 보우하사 우리나라만세!")



