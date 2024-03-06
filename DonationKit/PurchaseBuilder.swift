import Foundation

public class PurchaseBuilder {
    public let view: PurchaseViewDelegate
    public let presenter: PurchasePresenter
    
    public init(analytics: AbstractAnalytics?,
                purchaseProductIdentifiers: [ProductIdentifier],
                config: PurchaseConfiguration?) {
        
        self.presenter = PurchasePresenter(
            analytics: analytics,
            purchaseProductIdentifiers: purchaseProductIdentifiers,
            config: config
        )
        
        self.view = PurchaseController(presenter: presenter)
    }
}

