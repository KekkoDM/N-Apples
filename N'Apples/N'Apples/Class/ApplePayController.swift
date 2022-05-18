

import Foundation
import PassKit
import SwiftUI
class PaymentHandler: NSObject, ObservableObject {
    func startPayment(paymentSummaryItems: [PKPaymentSummaryItem]) {
        
        // Create our payment request
        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        paymentRequest.merchantIdentifier = "merchant.com.simonaettari.N-Apples"
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.countryCode = "IT"
        paymentRequest.currencyCode = "EUR"
        paymentRequest.requiredShippingContactFields = [.phoneNumber, .emailAddress]
        paymentRequest.supportedNetworks = [.masterCard, .visa]
        
        // Display our payment request
        let paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController.delegate = self
        paymentController.present(completion: { (presented: Bool) in })
    }
    
}


/**
 PKPaymentAuthorizationControllerDelegate conformance.
 */
extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {

    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        completion(.success)
        print("paymentAuthorizationController completion(.success)")
    }

    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        print("DidFinish")
        controller.dismiss()
        
    }
    
    func paymentAuthorizationControllerWillAuthorizePayment(_ controller: PKPaymentAuthorizationController) {
        print("WillAuthorizePayment")
    }

}

struct PaymentButton: UIViewRepresentable {
    func updateUIView(_ uiView: PKPaymentButton, context: Context) { }
    
    func makeUIView(context: Context) -> PKPaymentButton {
        return PKPaymentButton(paymentButtonType: .plain, paymentButtonStyle: .automatic)
    }
}
