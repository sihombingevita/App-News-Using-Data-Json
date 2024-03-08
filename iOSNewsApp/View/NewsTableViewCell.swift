//
//  NewsTableViewCell.swift
//  iOSNewsApp
//
//  Created by Evita Sihombing on 29/02/24.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageThumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var btcContainerView: UIView!
    @IBOutlet weak var bbcaContainerView: UIView!
    
    @IBOutlet weak var BTCLabel: UILabel!
    @IBOutlet weak var BBCALabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btcContainerView.layer.cornerRadius = 3.0
        btcContainerView.layer.borderColor = UIColor(.black).cgColor
        btcContainerView.layer.borderWidth = 1.0
        
        bbcaContainerView.layer.cornerRadius = 3.0
        bbcaContainerView.layer.borderColor = UIColor(.black).cgColor
        bbcaContainerView.layer.borderWidth = 1.0
        
        imageThumbnail.layer.cornerRadius = 5.0
        imageThumbnail.layer.borderColor = UIColor(.black).cgColor
        imageThumbnail.layer.borderWidth = 1.0
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
