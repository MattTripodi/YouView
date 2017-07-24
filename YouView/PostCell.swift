//
//  PostCell.swift
//  YouView
//
//  Created by Matt Tripodi on 7/19/17.
//  Copyright © 2017 Matthew Tripodi. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
	
	@IBOutlet weak var profileImg: UIImageView!
	@IBOutlet weak var usernameLabel: UILabel!
	@IBOutlet weak var postImg: UIImageView!
	@IBOutlet weak var caption: UITextView!
	@IBOutlet weak var likesLbl: UILabel!
	
	var post: Post!
	var likesRef: DatabaseReference!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	func configureCell(post: Post, img: UIImage? = nil) {
		self.post = post
		likesRef = DataService.ds.REF_USER_CURRENT.child("likes").child(post.postKey)
		
		self.caption.text = post.caption
		self.likesLbl.text = "\(post.likes)"
		
		if img != nil {
			self.postImg.image = img
		} else {
			let ref = Storage.storage().reference(forURL: post.imageUrl)
			ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
				if error != nil {
					print("JESS: Unable to download image from Firebase storage")
				} else {
					print("JESS: Image downloaded from Firebase storage")
					if let imgData = data {
						if let img = UIImage(data: imgData) {
							self.postImg.image = img
							FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
						}
					}
				}
			})
		}
		
	}
	
}
