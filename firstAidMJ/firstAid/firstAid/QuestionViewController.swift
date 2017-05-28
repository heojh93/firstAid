//
//  QuestionViewController.swift
//  firstAid
//
//  Created by Kim Mj on 2017. 5. 26..
//  Copyright © 2017년 KimMJ. All rights reserved.
//  https://github.com/hyperoslo/ImagePicker

import UIKit
import ImagePicker



let picker = UIImagePickerController()
let placeHolder = "질문을 입력하세요"
//var viewsection = UIImageView()


class QuestionViewController: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate, ImagePickerDelegate, UITextViewDelegate {
  //@IBOutlet weak var viewsection: UIImageView!
  @IBOutlet weak var imageScrollView: ImageScrollView!
  
  @IBOutlet weak var textView: UITextView!
  
  //@IBOutlet weak var navigator: UINavigationItem!
  
  @IBAction func CancelDismiss(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func DoneDIsmiss(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  
  func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
    //self.dismiss(animated: true, completion: nil)
  }
  func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
    //var chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
    var chosenImages = images
    //let imagePickerController = ImagePickerController()
    
    
    for i in 0 ..< chosenImages.count{
      let imageView = UIImageView()
      imageView.image = chosenImages[i]
      let xPosition = self.view.frame.width  * CGFloat(i) * CGFloat(0.5)
      imageView.frame = CGRect(x: xPosition, y: 0, width: self.imageScrollView.frame.width * CGFloat(0.5), height: self.imageScrollView.frame.height)
      imageScrollView.contentSize.width = imageScrollView.frame.width * CGFloat(0.5) * CGFloat(i + 1)
      imageScrollView.addSubview(imageView)
    }
    
    
    //viewsection.contentMode = .scaleAspectFit
    //viewsection.image = chosenImages[0]
    //viewsection.image =
      
    self.dismiss(animated: true, completion: nil)
    //self.dismiss(animated: true, completion: nil)
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
    //imagePickerController.imageLimit = 5
    imagePickerController.delegate = self
    self.present(imagePickerController, animated: true, completion: nil)
    
  }
 
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
