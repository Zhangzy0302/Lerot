import SwiftUI

struct ZwqhonWUaSign: View {
  @Binding var appPath: NavigationPath

  @State private var zwiajjaEmail: String = ""
  @State private var zwiajjaPassword: String = ""
  @State private var zwiajjaRepassword: String = ""

  @FocusState private var zwiafjIsFocused_1: Bool
  @FocusState private var zwiafjIsFocused_2: Bool
  @FocusState private var zwiafjIsFocused_3: Bool

  var body: some View {
    ZStack(alignment: .top) {
      GeometryReader { geo in
        Image("cponlzna_sign_bg")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(maxHeight: .infinity)
          .clipped()
          .ignoresSafeArea()
      }
      VStack {
        Text("sign in")
          .font(LerWifaTheme.LerotFont.neoneon(36))
          .foregroundColor(LerWifaTheme.Color.mainPurple)
          .padding(.top, 72)
          .padding(.bottom, 55)
        VStack(spacing: 30) {
            ZwialjInput(inputText: $zwiajjaEmail, ziwaIsFocus: $zwiafjIsFocused_1,
                        zwialjTitle: "Email:", zwialjPlaceholder: "Enter email address")
            ZwialjInput(inputText: $zwiajjaPassword, ziwaIsFocus: $zwiafjIsFocused_2,
                        zwialjTitle: "Password:", zwialjPlaceholder: "Enter password")
            ZwialjInput(inputText: $zwiajjaRepassword, ziwaIsFocus: $zwiafjIsFocused_3,
                        zwialjTitle: "Password:", zwialjPlaceholder: "Enter password")
        }
          
      }.padding(.horizontal, 20)
        VNauwAUWTopBar()
    }.navigationBarHidden(true)
          .onTapGesture {
              zwiafjIsFocused_1 = false
              zwiafjIsFocused_2 = false
              zwiafjIsFocused_3 = false
          }
  }
    
    private struct ZwialjInput: View {
        @Binding var inputText: String
        @FocusState.Binding var ziwaIsFocus: Bool
        let zwialjTitle: String
        let zwialjPlaceholder: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 7) {
              Text(zwialjTitle)
                .font(LerWifaTheme.LerotFont.baigo(18))
                .foregroundColor(LerWifaTheme.Color.mainPurple)
              TextField(zwialjPlaceholder, text: $inputText)
                    .focused($ziwaIsFocus)
                    .font(LerWifaTheme.LerotFont.miSans(14))
                    .textInputAutocapitalization(.never)
                    .tint(.black)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Color(red: 1, green: 6 / 255, blue: 211 / 255).opacity(0.13))
                .cornerRadius(10)
                .font(LerWifaTheme.LerotFont.miSans(14))
                .foregroundColor(.white)
            }
        }
    }
}

struct Cinlkajd: View {
  @State private var appPath = NavigationPath()

  var body: some View {
    ZwqhonWUaSign(appPath: $appPath)
  }
}

#Preview {
  Cinlkajd()
}
