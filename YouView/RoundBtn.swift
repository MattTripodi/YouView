//
//  RoundBtn.swift
//  YouView
//
//  Created by Matt Tripodi on 7/18/17.
//  Copyright © 2017 Matthew Tripodi. All rights reserved.
//

import UIKit

class RoundBtn: UIButton {

	override func awakeFromNib() {
		super.awakeFromNib()
		
		layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
		layer.shadowOpacity = 0.0
		layer.shadowRadius = 5.0
		layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
		imageView?.contentMode = .scaleAspectFit
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		layer.cornerRadius = self.frame.width / 2 
	}
}
