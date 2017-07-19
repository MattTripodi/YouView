//
//  CustomLabelSignInScreen.swift
//  YouView
//
//  Created by Matt Tripodi on 7/18/17.
//  Copyright © 2017 Matthew Tripodi. All rights reserved.
//

import UIKit

class CustomLabelSignInScreen: UILabel {

	override func awakeFromNib() {
		super.awakeFromNib()
		
		// To Give label Rounded white border
		layer.borderColor = UIColor.white.cgColor
		layer.borderWidth = 1
		layer.cornerRadius = 5
	}

}
