//
//  UserTableViewCell.swift
//  ChatChat
//
//  Created by Angela Zhang on 9/10/19.
//  Copyright © 2019 qinyuanzhang.com. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    var indexPath : IndexPath!
    let tapGestureRecognizer = UITapGestureRecognizer()
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        tapGestureRecognizer.addTarget(self, action: #selector(self.avatarTap))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
    func generateCellWithNewUser (fUser: FUser, indexPath: IndexPath){
        self.indexPath = indexPath
        
        self.fullNameLabel.text = fUser.fullname
        
        if fUser.avatar != "" {
            imageFromData(pictureData: fUser.avatar) { (avatarImage) in
                if avatarImage != nil {
                    self.avatarImageView.image = avatarImage! .circleMasked
                }
            }
        }
        
    }
    func avatarTap(){
        print("\(indexPath) tapped")
    }
}
