//
//  CircleView.swift
//  YouView
//
//  Created by Matt Tripodi on 7/19/17.
//  Copyright © 2017 Matthew Tripodi. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
	
	override func layoutSubviews() {
		layer.cornerRadius = self.frame.width / 2
		clipsToBounds = true 
	}
}
