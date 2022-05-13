import SwiftUI
import AuthenticationServices
struct SignUpWithAppleView: UIViewRepresentable {
   @Binding var username : String
    @Binding var mail : String
    @Binding var surname : String
   func makeCoordinator() -> AppleSignUpCoordinator {
      return AppleSignUpCoordinator(self)
   }
func makeUIView(context: Context) -> ASAuthorizationAppleIDButton    {
   //Creating the apple sign in button
let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn,
   authorizationButtonStyle: .black)
   button.cornerRadius = 10
//Adding the tap action on the apple sign in button
   button.addTarget(context.coordinator, action: #selector(AppleSignUpCoordinator.didTapButton),for: .touchUpInside)
return button
}
func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
}
}
