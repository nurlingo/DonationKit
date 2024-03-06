//
//  Protocols.swift
//  namaz
//
//  Created by Bekzhan Talgat on 09.11.2021.
//  Copyright © 2021 Nursultan Askarbekuly. All rights reserved.
//

import Foundation

public protocol AbstractAnalytics {
    func logEvent(_ eventName: String, properties: [String:Any]?)
    func setUserProperty(_ property: String, value: Any)
}

public protocol PurchaseViewDelegate: AnyObject {
    func startLoadingAnimation()
    func stopLoadingAnimation()
    func showPurchaseViews()
    func showFailureViews()
    func showSuccessController()
    func pop()
}
