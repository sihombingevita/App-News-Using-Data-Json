//
//  HeadlineTableViewCell.swift
//  iOSNewsApp
//
//  Created by Evita Sihombing on 05/03/24.
//

import UIKit

class HeadlineTableViewCell: UITableViewCell {

    @IBOutlet weak var headlineImageView: UIImageView!
    @IBOutlet weak var titleBeritaLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var timestampsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headlineImageView.layer.cornerRadius = 5.0
        headlineImageView.layer.borderColor = UIColor(.black).cgColor
        headlineImageView.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.backgroundColor = .blue
        } else {
            self.backgroundColor = .white
        }
    }
}
