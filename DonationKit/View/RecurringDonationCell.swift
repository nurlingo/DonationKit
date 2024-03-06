//
//  RecurringDonationCell.swift
//  DonationKit
//
//  Created by Daniya on 05/07/2022.
//

import UIKit

class RecurringDonationCell: UICollectionViewCell {
        
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
//        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // must call super
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(bodyLabel)
        
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderColor = UIColor.systemGray.cgColor
        self.contentView.layer.borderWidth = 2


        self.iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        self.iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        self.iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor, multiplier: 1).isActive = true
        self.iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: bodyLabel.topAnchor, constant: -4).isActive = true
        
        self.bodyLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0).isActive = true
        self.bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        self.bodyLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
    
    // we have to implement this initializer, but will only ever use this class programmatically
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(colour: UIColor) {
        self.backgroundColor = colour
    }
}
