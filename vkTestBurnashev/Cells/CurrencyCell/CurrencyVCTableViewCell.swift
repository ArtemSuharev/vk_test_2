//
//  CurrencyVCTableViewCell.swift
//  vkTestBurnashev
//
//  Created by T BURNASHEVA on 07.09.2024.
//

import UIKit

class CurrencyVCTableViewCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var imageFlag: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(index: Int, data: GlobalRates) {
        
        imageFlag.image = UIImage(named: "\(data.index)") ?? UIImage(named: ImagesName.defaultImages)!
        if data.rate != 0 {
            let rate: Double = 1 / data.rate
            label.text = "1 " + data.index + " = " + roundTosignificantNumber(rate, to: 3) + " руб."
        }
        
    }
    
    func roundTosignificantNumber(_ num: Double, to places: Int) -> String {
        if num == 0 || num.isNaN || num.isInfinite {
            return "0"
        } else {
            let p = log10(abs(num))
            let f = (1 / pow(10, p.rounded() - Double(places) + 1)).rounded(.up)
            let r = Double(Int((num * f).rounded()))
            let rnum = r / f
            return String(rnum)
        }
    }
    
}
