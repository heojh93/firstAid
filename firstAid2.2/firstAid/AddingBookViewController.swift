//
//  AnswerViewController.swift
//  firstAid
//
//  Created by heoju on 2017. 6. 7..
//  Copyright © 2017년 HJ. All rights reserved.
//  https://github.com/hyperoslo/ImagePicker

import UIKit
import ImagePicker
import GTZoomableImageView
import TZZoomImageManager

import Alamofire
import SwiftyJSON

class AddingBookViewController: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate, ImagePickerDelegate, UITextViewDelegate, UIScrollViewDelegate {
    
    
    var selectedQuestionPage:[QuestionPage]!
    
    var table:UITableView!
    
    
    
    @IBOutlet weak var authorText: UITextField!
    @IBOutlet weak var titleText: UITextField!
    
    
    
    var chosenImages: [UIImage] = []
    
    
    
    @IBOutlet weak var bookImage: UIImageView!
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func CancelDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func DoneDIsmiss(_ sender: Any) {
        
        // AnswerPage로 값이 제대로 넘어오지 못함. Section 문제 떄문.
        //    self.dismiss(animated:true, completion: nil)
        //    return
        
        //let text = textView.text
        let image = chosenImages
        
        //var answerPage = AnswerPage(text: text!)
        //answerPage.image = image
        
        
        //Something to do
        //class Questions send json request
        
        let title = titleText.text
        let author = authorText.text
        
        let url = "http://220.85.167.57:2288/solution/textbook_post/"
        let param: Parameters = [
            "author":author!,
            "title":title!,
        ]
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON { response in
            if let j = response.result.value {
                let json = JSON(j)
                guard let bookName = json["title"].string else {
                    return
                }
                guard let bookWriter = json["author"].string else {
                    return
                }
                guard let bookImage = json["image_url"].string else {
                    return
                }
                guard let bookId = json["id"].int else {
                    return
                }
                BookList.append(BookData(bookId: bookId, bookName: bookName, bookWriter: bookWriter, bookImage: bookImage))
                self.table.reloadData()
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
        //self.dismiss(animated: true, completion: nil)
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
        //var chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        //    if !chosenImages.isEmpty {
        //      for v in imageScrollView.subviews {
        //        v.removeFromSuperview()
        //      }
        //    }
        
        chosenImages = images
        bookImage.image = chosenImages[0]
        
        
        self.dismiss(animated: true, completion: nil)
        //self.dismiss(animated: true, completion: nil)
    }
    
    func imageTapped(gestureRecognizer: UITapGestureRecognizer){
        //tappedImageView is tapped image
        let tappedImageView = gestureRecognizer.view! as! UIImageView
        
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
        
        
        let hideKeyboard = UITapGestureRecognizer(target: self, action: #selector(self.navigationBarTap))
        hideKeyboard.numberOfTapsRequired = 1
        navigationController?.navigationBar.addGestureRecognizer(hideKeyboard)
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
