//
//  QNAQuestionCell.swift
//  firstAid
//
//  Created by heoju on 2017. 6. 7..
//  Copyright © 2017년 HJ. All rights reserved.
//

import UIKit

class QNAQuestionCell: UITableViewCell {

    var sectionNum:Int!
    var sectionFix:Int!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func button(_ sender: UIButton) {
        sectionFix = sectionNum
        print("######################\n")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
