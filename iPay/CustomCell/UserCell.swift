//
//  UserCell.swift
//  iPay
//
//  Created by Felipe Miranda on 17/02/21.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(value: User) {
        
        self.userImageView.image = UIImage(named: value.imageName)
        self.nameLabel.text = value.name
    }

}
