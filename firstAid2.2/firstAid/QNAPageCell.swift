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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
