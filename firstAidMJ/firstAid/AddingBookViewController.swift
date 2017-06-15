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


extension UIImage{
    
    func resizeImageWith(newSize: CGSize) -> UIImage {
        
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
}



class AddingBookViewController: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate, ImagePickerDelegate, UITextViewDelegate, UIScrollViewDelegate {
    
    
    var selectedQuestionPage:[QuestionPage]!
    
    var table:UITableView!
    var bookList:BookList!
    
    
    
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
        var imageString:String = ""
        if image.count != 0{
            let temp = image[0].resizeImageWith(newSize: CGSize(width: 100, height: 100))
            let imageData = UIImagePNGRepresentation(temp)
            imageString = (imageData?.base64EncodedString())!
        }
        
        //var answerPage = AnswerPage(text: text!)
        //answerPage.image = image
        
        var bookList = self.bookList
        var table = self.table
        
        //Something to do
        //class Questions send json request
        
        let title = titleText.text
        let author = authorText.text
        
        let url = "http://220.85.167.57:2288/solution/textbook_post/"
        let param: Parameters = [
            "author":author!,
            "title":title!,
            "image":imageString,
        ]
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON { response in
            if let json = response.result.value {
                bookList?.setBookList(table: table!)
                
                let j = JSON(json)
                guard let bookId = j["id"].int else {
                    print("fatal...")
                    return
                }
                /*
                if image.count != 0{
                    let imageData = UIImagePNGRepresentation(image[0])!
                    let post_url = "http://220.85.167.57:2288/solution/textbook_image_post/" + String(bookId) + "/"
                    Alamofire.upload(imageData, to: post_url).responseJSON { response in
                        debugPrint(response)
                    }
                }
                */
                
                table?.reloadData()
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
      bookImage.contentMode = .scaleAspectFill
      bookImage.clipsToBounds = true
      
      
        self.dismiss(animated: true, completion: nil)
        //self.dismiss(animated: true, completion: nil)
    }
    
    func imageTapped(gestureRecognizer: UITapGestureRecognizer){
      //tappedImageView is tapped image
      let tappedImageView = gestureRecognizer.view! as! UIImageView
      if (tappedImageView.image != nil) {
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ImageZoomNavigationViewController")
        let tmp = controller as! ImageZoomNavigationViewController
        tmp.tappedImage = tappedImageView.image
      
        self.present(tmp, animated: true, completion: nil)
      }
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
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gestureRecognizer:)))
        bookImage.addGestureRecognizer(tapRecognizer)
      
        bookImage.isUserInteractionEnabled = true
      
        
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
        imagePickerController.imageLimit = 1
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
