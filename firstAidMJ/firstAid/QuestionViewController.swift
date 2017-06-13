//
//  QuestionViewController.swift
//  firstAid
//
//  Created by Kim Mj on 2017. 5. 26..
//  Copyright © 2017년 KimMJ. All rights reserved.
//  https://github.com/hyperoslo/ImagePicker

import UIKit
import ImagePicker
import GTZoomableImageView
import TZZoomImageManager
import WSTagsField

import Alamofire
import SwiftyJSON


let picker = UIImagePickerController()

let placeHolder = "질문을 입력하세요"



class QuestionViewController: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate, ImagePickerDelegate, UITextViewDelegate, UIScrollViewDelegate{
  //@IBOutlet weak var viewsection: UIImageView!
  @IBOutlet weak var imageScrollView: ImageScrollView!
  
  @IBOutlet weak var textView: UITextView!
  
  @IBOutlet weak var titleText: UITextField!
  
  @IBOutlet weak var numberText: UITextField!
  
  @IBOutlet weak var tagsField: WSTagsField!
  @IBOutlet weak var tagsView: UIScrollView!
  
  var selectedBook:BookData!
  var table:QuestionTable!
  
  // @IBOutlet weak var test: UIImageView!
  //@IBOutlet weak var navigator: UINavigationItem!
  
  var chosenImages: [UIImage] = []
  
  @IBAction func CancelDismiss(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func DoneDIsmiss(_ sender: Any) {
    //Something to do
    //class Questions send json request
    let title = titleText.text
    let text = textView.text
    //let images = chosenImages
    let number = Int(numberText.text!)
    
    let tags = tagsField.tagViews

    //tag -> array
    var tagArray:[String] = []
    var tagString:String = ""
    var k = 0
    for _ in tags {
      tagArray.append(tags[tags.index(k, offsetBy: 0)].displayText)
      tagString += tags[tags.index(k, offsetBy: 0)].displayText + " "
      k += 1
    }
    
    //let questionDetail = QuestionPage(number: number!, title: title!, tag: tagString, text: text!)
    //questionDetail.image = images
    
    // 같은 번호의 문제를 받았을 경우, 한개 번호에 다 넣어줌.
    /*
    var find:Bool = false
    for i in selectedBook.bookQuestion{
      if(i.questionNumber == number){
        i.addPage(questionDetail)
        find = true
      }
    }
    if(!find){
      let q = Question(book: selectedBook, chapter: 1, number: number!, tag: "", answer: 1)
      q.addPage(questionDetail)
      selectedBook.addQuestion(q)
    }
    
     let q = Question(book: selectedBook, chapter: 1, number: number!, tag: "", answer: 1)
     q.addPage(questionDetail)
     selectedBook.addQuestion(q)
     */
    
    //let q = Question(book: selectedBook, chapter: 1, number: number!, tag: tagString, answer: 1)
    
    let url = "http://220.85.167.57:2288/solution/problem_post/"
    let param: Parameters = [
      "textbook_id":selectedBook.bookId,
      "number":number!,
      "tag":tagString,
      "title":title!,
      "content":text!
    ]
    Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON { response in
      if let j = response.result.value {
        let json = JSON(j)
        guard let id = json["id"].int else {
          return
        }
        guard let number = json["number"].int else {
          return
        }
        guard let chapter = json["chapter"].int else {
          return
        }
        guard let tag = json["tag"].string else {
          return
        }
        guard let answer_number = json["answer_number"].int else {
          return
        }
        self.selectedBook.addQuestion(Question(questionId: id, book: self.selectedBook, chapter: chapter, number: number, tag: tag, answer: answer_number))
        self.table.reloadData()
      }

      
    }
    

    
    
    /*
    let q = Question(book: selectedBook, chapter: 1, number: number!, tag: "", answer: 1)
    q.addPage(questionDetail)
    selectedBook.addQuestion(q)
    */
    table.reloadData()
    
    self.dismiss(animated: true, completion: nil)
  }
  
  
  func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
    //self.dismiss(animated: true, completion: nil)
  }
  func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
    //var chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
    if !chosenImages.isEmpty {
      for v in imageScrollView.subviews {
        v.removeFromSuperview()
      }
    }
    
    chosenImages = images
    //let imagePickerController = ImagePickerController()
    
    
    for i in 0 ..< chosenImages.count{
      let imageView = UIImageView()
      imageView.image = chosenImages[i]
      let xPosition = (self.imageScrollView.frame.height - 5)  * CGFloat(i) + 5
      //print(self.imageScrollView.frame.height)
      imageView.frame = CGRect(x: xPosition, y: 5, width: self.imageScrollView.frame.height - 10, height: self.imageScrollView.frame.height - 10)
    
      let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gestureRecognizer:)))
      imageView.addGestureRecognizer(tapRecognizer)
      imageView.isUserInteractionEnabled = true
      
      //imageView.addGestureRecognizer(tapRecognizer)
      
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageScrollView.contentSize.width = (imageScrollView.frame.height-5) * CGFloat(i + 1) + 5
      imageScrollView.addSubview(imageView)
    }
    
    //viewsection.contentMode = .scaleAspectFit
    //viewsection.image = chosenImages[0]
    //viewsection.image =
      
    self.dismiss(animated: true, completion: nil)
    //self.dismiss(animated: true, completion: nil)
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
  
  func cancelButtonDidPress(_ imagePicker: ImagePickerController){
    //self.dismiss(animated: true, completion: nil)
  }
  
  func navigationBarTap(_ recognizer: UIGestureRecognizer){
    view.endEditing(true)
  }
 
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    textView.delegate = self
    textView.text = placeHolder
    textView.textColor = UIColor.lightGray
    
    //textView.becomeFirstResponder()
    textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
    
    let hideKeyboard = UITapGestureRecognizer(target: self, action: #selector(self.navigationBarTap))
    hideKeyboard.numberOfTapsRequired = 1
    navigationController?.navigationBar.addGestureRecognizer(hideKeyboard)
    //self.navigationController?.setNavigationBarHidden(true, animated: true)
  }

  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  /*
  // MARK: - Navigation
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
  }
  */
  
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    
    let currentText = textView.text as NSString?
    let updateText = currentText?.replacingCharacters(in: range, with: text)
    
    if (updateText?.isEmpty)! {
      textView.text = placeHolder
      textView.textColor = UIColor.lightGray
      
      textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
      
      return false
    }
      
    else if textView.textColor == UIColor.lightGray && !text.isEmpty{
      textView.text = nil
      textView.textColor = UIColor.black
    }
    
    return true
  }

  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.lightGray {
      textView.text = nil
      textView.textColor = UIColor.black
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = placeHolder
      textView.textColor = UIColor.lightGray
    }
  }
//  
//  func textViewDidChangeSelection(_ textView: UITextView) {
//    if self.view.window != nil {
//      if textView.textColor == UIColor.lightGray {
//        //textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
//      }
//    }
//  }
//  

  @IBAction func photoFromLibrary(_ sender: Any) {
    let imagePickerController = ImagePickerController()
    imagePickerController.delegate = self
    self.present(imagePickerController, animated: true, completion: nil)
    
  }
 
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
