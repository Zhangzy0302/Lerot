import SwiftUI

struct HaudjzahMessagePage:View {
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
                        HStack{
                            Circle().frame(width: 60)
                            VStack(alignment: .leading, spacing: 15){
                                HStack{
                                    Text("Lumina")
                                        .font(LerWifaTheme.LerotFont.baigo(20))
                                    Spacer()
                                    Text("Lumina")
                                        .font(LerWifaTheme.LerotFont.miSans(12))
                                }
                                Text("Greetings! Any new cosplay plans?")
                                    .font(LerWifaTheme.LerotFont.miSans(14))
                                    .foregroundColor(Color(red: 51/255, green: 51/255, blue: 51/255))
                            }
                        }.padding(20)
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(
                Color.white
            )
        }
    }
}

#Preview {
    HaudjzahMessagePage()
}
