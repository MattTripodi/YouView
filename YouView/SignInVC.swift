//
//  SignInVC.swift
//  YouView
//
//  Created by Matt Tripodi on 7/18/17.
//  Copyright © 2017 Matthew Tripodi. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {
	
	//IBOutlets

	override func viewDidLoad() {
		super.viewDidLoad()
	
	}

	@IBAction func facebookBtnTapped(_ sender: Any) {
		
		let facebookLogin = FBSDKLoginManager()
		
		facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
			if error != nil {
				print("MATT: Unable to authenticate with Facebook - \(error)")
			} else if result?.isCancelled == true {
				print("MATT: User cancelled Facebook authentication")
			} else {
				print("MATT: Successfully authenticated with Facebook")
				let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
				self.firebaseAuth(credential)
			}
		}
	}
	
	func firebaseAuth(_ credential: AuthCredential) {
		Auth.auth().signIn(with: credential) { (user, error) in
			if error != nil {
				print("MATT: Unable to authenticate with Firebase - \(error)")
			} else {
				print("MATT: Successfully authenticated with Firebase")
			}
		}
	}
}

