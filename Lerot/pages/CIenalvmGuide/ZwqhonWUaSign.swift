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
    
    @EnvironmentObject var userVm: LwianzBAwaUserViewModel
    
    init(initialStatus: ZwiaqhonSignPageStatus) {
        self._zwqhonCurrentStatus = State(initialValue: initialStatus)
    }
    
    var zwiancTopTitle: String {
        switch zwqhonCurrentStatus {
        case .zwiaaLoagin:
            return "Sign In"
        case .zwiaaSignUp:
            return "Sign Up"
        case .zwiaaForgotPwd:
            return "forget password"
        }
    }
    var zwiancButtonText: String {
        switch zwqhonCurrentStatus {
        case .zwiaaLoagin:
            return "Sign In"
        case .zwiaaSignUp:
            return "Sign up"
        case .zwiaaForgotPwd:
            return "Savek"
        }
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
        Text(zwiancTopTitle)
          .font(LerWifaTheme.LerotFont.neoneon(36))
          .foregroundColor(LerWifaTheme.Color.mainPurple)
          .padding(.top, 72)
          .padding(.bottom, 55)
        VStack(spacing: 30) {
            ZwialjInput(inputText: $zwiajjaEmail, ziwaIsFocus: $zwiafjIsFocused_1,
                        zwialjTitle: "Email:", zwialjPlaceholder: "Enter email address")
            ZwialjInput(inputText: $zwiajjaPassword, ziwaIsFocus: $zwiafjIsFocused_2,
                        zwialjTitle: "Password:", zwialjPlaceholder: "Enter password")
            if(zwqhonCurrentStatus != .zwiaaLoagin) {
                ZwialjInput(inputText: $zwiajjaRepassword, ziwaIsFocus: $zwiafjIsFocused_3,
                            zwialjTitle: "Password:", zwialjPlaceholder: "Enter password")
            }
            
        }
          if(zwqhonCurrentStatus == .zwiaaLoagin) {
              HStack{
                  Spacer()
                  Text("FORGOT?")
                      .font(LerWifaTheme.LerotFont.baigo(16))
                      .padding(.top, 20)
                      .onTapGesture {
                          withAnimation(.easeOut) {
                              zwqhonCurrentStatus = .zwiaaForgotPwd
                          }
                      }
              }
          }
          
          
          RyyeuaButton(ryyeuaWidth: 233, ryyeuaHeight: 57, ryyeuaText: zwiancButtonText, ryyeuaFontSize: 24, ryyeaAction: {
              if(zwiajjaEmail.isEmpty || zwiajjaPassword.isEmpty || (zwqhonCurrentStatus == ZwiaqhonSignPageStatus.zwiaaLoagin ? false: zwiajjaRepassword.isEmpty)) {
                  LealoeoHUD.toast("The input box cannot be empty")
                  return
              }
              switch zwqhonCurrentStatus {
              case .zwiaaLoagin:
                  let iqonlaMatchUser = userVm.loginByEmailAndPassword(email: zwiajjaEmail, password: zwiajjaPassword)
                  if(iqonlaMatchUser == nil) {
                      LealoeoHUD.error("Email or password error")
                      return
                  }
              case .zwiaaSignUp:
                  if zwiajjaPassword != zwiajjaRepassword {
                      LealoeoHUD.error("Inconsistent repeated password input")
                      return
                  }
                  let owqknmaNewUser: LwianzBAwaUser? = userVm.register(email: zwiajjaEmail, password: zwiajjaPassword)
                  if owqknmaNewUser == nil {
                      LealoeoHUD.error("Email already exists")
                      return
                  }
              case .zwiaaForgotPwd:
                  return
              }
              Task{
                  LealoeoHUD.showLoading()
                  await delay(0.7)
                  LealoeoHUD.hideLoading()
                  ciwaNavi.popToRoot()
                  ciwaNavi.push(VeulaNwiAppRoute.mainNav)
              }
              
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
                          .tint(.black)
                          .font(LerWifaTheme.LerotFont.miSans(14))
                          .foregroundColor(.black)
                    if(!ziwaIsFocus || inputText.isEmpty){
                        Text(zwialjPlaceholder)
                            .font(LerWifaTheme.LerotFont.miSans(14))
                            .foregroundColor(.white)
                            .onTapGesture {
                                ziwaIsFocus = true
                            }
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
