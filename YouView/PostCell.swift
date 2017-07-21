//
//  PostCell.swift
//  YouView
//
//  Created by Matt Tripodi on 7/19/17.
//  Copyright © 2017 Matthew Tripodi. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
	
	@IBOutlet weak var profileImg: UIImageView!
	@IBOutlet weak var usernameLabel: UILabel!
	@IBOutlet weak var postImg: UIImageView!
	@IBOutlet weak var caption: UITextView!
	@IBOutlet weak var likesLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	


}
