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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var captionTextField: CustomTextField!
	@IBOutlet weak var imageAdd: UIImageView!
	
	var posts = [Post]()
	var imagePicker: UIImagePickerController!
	static var imageCache: NSCache<NSString, UIImage> = NSCache()
	var imageSelected = false
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// To hide the keyboard
		self.hideKeyboard()
		self.captionTextField.delegate = self
		//
		
		imagePicker = UIImagePickerController()
		imagePicker.allowsEditing = true 
		imagePicker.delegate = self
		
		tableView.delegate = self
		tableView.dataSource = self
		self.tableView.backgroundColor = UIColor(red: 122 / 255, green: 175 / 255, blue: 205 / 255, alpha: 1)
		
		DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
			
			self.posts = []
			
			if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
				for snap in snapshot {
					print("SNAP: \(snap)")
					if let postDict = snap.value as? Dictionary<String, AnyObject> {
						let key = snap.key
						let post = Post(postKey: key, postData: postDict)
						self.posts.append(post)
					}
				}
			}
			self.posts.reverse()
			self.tableView.reloadData()
		})
    }
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return posts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let post = posts[indexPath.row]
		
		if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
			
			if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
				cell.configureCell(post: post, img: img)
			} else {
				cell.configureCell(post: post)
			}
			return cell
		} else {
			return PostCell()
		}
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
			imageAdd.image = image
			imageSelected = true 
		} else {
			print("MATT: A valid image wasn't selected")
		}
		imagePicker.dismiss(animated: true, completion: nil)
	}
	
	func postErrorAlert() {
		let alert = UIAlertController(title: "Select a photo", message: "Please select a photo from your camera roll. You can tap on the camera icon to select any photo", preferredStyle: UIAlertControllerStyle.alert)
		alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
	
	@IBAction func addImageTapped(_ sender: Any) {
		present(imagePicker, animated: true, completion: nil)
	}
	
	@IBAction func postBtnTapped(_ sender: Any) {
		guard let caption = captionTextField.text, caption != "" || caption == "" else {
			//print("MATT: Caption must be entered")
			return
			
		}
		guard let img = imageAdd.image, imageSelected == true else {
			print("MATT: An image must be selected")
			postErrorAlert()
			return
		}
		
		if let imgData = UIImageJPEGRepresentation(img, 0.2) {
			
			let imgUid = NSUUID().uuidString
			let metadata = StorageMetadata()
			metadata.contentType = "image/jpeg"
			
			DataService.ds.REF_POST_IMAGES.child(imgUid).putData(imgData, metadata: metadata) { (metadata, error) in
				if error != nil {
					print("MATT: Unable to upload image to Firebasee torage")
				} else {
					print("MATT: Successfully uploaded image to Firebase storage")
					let downloadURL = metadata?.downloadURL()?.absoluteString
					if let url = downloadURL {
						self.postToFirebase(imgUrl: url)
					}
				}
			}
		}
	}
	
	func postToFirebase(imgUrl: String) {
		let post: Dictionary<String, AnyObject> = [
			"caption": captionTextField.text! as AnyObject,
			"imageUrl": imgUrl as AnyObject,
			"likes": 0 as AnyObject
		]
		
		let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
		firebasePost.setValue(post)
		
		captionTextField.text = ""
		imageSelected = false
		imageAdd.image = UIImage(named: "add-image-camera")
		
		posts.reverse()
		tableView.reloadData()
	}
	
	@IBAction func signOutPressed(_ sender: Any) {
		let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
		print("MATT: ID removed from keychain \(keychainResult)")
		try! Auth.auth().signOut()
		performSegue(withIdentifier: "goToSignIn", sender: nil)
	}
		
}






















