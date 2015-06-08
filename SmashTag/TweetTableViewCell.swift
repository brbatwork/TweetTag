//
//  TweetTableViewCell.swift
//  SmashTag
//
//  Created by Bill Barbour on 6/7/15.
//  Copyright (c) 2015 SograSoftware LLC. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }

    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!

    @IBOutlet weak var tweetScreenName: UILabel!
    
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    
    func updateUI() {
        tweetTextLabel?.attributedText = nil
        tweetScreenName?.text = nil
        tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil
        
        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            
            if tweetTextLabel?.text != nil {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            }
            
            tweetScreenName?.text = "\(tweet.user)"
            
            // Set profile image
            if let profileImageURL = tweet.user.profileImageURL {
                // TODO: Get this off the main thread
                if let imageData = NSData(contentsOfURL: profileImageURL) {
                    tweetProfileImageView?.image = UIImage(data: imageData)
                }
            }
            
            // Set created Date
            let formatter = NSDateFormatter()
            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            } else {
                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            }
            
            tweetCreatedLabel?.text = formatter.stringFromDate(tweet.created)
            
        }
        
        
    }
}
