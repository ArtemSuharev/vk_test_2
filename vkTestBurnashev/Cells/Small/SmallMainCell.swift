//
//  MainCell.swift
//  vkTestBurnashev
//
//  Created by T BURNASHEVA on 05.09.2024.
//

import UIKit

class SmallMainCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    var index = 0
    
    @IBOutlet weak var contentViewCell: UIView!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleCell: UILabel!
    
    weak var delegate: DelegateSmallMainCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(index: Int, data: AppsList) {
        
        self.index = index
        
//        self.contentViewCell.addTapGestureRecognizer(isTapAnimation: true) { [weak self] in
//            self!.touchView()
//        }
        
        titleCell.text = data.name
        imageCell.image = data.image
        
    }
    
    @objc func touchView() {
        delegate?.clickSmallCell(indexPath: IndexPath(row: index, section: 0))
    }

    
}
