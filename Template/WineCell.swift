//
//  WineCell.swift
//  Template
//
//  Created by Kasey Baughan on 5/22/17.
//  Copyright © 2017 Kasey Baughan. All rights reserved.
//

import UIKit

class WineCell: UITableViewCell {
    
    @IBOutlet weak var wineImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ozLabel: UILabel!

    var wine: Wine? {
        didSet{
            updateUI()
        }
    }
    var indexPath: IndexPath?
    
    func updateUI() {
        guard let wine = wine else {return}
        guard let origIndexPath = indexPath else {
            print("forgot to set index path for item cell!")
            return
        }
        nameLabel.text = wine.name
        descriptionLabel.text = wine.description
        priceLabel.text = wine.price.currency
        //placeholder image
        wine.getImage() {
            [weak weakSelf = self] image, error in
            guard let indexPathAtTimeOfImageDownload = weakSelf?.indexPath else {return}
            //make sure loading the right image to teh right cell
            guard let image = image, indexPathAtTimeOfImageDownload == origIndexPath else {
                weakSelf?.imageView?.image = nil
                return
            }
            weakSelf?.imageView?.image = image
        }
    }

}
