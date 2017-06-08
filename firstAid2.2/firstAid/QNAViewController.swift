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

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "QNAPageCell") as! QNAPageCell
        
        return cell
    }
    
    // section header를 customize하기 위한 몸부림.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionCell:QNAQuestionCell = tableview.dequeueReusableCell(withIdentifier: "QNAQuestionCell") as! QNAQuestionCell
        
        sectionCell.titleLabel.text = selectedQuestion.questionPage[section].title
        sectionCell.tagLabel.text = selectedQuestion.questionPage[section].tag
        sectionCell.textView.text = selectedQuestion.questionPage[section].text
      
      return sectionCell
    }
    
    /*
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
