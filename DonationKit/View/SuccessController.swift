//
//  SuccessController.swift
//  
//
//  Created by Daniya on 25/12/2021.
//

import UIKit
import StoreKit
import SwiftConfettiView

public class SuccessController: UIViewController {
    
    private let purchasePresenter: PurchasePresenter
    
    private var wasNavigationBarHidden: Bool = false
    
    public init(presenter: PurchasePresenter) {
        self.purchasePresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var statementView: StatementView = {
        let view = StatementView(config: purchasePresenter.config)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var confettiView: SwiftConfettiView = {
        let view = SwiftConfettiView(frame: self.view.bounds)
        view.intensity = 1
        return view
    }()
    
    private lazy var proceedButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(purchasePresenter.config.successButtonTitle, for: UIControl.State())
        
        if purchasePresenter.config.primaryButtonFontName.isEmpty {
            button.titleLabel?.font = UIFont.systemFont(ofSize: purchasePresenter.config.primaryButtonFontSize, weight: .semibold)
        } else {
            button.titleLabel?.font = UIFont(name: purchasePresenter.config.primaryButtonFontName, size: purchasePresenter.config.primaryButtonFontSize)
        }
        
        button.setTitleColor(UIColor(rgb: purchasePresenter.config.primaryButtonTitleHexColor), for: .normal)
        
        
        button.backgroundColor = UIColor(rgb: purchasePresenter.config.primaryButtonBackgroundHexColor)
        
        
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(proceedButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.wasNavigationBarHidden = self.navigationController?.isNavigationBarHidden ?? false
        self.navigationController?.isNavigationBarHidden = true
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = self.wasNavigationBarHidden
    }
    
    private func setupViews() {
        
        self.view.backgroundColor = UIColor(rgb: purchasePresenter.config.backgroundHexColor)
        self.view.addSubview(statementView)
        self.view.addSubview(confettiView)
        self.view.addSubview(proceedButton)
        
        statementView.setImage(purchasePresenter.config.successImageName)
        statementView.setTitleText(purchasePresenter.config.successTitleText)
        statementView.setBodyText(purchasePresenter.config.successBodyText)
        
        if #available(iOS 11.0, *) {
            self.statementView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
            self.proceedButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        } else {
            self.statementView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
            self.proceedButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16).isActive = true
        }
        
        self.statementView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        self.statementView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        self.statementView.bottomAnchor.constraint(equalTo: proceedButton.topAnchor, constant: -8).isActive = true
        
        self.proceedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        self.proceedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        self.proceedButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        if purchasePresenter.config.isSuccessImagePulsating {
            self.statementView.pulsateImage()
            self.confettiView.startConfetti()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.confettiView.stopConfetti()
            }
        }
    }
    
    func pop() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func proceedButtonPressed() {
        purchasePresenter.doSuccessAction()
    }
    
}
