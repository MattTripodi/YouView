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
import SwiftKeychainWrapper

class SignInVC: UIViewController, UITextFieldDelegate {
	
	//IBOutlets
	@IBOutlet weak var emailField: CustomTextField!
	@IBOutlet weak var passwordField: CustomTextField!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// To hide the keyboard when return is pressed or the user touches outside of the keyboard
		self.hideKeyboard()
		self.emailField.delegate = self
		self.passwordField.delegate = self
		//
	}
	
	override func viewDidAppear(_ animated: Bool) {
		if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
			print("MATT: ID found in keychain")
			performSegue(withIdentifier: "goToFeed", sender: nil)
		}
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
				if let user = user {
					let userData = ["provider": credential.provider]
					self.completeSignIn(id: user.uid, userData: userData)
				}
			}
		}
	}
	
	@IBAction func signInTapped(_ sender: Any) {
		if let email = emailField.text, let password = passwordField.text {
			Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
				if error == nil {
					print("MATT: Email User authenticated with Firebase")
					if let user = user {
						let userData = ["provider": user.providerID]
						self.completeSignIn(id: user.uid, userData: userData)
					}
				} else {
					Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
						if error != nil {
							print("Matt: Unable to authenticate with Firebase using email")
						} else {
							print("MATT: Successfully authenticated with Firebase")
							if let user = user {
								let userData = ["provider": user.providerID]
								self.completeSignIn(id: user.uid, userData: userData)
							}
						}
					})
				}
			})
		}
	}
	
	func completeSignIn(id: String, userData: Dictionary<String, String>) {
		DataService.ds.createFirbaseDBUser(uid: id, userData: userData)
		let keychainResult = KeychainWrapper.standard.set(id , forKey: KEY_UID)
		print("MATT: Data saved to keychain \(keychainResult)")
		performSegue(withIdentifier: "goToFeed", sender: nil)
	}
	

}

extension UIViewController
{
	func hideKeyboard()
	{
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(
			target: self,
			action: #selector(UIViewController.dismissKeyboard))
		
		view.addGestureRecognizer(tap)
	}
	
	func dismissKeyboard()
	{
		view.endEditing(true)
	}
	
	// To dismiss keyboard when return is pressed
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.view.endEditing(true)
		return false
	}
}























