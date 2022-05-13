import SwiftUI
import AuthenticationServices
class AppleSignUpCoordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
var parent: SignUpWithAppleView?
init(_ parent: SignUpWithAppleView) {
      self.parent = parent
      super.init()
   }
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    let vc = UIApplication.shared.windows.last?.rootViewController
       return (vc?.view.window!)!
    }
    //If authorization is successfull then this method will get triggered
    func authorizationController(controller: ASAuthorizationController,
    didCompleteWithAuthorization authorization: ASAuthorization)
    {
       guard let credentials = authorization.credential as?ASAuthorizationAppleIDCredential else
       {
           print("credentials not found….")
          return
       }
       
       //Storing the credential in user default for demo purpose only    ideally we should have store the credential in Keychain
    let defaults = UserDefaults.standard
        defaults.set(credentials.user, forKey: "userId" )
        parent?.username = "\(credentials.fullName?.givenName ?? "" ) "
        parent?.mail = "\(credentials.email ?? "" ) "
        parent?.surname = "\(credentials.user.description ?? "" ) "

    }
    //If authorization faced any issue then this method will get triggered
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
       //If there is any error will get it here
    }
    @objc func didTapButton() {
    //Create an object of the ASAuthorizationAppleIDProvider
       let appleIDProvider = ASAuthorizationAppleIDProvider()
       //Create a request
       let request = appleIDProvider.createRequest()
       //Define the scope of the request
       request.requestedScopes = [.fullName, .email]
       //Make the request
       let authorizationController =
    ASAuthorizationController(authorizationRequests: [request])
    authorizationController.presentationContextProvider = self
       authorizationController.delegate = self
       authorizationController.performRequests()
    }
}
