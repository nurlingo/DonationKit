//
//  StatementView.swift
//  DonationKit
//
//  Created by Daniya on 07/07/2022.
//

import Foundation

protocol StatementConfigurable {
    
    var imageName: String {get}

    var titleLabelText: String {get}
    var titleLabelFontName: String {get}
    var titleLabelFontSize: CGFloat {get}
    var titleLabelHexColor: Int {get}
    
    var bodyLabelText: String {get}
    var bodyLabelFontSize: CGFloat {get}
    var bodyLabelFontName: String {get}
    var bodyLabelHexColor: Int {get}

    var backgroundHexColor: Int {get}
}

class StatementView: UIView {
    
    var config: StatementConfigurable!
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: config.imageName)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        if config.titleLabelFontName.isEmpty {
            label.font = UIFont.systemFont(ofSize: config.titleLabelFontSize, weight: .semibold)
        } else {
            label.font = UIFont(name: config.titleLabelFontName, size: config.titleLabelFontSize)
        }
        label.textColor = UIColor(rgb: config.titleLabelHexColor)
        
        label.text = config.titleLabelText
        label.textAlignment = NSTextAlignment.center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        if config.bodyLabelFontName.isEmpty {
            label.font = UIFont.systemFont(ofSize: config.bodyLabelFontSize)
        } else {
            label.font = UIFont(name: config.bodyLabelFontName, size: config.bodyLabelFontSize)
        }
        
        label.textColor = UIColor(rgb: config.bodyLabelHexColor)
        
        label.text = config.bodyLabelText
        label.textAlignment = NSTextAlignment.center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    convenience init(config: StatementConfigurable) {
        self.init()
        self.config = config
        self.setupViews()
    }
    
    private func setupViews() {
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(bodyLabel)
        
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: bodyLabel.topAnchor, constant: -16).isActive = true
        
        self.bodyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        self.bodyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.bodyLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -16).isActive = true
        
    }
    
    func setTitleText(_ text: String) {
        titleLabel.text = text
    }
    
    func setBodyText(_ text: String) {
        bodyLabel.text = text
    }
    
    func setImage(_ imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
    
    func pulsateImage() {
        let scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 1.0
        scaleAnimation.repeatCount = 3.0
        scaleAnimation.autoreverses = true
        scaleAnimation.fromValue = 1.0;
        scaleAnimation.toValue = 1.10;
        self.imageView.layer.add(scaleAnimation, forKey: "scale")
    }
}
