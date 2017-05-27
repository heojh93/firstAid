//
//  SearchTableController.swift
//  firstAid
//
//  Created by heoju on 2017. 5. 27..
//  Copyright © 2017년 HJ. All rights reserved.
//

import UIKit

class QuestionListController: UIViewController {

    var detailBook: BookData? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let detailBook = detailBook {
                title = detailBook.bookName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 }
