import SwiftUI

struct NbykzwTextFiled: View {
    @Binding var nbykzInputText: String
    @FocusState.Binding var nbykzIsFocus: Bool
    
    let nbykzPlaceholder: String
    let nbykzHeight: CGFloat
    
    init(
            nbykzInputText: Binding<String>,
            nbykzIsFocus: FocusState<Bool>.Binding,
            nbykzPlaceholder: String,
            nbykzHeight: CGFloat = 59
        ) {
            self._nbykzInputText = nbykzInputText
            self._nbykzIsFocus = nbykzIsFocus
            self.nbykzPlaceholder = nbykzPlaceholder
            self.nbykzHeight = nbykzHeight
        }

    var body: some View {
        TextField(nbykzPlaceholder, text: $nbykzInputText)
            .focused($nbykzIsFocus)
            .padding(20)
            .tint(.black)
            .font(LerWifaTheme.LerotFont.miSans(14))
            .foregroundColor(.black)
            .frame(height: nbykzHeight, alignment: .top)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .overlay{
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 1)
                    }
            )
    }
}
