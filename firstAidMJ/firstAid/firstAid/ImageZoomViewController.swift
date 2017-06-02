//
//  ImageZoomViewController.swift
//  firstAid
//
//  Created by Kim Mj on 2017. 6. 2..
//  Copyright © 2017년 KimMJ. All rights reserved.
//

import UIKit
import GTZoomableImageView

class ImageZoomViewController: UIViewController {
  
  @IBOutlet weak var ZoomableImageView: GTZoomableImageView!
  

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      //ZoomableImageView.image = use modal segue?
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  @IBAction func backButtonClicked(_ sender: Any) {
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
