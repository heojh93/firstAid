//
//  QuestionTableCell.swift
//  firstAid
//
//  Created by heoju on 2017. 5. 28..
//  Copyright © 2017년 HJ. All rights reserved.
//

import UIKit

class QuestionTableCell: UITableViewCell {

    @IBOutlet weak var QuestionNumber: UILabel!
    @IBOutlet weak var QuestionTag: UILabel!
    @IBOutlet weak var QNAview: UIView!

    @IBOutlet weak var numberQuestion: UILabel!
    @IBOutlet weak var numberAnswer: UILabel!
  @IBOutlet weak var tagField: WSTagsField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
