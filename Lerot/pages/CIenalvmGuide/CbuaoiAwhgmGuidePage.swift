import SwiftUI

struct CbuaoiAwhgmGuidePage: View {
  @AppStorage("ucwiaxIsAgree") var ucwiaxIsAgree: Bool = false
    @EnvironmentObject private var cbuaoNavi: NavigationManager

  var body: some View {
    ZStack(alignment: .bottom) {
      GeometryReader { geo in
        Image("cponlzna_guide_bg")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(maxHeight: .infinity)
          .clipped()
          .ignoresSafeArea()
      }
      LinearGradient(
        colors: [
          Color(red: 1, green: 142 / 255, blue: 238 / 255),
          .white.opacity(0),
        ], startPoint: .bottom, endPoint: .top
      )
      .ignoresSafeArea()
      VStack(spacing: 0) {
        Image("cponlzna_app_logo").resizable()
          .frame(width: 79, height: 79)
          .cornerRadius(16.63)
          .padding(.bottom, 20)
        Text("Welcome to LEROT")
          .font(LerWifaTheme.LerotFont.neoneon(48))
          .foregroundColor(.white)
          .padding(.bottom, 53)
        VStack(alignment: .trailing, spacing: 0) {
          Button(action: {
              if(!UWhwbvnzAppState.ucwiaxIsAgree){
                  LealoeoHUD.toast("Please read and agree to the agreement first")
                  return
              }
              cbuaoNavi.push(VeulaNwiAppRoute.sign(vealcStatus: ZwiaqhonSignPageStatus.zwiaaLoagin))
          }) {
            HStack(spacing: 28) {
              Image("cponlzna_email")
                .resizable()
                .frame(width: 24, height: 24)
              Text("Login by email")
                .font(LerWifaTheme.LerotFont.baigo(16))
                .foregroundColor(.black)
            }
            .frame(width: 241, height: 58)
            .background(
              RoundedRectangle(cornerRadius: 66)
                .fill(LerWifaTheme.Color.mainYellow)
                .overlay(
                  RoundedRectangle(cornerRadius: 66)
                    .strokeBorder(Color.white, lineWidth: 1)
                ).shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
            )
          }.padding(.bottom, 20)

          Button(action: {
              if(!UWhwbvnzAppState.ucwiaxIsAgree){
                  LealoeoHUD.toast("Please read and agree to the agreement first")
                  return
              }
              
          }) {
            HStack(spacing: 46) {
              Image("cponlzna_user")
                .resizable()
                .frame(width: 24, height: 24)
              Text("I'm new")
                .font(LerWifaTheme.LerotFont.baigo(16))
                .foregroundColor(.white)
            }
            .frame(width: 241, height: 58)
            .background(
              RoundedRectangle(cornerRadius: 66)
                .fill(LerWifaTheme.Color.mainPurple)
                .overlay(
                  RoundedRectangle(cornerRadius: 66)
                    .strokeBorder(Color.white, lineWidth: 1)
                ).shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
            )
          }
          HStack(spacing: 0) {
            Text("Don't have an account? ")
              .font(LerWifaTheme.LerotFont.miSans(14))
            Text("Sign up")
              .font(LerWifaTheme.LerotFont.miSans(14))
              .underline()
              .onTapGesture {
                  if(!UWhwbvnzAppState.ucwiaxIsAgree){
                      LealoeoHUD.toast("Please read and agree to the agreement first")
                      return
                  }
                  cbuaoNavi.push(VeulaNwiAppRoute.sign(vealcStatus: ZwiaqhonSignPageStatus.zwiaaSignUp))
              }
          }.padding(.top, 13)
        }

        HStack {
          Button(action: {
            withAnimation(.easeInOut) {
              ucwiaxIsAgree = !ucwiaxIsAgree
            }
          }) {
            Image(systemName: ucwiaxIsAgree ? "checkmark.square.fill" : "square")
              .foregroundColor(LerWifaTheme.Color.mainPurple)
          }
          HStack(spacing: 0) {
            Text("Agree with ")
              .font(LerWifaTheme.LerotFont.miSans(14))
            Text("User Agreement")
              .font(LerWifaTheme.LerotFont.miSans(14))
              .underline()
              .onTapGesture {
                  cbuaoNavi.push(VeulaNwiAppRoute.agreementWeb(webUrl: "https://app.ul5exwgd.link/users"))
              }
            Text(" and ")
              .font(LerWifaTheme.LerotFont.miSans(14))
            Text("Privacy Policy")
              .font(LerWifaTheme.LerotFont.miSans(14))
              .underline()
              .onTapGesture {
                  cbuaoNavi.push(VeulaNwiAppRoute.agreementWeb(webUrl: "https://app.ul5exwgd.link/privacy"))
              
              }

          }
        }.padding(.top, 24)
      }.padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
  }
}
