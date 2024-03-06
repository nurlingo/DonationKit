//
//  SupportOptionsController.swift
//  DonationKit
//
//  Created by Daniya on 03/07/2022.
//

import UIKit

public class DonateOptionController: UIViewController {
    
    let config: PurchaseConfiguration
    
    public init(config: PurchaseConfiguration) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var statementView: StatementView = {
        let view = StatementView(config: config)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var subscribeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(config.primaryButtonTitle, for: UIControl.State())
        
        if config.primaryButtonFontName.isEmpty {
            button.titleLabel?.font = UIFont.systemFont(ofSize: config.primaryButtonFontSize, weight: .semibold)
        } else {
            button.titleLabel?.font = UIFont(name: config.primaryButtonFontName, size: config.primaryButtonFontSize)
        }
        
        button.setTitleColor(UIColor(rgb: config.primaryButtonTitleHexColor), for: .normal)
        button.backgroundColor = UIColor(rgb: config.primaryButtonBackgroundHexColor)
        button.layer.cornerRadius = 10

        button.addTarget(self, action: #selector(subscribeButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var alternativesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        if config.titleLabelFontName.isEmpty {
            label.font = UIFont.systemFont(ofSize: config.titleLabelFontSize-3, weight: .medium)
        } else {
            label.font = UIFont(name: config.titleLabelFontName, size: config.titleLabelFontSize-3)
        }
        label.textColor = UIColor(rgb: config.titleLabelHexColor)
        
        label.text = config.successTitleText
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var donateOnceButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(config.secondaryButtonTitle, for: UIControl.State())
        
        if config.secondaryButtonFontName.isEmpty {
            button.titleLabel?.font = UIFont.systemFont(ofSize: config.secondaryButtonFontSize, weight: .regular)
        } else {
            button.titleLabel?.font = UIFont(name: config.secondaryButtonFontName, size: config.secondaryButtonFontSize)
        }
        
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        button.setTitleColor(UIColor(rgb: config.secondaryButtonTitleHexColor), for: .normal)
        button.backgroundColor = UIColor(rgb: config.secondaryButtonBackgroundHexColor)
        button.layer.cornerRadius = 10

        button.addTarget(self, action: #selector(donateOnceButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
                
        setupViews()
        
    }
    
    private func setupViews() {
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.view.backgroundColor = UIColor(rgb: config.backgroundHexColor)
        self.view.addSubview(cardView)
        self.cardView.addSubview(statementView)
        self.cardView.addSubview(subscribeButton)
        self.view.addSubview(alternativesLabel)
        self.view.addSubview(donateOnceButton)

        if #available(iOS 11.0, *) {
            self.cardView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        } else {
            self.cardView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 8).isActive = true
        }
        
        self.cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        self.cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        self.cardView.heightAnchor.constraint(equalTo: cardView.widthAnchor, constant: 0).isActive = true
        self.cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        
        self.statementView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16).isActive = true
        self.statementView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0).isActive = true
        self.statementView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 0).isActive = true
        self.statementView.bottomAnchor.constraint(lessThanOrEqualTo: subscribeButton.topAnchor, constant: -2).isActive = true
        
        self.subscribeButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16).isActive = true
        self.subscribeButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16).isActive = true
        self.subscribeButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.subscribeButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -24).isActive = true
        
        self.alternativesLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 32).isActive = true
        self.alternativesLabel.leadingAnchor.constraint(equalTo: self.cardView.leadingAnchor, constant: 4).isActive = true
        self.alternativesLabel.trailingAnchor.constraint(equalTo: self.cardView.trailingAnchor, constant: -4).isActive = true
        self.alternativesLabel.bottomAnchor.constraint(equalTo: donateOnceButton.topAnchor, constant: -8).isActive = true
        
        self.donateOnceButton.widthAnchor.constraint(equalTo: cardView.widthAnchor, constant: 0).isActive = true
        self.donateOnceButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.donateOnceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        if #available(iOS 11.0, *) {
            self.donateOnceButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -44).isActive = true
        } else {
            self.donateOnceButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -24).isActive = true
        }
    }
    
    @objc private func subscribeButtonPressed(_ sender: AnyObject) {
        config.successAction?()
    }
    
    @objc private func donateOnceButtonPressed() {
        config.secondaryAction?()
    }
    
}
