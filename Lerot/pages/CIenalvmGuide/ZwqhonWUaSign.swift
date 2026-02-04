import SwiftUI

enum ZwiaqhonSignPageStatus: Hashable {
   case zwiaaLoagin
    case zwiaaSignUp
    case zwiaaForgotPwd
}

struct ZwqhonWUaSign: View {
    @EnvironmentObject var ciwaNavi: NavigationManager
    @State private var zwqhonCurrentStatus: ZwiaqhonSignPageStatus

  @State private var zwiajjaEmail: String = ""
  @State private var zwiajjaPassword: String = ""
  @State private var zwiajjaRepassword: String = ""

  @FocusState private var zwiafjIsFocused_1: Bool
  @FocusState private var zwiafjIsFocused_2: Bool
  @FocusState private var zwiafjIsFocused_3: Bool
    
    init(initialStatus: ZwiaqhonSignPageStatus) {
        self._zwqhonCurrentStatus = State(initialValue: initialStatus)
    }
    
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
          HStack{
              Spacer()
              Text("FORGOT?")
                  .font(LerWifaTheme.LerotFont.baigo(16))
                  .padding(.top, 20)
          }
          
          RyyeuaButton(ryyeuaWidth: 233, ryyeuaHeight: 57, ryyeuaText: "Sign in", ryyeuaFontSize: 24, ryyeaAction: {
              ciwaNavi.popToRoot()
              ciwaNavi.push(VeulaNwiAppRoute.mainNav)
          })
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
                ZStack(alignment: .leading){
                    TextField("", text: $inputText)
                          .focused($ziwaIsFocus)
                          .font(LerWifaTheme.LerotFont.miSans(14))
                          .textInputAutocapitalization(.never)
                          .tint(.white)
                          .font(LerWifaTheme.LerotFont.miSans(14))
                          .foregroundColor(.white)
                    if(!ziwaIsFocus){
                        Text(zwialjPlaceholder)
                            .font(LerWifaTheme.LerotFont.miSans(14))
                            .foregroundColor(.white)
                    }
                    
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Color(red: 1, green: 6 / 255, blue: 211 / 255).opacity(0.13))
                .cornerRadius(10)
                
            }
        }
    }
}
