//
//  SearchTableController.swift
//  firstAid
//
//  Created by heoju on 2017. 5. 27..
//  Copyright © 2017년 HJ. All rights reserved.
//

import UIKit

class QuestionListController: UIViewController {
    
    var detailBook: BookData? {
        didSet {
            configureView()
        }
    }
    
    @IBOutlet weak var questionTable: QuestionTable!
    
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

        // dummy 데이터들
        algorithm.addQuestion(question10)
        algorithm.addQuestion(question11)
        algorithm.addQuestion(question12)
        algorithm.addQuestion(question13)
        algorithm.addQuestion(question20)
        algorithm.addQuestion(question21)
        algorithm.addQuestion(question22)
        algorithm.addQuestion(question23)
        
        automata.addQuestion(question110)
        automata.addQuestion(question111)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 }

extension QuestionListController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionTable.selectedBook.bookQuestion.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableCell") as! QuestionTableCell
        let question = questionTable.selectedBook.bookQuestion[indexPath.row]
        cell.QuestionNumber.text = String(question.questionNumber)
        cell.QuestionTag.text = question.questionTag
        cell.NumberOfAnswer.text = String(question.numberOfAnswer)
        
        return cell
    }
}
