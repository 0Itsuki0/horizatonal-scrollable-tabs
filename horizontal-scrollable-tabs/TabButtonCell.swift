//
//  ButtonCell.swift
//  horizontal-scrollable-tabs
//
//  Created by Itsuki on 2023/12/18.
//

import UIKit

class TabButtonCell: UICollectionViewCell {
    static let tableCellIdentifier = String(describing: TabButtonCell.self)
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var buttonLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                containerView.backgroundColor = UIColor.link
                containerView.layer.borderColor = UIColor.clear.cgColor
                buttonLabel.textColor = .white
            } else {
                containerView.backgroundColor = UIColor.white
                containerView.layer.borderColor = UIColor.systemGray5.cgColor
                buttonLabel.textColor = .black
            }

        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                containerView.backgroundColor = UIColor.systemGray6
                containerView.layer.borderColor = UIColor.gray.cgColor
                buttonLabel.textColor = .black
            } else {
                containerView.backgroundColor = UIColor.white
                containerView.layer.borderColor = UIColor.gray.cgColor
                buttonLabel.textColor = .black
            }
            
        }
    }
    

    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.layer.borderWidth = 0.6
        containerView.layer.cornerRadius = 16.0
        containerView.layer.masksToBounds = true
        
       
    }

}
