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
//var viewsection = UIImageView()


class QuestionViewController: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate, ImagePickerDelegate {
  //@IBOutlet weak var viewsection: UIImageView!
  @IBOutlet weak var viewsection: UIImageView!
  
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
    //self.dismiss(animated: true, completion: nil)
  }
  func cancelButtonDidPress(_ imagePicker: ImagePickerController){
    //self.dismiss(animated: true, completion: nil)
  }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
  

  @IBAction func photoFromLibrary(_ sender: Any) {
    let imagePickerController = ImagePickerController()
    //imagePickerController.imageLimit = 5
    imagePickerController.delegate = self
    self.present(imagePickerController, animated: true, completion: nil)
    
    //picker.allowsEditing = true;
    //picker.sourceType = .photoLibrary
    //picker.delegate = self
    //self.present(picker, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    var chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
    viewsection.contentMode = .scaleAspectFit
    viewsection.image = chosenImage
    self.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
