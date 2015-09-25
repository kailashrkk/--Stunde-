//
//  NewTableViewCell.swift
//  Stunde
//
//  Created by Kailash Ramaswamy on 18/06/15.
//  Copyright (c) 2015 NCh. All rights reserved.
//

import UIKit

class NewTableViewCell: UITableViewCell {
    @IBOutlet weak var labil: UILabel!

    @IBOutlet weak var clue: UIButton!
    
  
    
    @IBOutlet weak var hide: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  

}
