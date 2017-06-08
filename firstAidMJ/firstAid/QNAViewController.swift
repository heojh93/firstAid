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
  var images:[UIImage] = []//for question
  var answerImages:[UIImage] = []//for answer

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.sectionHeaderHeight = 170
      
      images.append(UIImage(named: "Image")!)
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
      
      
      var Images: [UIImage] = []
      
      if !Images.isEmpty {
        for v in sectionCell.scrollView.subviews {
          v.removeFromSuperview()
        }
      }
      
      Images = images
      //let imagePickerController = ImagePickerController()
      
      
      for i in 0 ..< Images.count{
        let imageView = UIImageView()
        imageView.image = Images[i]
        let xPosition = self.view.frame.height * CGFloat(i)
        //print(self.imageScrollView.frame.height)
        imageView.frame = CGRect(x: xPosition, y: 0, width: sectionCell.scrollView.frame.height, height: sectionCell.scrollView.frame.height)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gestureRecognizer:)))
        imageView.addGestureRecognizer(tapRecognizer)
        imageView.isUserInteractionEnabled = true
        
        //imageView.addGestureRecognizer(tapRecognizer)
        
        
        sectionCell.scrollView.contentSize.width = sectionCell.scrollView.frame.height * CGFloat(i + 1)
        sectionCell.scrollView.addSubview(imageView)
      }
      
      return sectionCell
    }
    
  @IBAction func answerThisQuestion(_ sender: Any) {
    // 사용자의 탭 좌표에 해당하는 테이블 뷰 셀을 얻을 수 있음.
    //그 셀의 인덱스패쓰로부터 섹션 번호를 얻어냄.
    
    //print(self.tableview.indexPathForSelectedRow)
//    let selectedINdexPaht = self.tableview.indexPathForSelectedRow
//    
//    print(selectedINdexPaht?.section)
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
  
  func imageTapped(gestureRecognizer: UITapGestureRecognizer){
    //tappedImageView is tapped image
    let tappedImageView = gestureRecognizer.view! as! UIImageView
    if (tappedImageView.image != nil) {
      let storyboard = UIStoryboard(name:
        "Main", bundle: nil)
      let controller = storyboard.instantiateViewController(withIdentifier: "ImageZoomNavigationViewController")
      let tmp = controller as! ImageZoomNavigationViewController
      tmp.tappedImage = tappedImageView.image
      
      self.present(tmp, animated: true, completion: nil)
    }
  }

}
