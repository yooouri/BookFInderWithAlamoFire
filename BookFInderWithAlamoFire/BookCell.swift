//
//  BookCell.swift
//  BookFInderWithAlamoFire
//
//  Created by yuri on 2022/11/03.
//

import UIKit

class BookCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var publisher: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var sw: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
