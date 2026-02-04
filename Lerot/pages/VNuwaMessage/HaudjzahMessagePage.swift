import SwiftUI

struct HaudjzahMessagePage:View {
    @EnvironmentObject var ciwaNavi: NavigationManager
    
    var body: some View {
        VStack {
            HStack {
                MwunzArtTitle(title: "CHAT", width: 105)
                Spacer()
                    
            }.padding(.horizontal, 20)
                .padding(.top, 6)
                .padding(.bottom, 24)
            VStack {
                ScrollView {
                    LazyVStack{
                        Button(action: {
                            ciwaNavi.push(VeulaNwiAppRoute.viqoanChatRoom)
                        }){
                            HStack{
                                Circle().frame(width: 60)
                                VStack(alignment: .leading, spacing: 15){
                                    HStack{
                                        Text("Lumina")
                                            .font(LerWifaTheme.LerotFont.baigo(20))
                                            .foregroundColor(.black)
                                        Spacer()
                                        Text("03:52 PM")
                                            .font(LerWifaTheme.LerotFont.miSans(12))
                                            .foregroundColor(.black)
                                    }
                                    Text("Greetings! Any new cosplay plans?")
                                        .font(LerWifaTheme.LerotFont.miSans(14))
                                        .lineLimit(1)
                                        .foregroundColor(Color(red: 51/255, green: 51/255, blue: 51/255))
                                }
                            }.padding(20)
                                .border(Color(red: 229 / 255, green: 229 / 255, blue: 229 / 255), width: 1)
                        }
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(
                Color.white
            )
        }.navigationBarHidden(true)
    }
}
