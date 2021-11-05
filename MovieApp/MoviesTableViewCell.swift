//
//  MoviesTableViewCell.swift
//  MovieApp
//
//  Created by Sharon on 2021/11/3.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var posterPhoto: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
