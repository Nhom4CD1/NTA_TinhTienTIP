//
//  LichSuThanhToanTableViewCell.swift
//  TinhTienTip
//
//  Created by THANH on 5/31/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit

class LichSuThanhToanTableViewCell: UITableViewCell {
    //khai bao controll

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblBillAmount: UILabel!
    @IBOutlet weak var lblTipAmount: UILabel!
    @IBOutlet weak var lblTipResult: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
