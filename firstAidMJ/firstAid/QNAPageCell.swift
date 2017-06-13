//
//  QNAPageCell.swift
//  firstAid
//
//  Created by heoju on 2017. 6. 1..
//  Copyright © 2017년 HJ. All rights reserved.
//

import UIKit

class QNAPageCell: UITableViewCell {

    
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var viewForImage: UIView!
    @IBOutlet weak var QPCConstraint4NoImage: NSLayoutConstraint!
    
    @IBOutlet weak var QPCConstraint4Image1: NSLayoutConstraint!
    @IBOutlet weak var QPCConstraint4Image2: NSLayoutConstraint!
    @IBOutlet weak var QPCConstraint4Image3: NSLayoutConstraint!
    @IBOutlet weak var QPCConstraint4Image4: NSLayoutConstraint!
    @IBOutlet weak var QPCConstraint4Image5: NSLayoutConstraint!
    
    @IBOutlet weak var boomNum: UILabel!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    
  @IBOutlet weak var imageScrollView: UIScrollView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
