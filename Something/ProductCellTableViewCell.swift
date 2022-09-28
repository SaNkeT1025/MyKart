//
//  ProductCellTableViewCell.swift
//  Something
//
//  Created by Capgemini-DA067 on 9/23/22.
//

import UIKit

class ProductCellTableViewCell: UITableViewCell {
    
    // added outlets of the custom cell

    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productDescription: UILabel!
    
    @IBOutlet weak var addToCartButton: UIButton!
    
    @IBOutlet weak var goToPlaceOrder: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
