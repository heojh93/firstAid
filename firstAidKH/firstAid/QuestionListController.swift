//
//  SearchTableController.swift
//  firstAid
//
//  Created by heoju on 2017. 5. 27..
//  Copyright © 2017년 HJ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class QuestionListController: UIViewController {
    
    var detailBook: BookData? {
        didSet {
            configureView()
        }
    }
    
    @IBOutlet weak var questionTable: QuestionTable!
    var orderedQ:[Question] = []
    
    func configureView() {
        if let detailBook = detailBook {
            title = detailBook.bookName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        // 선택된 책의 정보를 가져오기 위함.
        for singleBook in BookList{
            if(singleBook.bookName == detailBook?.bookName){
                questionTable.selectedBook = singleBook
            }
        }
        
        let url:String = "http://220.85.167.57:2288/solution/textbook/" + String(detailBook!.bookId) + "/quest_list/"
        
        questionTable.selectedBook.bookQuestion = []
        Alamofire.request(url).responseJSON { response in
            
            print(response.result)
            
            if let j = response.result.value {
                print("JSON: \(j)")
                
                let jsons = JSON(j)
                for (_, json) in jsons {
                    
                    guard let questionId = json["id"].int else {
                        continue
                    }
                    guard let questionNumber = json["number"].string else {
                        continue
                    }
                    guard let questionTag = json["tag"].string else {
                        continue
                    }
                    guard let numberOfAnswer = json["answer_number"].int else {
                        continue
                    }
                    guard let chapter = json["chapter"].string else {
                        continue
                    }
                    self.questionTable.selectedBook.addQuestion(Question(book:self.detailBook!, chapter:Int(chapter)!, number:Int(questionNumber)!, tag:questionTag, answer:numberOfAnswer, questionId:questionId))
                    self.questionTable.reloadData()
                }
            }
        }
        
        //questionTable.selectedBook = detailBook
        
        
        
        // TableCell과 quesitonTable의 원소번호를 맞추기 위해.
        //orderedQ = questionTable.selectedBook.bookQuestion.sorted(by: {$0.0.questionNumber < $0.1.questionNumber})
        
        //questionTable.dataSource = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    // 문제를 번호 순대로 sorting함.
    func questionSorting(index:Int) -> Question{
        let orderedQuestion = questionTable.selectedBook.bookQuestion.sorted(by: {$0.0.questionNumber < $0.1.questionNumber})
        return orderedQuestion[index]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // "질문 추가"
        if segue.identifier == "addQuestion" {
            let addView = (segue.destination as!UINavigationController).topViewController as! QuestionViewController
            addView.selectedBook = questionTable.selectedBook
            addView.table = questionTable
        }
        
        // "문제 보기"
        if segue.identifier == "showQuestion" {
            let questionView = segue.destination as! QNAViewController
            let index = questionTable.indexPathForSelectedRow?.row
            
            //questionView.selectedQuestion = orderedQ[index!]
            questionView.selectedQuestion = questionSorting(index: index!)
        }
    }
 }

extension QuestionListController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionTable.selectedBook.bookQuestion.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableCell") as! QuestionTableCell
        let question = questionSorting(index: indexPath.row)
        //let question = orderedQ[indexPath.row]
        cell.QuestionNumber.text = String(question.questionNumber)
        cell.QuestionTag.text = question.questionTag
        cell.NumberOfAnswer.text = String(question.numberOfAnswer)
        
        return cell
    }
}
