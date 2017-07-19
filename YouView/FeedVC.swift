//
//  FeedVC.swift
//  YouView
//
//  Created by Matt Tripodi on 7/19/17.
//  Copyright © 2017 Matthew Tripodi. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

	@IBAction func signOutPressed(_ sender: Any) {
		//let keychainResult = KeychainWrapper.removeObjectForKey(KEY_UID)
		let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
		print("MATT: ID removed from keychain \(keychainResult)")
		try! Auth.auth().signOut()
		performSegue(withIdentifier: "goToSignIn", sender: nil)
	}
		
}
