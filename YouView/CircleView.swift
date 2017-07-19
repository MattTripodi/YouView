//
//  CircleView.swift
//  YouView
//
//  Created by Matt Tripodi on 7/19/17.
//  Copyright © 2017 Matthew Tripodi. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
	
	override func awakeFromNib() {
		super.awakeFromNib()
		layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
		layer.shadowOpacity = 0.0
		layer.shadowRadius = 5.0
		layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
	}

	override func draw(_ rect: CGRect) {
		super.draw(rect)
		layer.cornerRadius = self.frame.width / 2 
	}

}
