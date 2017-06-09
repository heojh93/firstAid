//
//  QNAViewController.swift
//  firstAid
//
//  Created by heoju on 2017. 6. 7..
//  Copyright © 2017년 HJ. All rights reserved.
//

import UIKit

class QNAViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    var selectedQuestion:Question!
    var addView:AnswerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        
        // cell의 AutoLayout을 위해.
        tableview.setNeedsLayout()
        tableview.layoutIfNeeded()

        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 100
        
        tableview.sectionHeaderHeight = 170
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // section의 개수 = 질문의 개수. section당 달린 cell = 답변.
    func numberOfSections(in tableView: UITableView) -> Int {
        return selectedQuestion.questionPage.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("@@@@@@@@@@@@@@@\(1 + selectedQuestion.questionPage[section].answerPage.count)\n")
        return 1 + selectedQuestion.questionPage[section].answerPage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableview.dequeueReusableCell(withIdentifier: "QPCell") as! QPCell
            cell.button.tag = indexPath.section
            return cell
        }
        else{
            // 답변 Cell에 관한 설정들.
            let cell = tableview.dequeueReusableCell(withIdentifier: "QNAPageCell") as! QNAPageCell
            let qp = selectedQuestion.questionPage[indexPath.section]
            cell.textView.text = qp.answerPage[indexPath.row-1].text
            
            cell.sizeToFit()
            cell.updateConstraintsIfNeeded()
            cell.textView?.numberOfLines = 0
            
            return cell

        }
    }
    
    // section header를 customize하기 위한 몸부림.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionCell:QNAQuestionCell = tableview.dequeueReusableCell(withIdentifier: "QNAQuestionCell") as! QNAQuestionCell
        
        sectionCell.titleLabel.text = selectedQuestion.questionPage[section].title
        sectionCell.tagLabel.text = selectedQuestion.questionPage[section].tag
        sectionCell.textView.text = selectedQuestion.questionPage[section].text
      
      return sectionCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func pushButton(_ sender: Any) {
        let button = sender as! UIButton
        let section = button.tag
        addView.table = tableview
        addView.selectedQuestionPage = selectedQuestion.questionPage[section]
        print("####\(section)\n")
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addAnswer" {
            addView = (segue.destination as!UINavigationController).topViewController as! AnswerViewController
            //addView.selectedQuestionPage = selectedQuestion.questionPage[index!]
            //addView.table = tableview
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
