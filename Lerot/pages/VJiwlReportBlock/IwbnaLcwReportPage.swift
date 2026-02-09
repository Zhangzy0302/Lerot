import SwiftUI

struct IwbnaLcwReportPage: View {
    
    let iwbnalcmReasonList = [
        "Indecent content",
        "Personal attack",
        "Harassing private message",
        "Infringement",
        "Bloody horror",
        "Others"
    ]
    
    @State private var iwanvSeletedReason: String = ""
    @EnvironmentObject var lwbanlNavi: NavigationManager
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geo in
              Image("cponlzna_main_bg")
                .resizable()
                .frame(maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()
            }
            VStack(spacing: 0){
                VNauwAUWTopBar() {
                    HStack(spacing: 3){
                        Image("cponlzna_report_alert")
                            .resizable()
                            .frame(width: 85, height: 85)
                        Text("Report")
                            .font(LerWifaTheme.LerotFont.baigo(35))
                            .foregroundColor(.black)
                    }
                }
                ZStack{
                    ZStack{
                        Text("Select the report option")
                            .font(LerWifaTheme.LerotFont.baigo(20))
                            .offset(x: 1, y: 1)
                        Text("Select the report option")
                            .font(LerWifaTheme.LerotFont.baigo(20))
                            .offset(x: -1, y: 1)
                        Text("Select the report option")
                            .font(LerWifaTheme.LerotFont.baigo(20))
                            .offset(x: 1, y: -1)
                        Text("Select the report option")
                            .font(LerWifaTheme.LerotFont.baigo(20))
                            .offset(x: -1, y: -1)
                    }.foregroundColor(LerWifaTheme.Color.mainPurple)
                    Text("Select the report option")
                        .font(LerWifaTheme.LerotFont.baigo(20))
                        .foregroundColor(.white)
                }.padding(.top, 30)
                    .padding(.bottom, 20)
                
                VStack(spacing: 12){
                    ForEach(iwbnalcmReasonList, id: \.self) {
                        IwnaviReportItem(iwnakSeleted: $iwanvSeletedReason, iwanxaiReason: $0)
                    }
                }.padding(.bottom, 80)
                RyyeuaButton(ryyeuaText: "submit", ryyeaAction: {
                    if(iwanvSeletedReason.isEmpty){
                        LealoeoHUD.error("Please select the reason for reporting")
                        return
                    }
                    LealoeoHUD.success("Report successful")
                    lwbanlNavi.pop()
                })
            }
        }.navigationBarHidden(true)
        
    }
    
    private struct IwnaviReportItem: View {
        @Binding var iwnakSeleted: String
        let iwanxaiReason: String
        
        var body: some View {
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    iwanxaiReason == iwnakSeleted ? LerWifaTheme.Color.mainPurple : .black.opacity(0.4)
                ).frame(height: 50)
                .overlay{
                    Text(iwanxaiReason)
                        .font(LerWifaTheme.LerotFont.miSans(16))
                        .foregroundColor(.white)
                }.padding(.horizontal, 30)
                .onTapGesture {
                    withAnimation(.easeOut(duration: 0.24)) {
                        iwnakSeleted = iwanxaiReason
                    }
                }
                
        }
    }
}
