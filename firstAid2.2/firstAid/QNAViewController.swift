//
//  QNAViewController.swift
//  firstAid
//
//  Created by heoju on 2017. 6. 7..
//  Copyright © 2017년 HJ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class QNAViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    var selectedQuestion:Question!
    var addView:AnswerViewController!
    
    var qnalist = QnAList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        // cell의 AutoLayout을 위해.
        //tableview.setNeedsLayout()
        //tableview.layoutIfNeeded()
        
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 100
        
        tableview.sectionHeaderHeight = 232
        tableview.tableFooterView = UIView(frame: CGRect.zero)
        
        
        qnalist.setQnAList(problemId: selectedQuestion.questionId, table: tableview)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.setNeedsLayout()
        tableview.layoutIfNeeded()
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 100
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // section의 개수 = 질문의 개수. section당 달린 cell = 답변.
    func numberOfSections(in tableView: UITableView) -> Int {
        //return selectedQuestion.questionPage.count
        return qnalist.qnalist.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + qnalist.qnalist[section].answerPage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableview.dequeueReusableCell(withIdentifier: "QPCell") as! QPCell
            let answer = qnalist.qnalist[indexPath.section].answerPage
            
            cell.button.tag = indexPath.section
            cell.numberOfAnswer.text = String(answer.count)
            
            return cell
        }
        else{
            // 답변 Cell에 관한 설정들.
            let cell = tableview.dequeueReusableCell(withIdentifier: "QNAPageCell") as! QNAPageCell
            //let qp = selectedQuestion.questionPage[indexPath.section]
            let qp = qnalist.qnalist[indexPath.section]
            cell.textView.text = qp.answerPage[indexPath.row-1].text
            cell.boomNum.text = String(qp.answerPage[indexPath.row-1].boom)
            
            cell.sizeToFit()
            cell.textView?.numberOfLines = 0
            if(qp.answerPage[indexPath.row-1].image == nil){
                print("hidden")
                //cell.viewForImage.isHidden = true
            }
            
            cell.upButton.tag = indexPath.section * 100 + indexPath.row
            cell.downButton.tag = indexPath.section * 100 + indexPath.row
            //for image in answer
            
            //print(qp.answerPage[indexPath.row-1].image?.count)
            /*
            if let chosenImages:[UIImage] = qp.answerPage[indexPath.row-1].image {
                for i in 0 ..< chosenImages.count{
                    let imageView = UIImageView()
                    imageView.image = chosenImages[i]
                    let xPosition = (cell.imageScrollView.frame.height - 2)  * CGFloat(i) + 2
                    //print(self.imageScrollView.frame.height)
                    imageView.frame = CGRect(x: xPosition, y: 2, width: cell.imageScrollView.frame.height - 4, height: cell.imageScrollView.frame.height - 4)
                    
                    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gestureRecognizer:)))
                    imageView.addGestureRecognizer(tapRecognizer)
                    imageView.isUserInteractionEnabled = true
                    
                    //imageView.addGestureRecognizer(tapRecognizer)
                    
                    imageView.contentMode = .scaleAspectFill
                    imageView.clipsToBounds = true
                    cell.imageScrollView.contentSize.width = (cell.imageScrollView.frame.height-5) * CGFloat(i + 1) + 2
                    cell.imageScrollView.addSubview(imageView)
                }
            }*/
            if (qp.answerPage[indexPath.row-1].imageUrl != nil){
                for i in 0 ..< qp.answerPage[indexPath.row-1].imageUrl.count{
                    if (qp.answerPage[indexPath.row-1].imageUrl[i] == ""){
                        continue
                    }
                    let imageView = UIImageView()
                    let url = URL(string:qp.answerPage[indexPath.row-1].imageUrl[i])
                    let data = try? Data(contentsOf: url!)
                    
                    if let imageData = data {
                        
                        imageView.image = UIImage(data: imageData)
                        let xPosition = (cell.imageScrollView.frame.height - 2)  * CGFloat(i) + 2
                        //print(self.imageScrollView.frame.height)
                        imageView.frame = CGRect(x: xPosition, y: 2, width: cell.imageScrollView.frame.height - 4, height: cell.imageScrollView.frame.height - 4)
                        
                        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gestureRecognizer:)))
                        imageView.addGestureRecognizer(tapRecognizer)
                        imageView.isUserInteractionEnabled = true
                        
                        //imageView.addGestureRecognizer(tapRecognizer)
                        
                        imageView.contentMode = .scaleAspectFill
                        imageView.clipsToBounds = true
                        cell.imageScrollView.contentSize.width = (cell.imageScrollView.frame.height-5) * CGFloat(i + 1) + 2
                        cell.imageScrollView.addSubview(imageView)
                        
                    }
                }
            }
            return cell
        }
    }
    
    
    
    // section header를 customize하기 위한 몸부림.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionCell:QNAQuestionCell = tableview.dequeueReusableCell(withIdentifier: "QNAQuestionCell") as! QNAQuestionCell
        
        //sectionCell.titleLabel.text = selectedQuestion.questionPage[section].title
        //sectionCell.tagLabel.text = selectedQuestion.questionPage[section].tag
        //sectionCell.textView.text = selectedQuestion.questionPage[section].text
        
        sectionCell.titleLabel.text = qnalist.qnalist[section].title
        sectionCell.tagLabel.text = qnalist.qnalist[section].tag
        sectionCell.textView.text = qnalist.qnalist[section].text
        //for image in header
        if (qnalist.qnalist[section].imageUrl != nil){
            /*
            let chosenImages = qnalist.qnalist[section].image!
            for i in 0 ..< chosenImages.count{
                
                let imageView = UIImageView()
                imageView.image = chosenImages[i]
                let xPosition = (sectionCell.imageScrollView.frame.height - 2)  * CGFloat(i) + 2
                //print(self.imageScrollView.frame.height)
                imageView.frame = CGRect(x: xPosition, y: 2, width: sectionCell.imageScrollView.frame.height - 4, height: sectionCell.imageScrollView.frame.height - 4)
                
                let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gestureRecognizer:)))
                imageView.addGestureRecognizer(tapRecognizer)
                imageView.isUserInteractionEnabled = true
                
                //imageView.addGestureRecognizer(tapRecognizer)
                
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                sectionCell.imageScrollView.contentSize.width = (sectionCell.imageScrollView.frame.height-5) * CGFloat(i + 1) + 2
                sectionCell.imageScrollView.addSubview(imageView)
            }*/
            for i in 0 ..< qnalist.qnalist[section].imageUrl.count{
                if (qnalist.qnalist[section].imageUrl[i] == ""){
                    continue
                }
                let imageView = UIImageView()
                let url = URL(string:qnalist.qnalist[section].imageUrl[i])
                let data = try? Data(contentsOf: url!)
                
                if let imageData = data {
                    imageView.image = UIImage(data: imageData)
                    let xPosition = (sectionCell.imageScrollView.frame.height - 2)  * CGFloat(i) + 2
                    //print(self.imageScrollView.frame.height)
                    imageView.frame = CGRect(x: xPosition, y: 2, width: sectionCell.imageScrollView.frame.height - 4, height: sectionCell.imageScrollView.frame.height - 4)
                    
                    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gestureRecognizer:)))
                    imageView.addGestureRecognizer(tapRecognizer)
                    imageView.isUserInteractionEnabled = true
                    
                    //imageView.addGestureRecognizer(tapRecognizer)
                    
                    imageView.contentMode = .scaleAspectFill
                    imageView.clipsToBounds = true
                    sectionCell.imageScrollView.contentSize.width = (sectionCell.imageScrollView.frame.height-5) * CGFloat(i + 1) + 2
                    sectionCell.imageScrollView.addSubview(imageView)
                }
            }
        }
        
        return sectionCell
    }
    
    func imageTapped(gestureRecognizer: UITapGestureRecognizer){
        //tappedImageView is tapped image
        let tappedImageView = gestureRecognizer.view! as! UIImageView
        let storyboard = UIStoryboard(name:
            "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ImageZoomNavigationViewController")
        let tmp = controller as! ImageZoomNavigationViewController
        tmp.tappedImage = tappedImageView.image
        
        self.present(tmp, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func pushButton(_ sender: Any) {
        let button = sender as! UIButton
        let section = button.tag
        addView.table = tableview
        addView.selectedQuestionPage = qnalist.qnalist[section]
        addView.qnalist = qnalist
        addView.problemId = selectedQuestion.questionId
        print("####\(section)\n")
    }
    
    // 추천 기능.
    @IBAction func boomUp(_ sender: Any) {
        let button = sender as! UIButton
        let section = button.tag / 100
        let row = button.tag % 100
        
        let question = qnalist.qnalist[section]
        question.answerPage[row-1].boom += 1
        
        let url = "http://220.85.167.57:2288/solution/like/" + String(question.answerPage[row-1].answerId) + "/"
        Alamofire.request(url).responseJSON { response in
            
            if let j = response.result.value {
                
            }
        }
        
        self.tableview.reloadData()
    }
    
    @IBAction func boomDown(_ sender: Any) {
        let button = sender as! UIButton
        let section = button.tag / 100
        let row = button.tag % 100
        
        let question = qnalist.qnalist[section]
        question.answerPage[row-1].boom -= 1
        
        let url = "http://220.85.167.57:2288/solution/hate/" + String(question.answerPage[row-1].answerId) + "/"
        Alamofire.request(url).responseJSON { response in
            
            if let j = response.result.value {
                
            }
        }
        
        self.tableview.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addAnswer" {
            addView = (segue.destination as!UINavigationController).topViewController as! AnswerViewController
            addView.table = tableview
            addView.qnalist = qnalist
            addView.problemId = selectedQuestion.questionId
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
