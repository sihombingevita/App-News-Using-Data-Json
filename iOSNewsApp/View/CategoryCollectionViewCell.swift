//
//  CategoryCollectionViewCell.swift
//  iOSNewsApp
//
//  Created by Evita Sihombing on 27/02/24.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var labelCategory: UILabel!
    
    override var isSelected: Bool {
        didSet {
            layer.borderColor = isSelected ? UIColor.red.cgColor : UIColor.clear.cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundCellView.layer.borderWidth = 1.0
        backgroundCellView.layer.cornerRadius = 5.0
        backgroundCellView.layer.masksToBounds = true
    }
}
