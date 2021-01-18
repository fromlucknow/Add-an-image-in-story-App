//
//  ImageCollectionViewCell.swift
//  Edunomics App
//
//  Created by Saifur Rahman on 15/01/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var View_for_image: UIView!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        View_for_image.layer.cornerRadius = View_for_image.frame.height/2
    }

}
