//
//  CategoryCell.swift
//  Something
//
//  Created by Capgemini-DA067 on 9/22/22.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    // outlets of cattegory cell
    @IBOutlet weak var myCategoryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
