//
//  SignInVC.swift
//  YouView
//
//  Created by Matt Tripodi on 7/18/17.
//  Copyright © 2017 Matthew Tripodi. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
	
	//IBOutlets
	@IBOutlet weak var selectASignInMethodLabel: UILabel!
	@IBOutlet weak var signInBtn: UIButton!
	

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// To Give label and button rounded borders
		selectASignInMethodLabel.layer.borderColor = UIColor.white.cgColor
		selectASignInMethodLabel.layer.borderWidth = 1
		selectASignInMethodLabel.layer.cornerRadius = 5
		
		signInBtn.layer.borderWidth = 1
		signInBtn.layer.cornerRadius = 5
		//
		
		
	}

}

