//
//  PurchaseStorage.swift
//
//  Created by Daniya on 04/11/2021.
//  Copyright © 2021 Nursultan Askarbekuly. All rights reserved.
//

import Foundation

public struct PurchaseStorage {
        
    public static func savePurchase(_ purchaseId: String?) {

        if let purchaseId = purchaseId {
            /// mark purchase with the custom user passed id
            UserDefaults.standard.setValue(true, forKey: purchaseId)
        } else {
            /// mark the generic act of support
            UserDefaults.standard.setValue(true, forKey: "didSupportApp")
        }
        
        UserDefaults.standard.synchronize()

    }
    
    public static func checkPurchase(_ purchaseId: String? = nil) -> Bool {
        
        if let purchaseId = purchaseId {
            /// check purchase with the custom user passed id
            return UserDefaults.standard.bool(forKey:purchaseId)
        } else if UserDefaults.standard.bool(forKey: "didSupportApp") {
            /// check the generic act of support
            return true
        } else {
            return false
        }
    }
}
