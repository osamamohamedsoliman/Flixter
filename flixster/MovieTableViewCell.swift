//
//  MovieTableViewCell.swift
//  flixster
//
//  Created by Osama Soliman on 2/2/19.
//  Copyright © 2019 Osama Soliman. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var TitleLable: UILabel!
    @IBOutlet var SynLable: UILabel!
    @IBOutlet var PosterView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
