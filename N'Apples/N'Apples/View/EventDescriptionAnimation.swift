

import SwiftUI

struct EventDescriptionAnimation: View {
    @Binding var nameDescription:String
    @State private var isEditingDescription = false
    var body: some View {
        VStack (alignment: .leading){
            Text("Event Description").foregroundColor(.white)
               
                .fontWeight(.semibold)
                .scaleEffect((self.nameDescription == "" && self.isEditingDescription == false) ? 1 : 0.75)
                .offset( y: (self.nameDescription == "" && self.isEditingDescription == false ) ? -5 : -50)
                .offset( x: (self.nameDescription == "" && self.isEditingDescription == false ) ? 0 : -15)
                .padding(.leading)
                .animation(.spring())
               
            TextField("", text: $nameDescription )
                .foregroundColor(.black)
                .padding()
//                .overlay(RoundedRectangle(cornerRadius: 14)
//                            .stroke(Color.black, lineWidth: 3)
//                )
        }
        
            .onTapGesture {
                self.isEditingDescription.toggle()
                if(self.isEditingDescription == false){
                    UIApplication.shared.endEditing()
                }
        }
    }
}
extension UIApplication {
    func DescriptionEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
//struct EventDescriptionAnimation_Previews: PreviewProvider {
//    static var previews: some View {
//        EventDescriptionAnimation()
//    }
//}



