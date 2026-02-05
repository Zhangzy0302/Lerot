import SwiftUI

struct OwzmwpdRecordHistory: View {
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geo in
              Image("cponlzna_main_bg")
                .resizable()
                .frame(maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()
            }
            VStack {
                VNauwAUWTopBar() {
                    MwunzArtTitle(title: "History", width: 101, mwuIsShowStar: false)
                }
                ScrollView {
                    LazyVStack {
                        ForEach(0...2, id: \.self) { i in
                            OwauzmpsdCard()
                        }
                    }
                }
            }
        }.navigationBarHidden(true)
    }
    
    private struct OwauzmpsdCard: View {
        var body: some View {
            HStack(spacing: 18){
                VStack(spacing: 0){
                    Circle().fill(LerWifaTheme.Color.mainPurple)
                        .frame(width: 12)
                    Path { path in
                                path.move(to: CGPoint(x: 0, y: 0))
                                path.addLine(to: CGPoint(x: 0, y: 378))
                            }
                            .stroke(
                                Color(red: 166 / 255, green: 166 / 255, blue: 166 / 255),
                                style: StrokeStyle(
                                    lineWidth: 1,
                                    lineCap: .round,
                                    dash: [3, 4] // 实线长度，间隔长度
                                )
                            )
                            .frame(width: 1, height: 378)
                }
                VStack(alignment: .leading, spacing: 10){
                    ZStack(alignment: .topLeading){
                        HStack(spacing: 10){
                            Text("1h 30min")
                                .font(LerWifaTheme.LerotFont.baigo(12))
                                .foregroundColor(LerWifaTheme.Color.mainPurple)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                                )
                            Text("Status: 4 points")
                                .font(LerWifaTheme.LerotFont.baigo(12))
                                .foregroundColor(LerWifaTheme.Color.mainYellow)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                                )
                        }
                    }.frame(maxHeight: .infinity)
                    Text("When applying force from the tip of the bow, slightly increase the pressure. After slow practice, the force should be evenly distributed")
                        .font(LerWifaTheme.LerotFont.miSans(12))
                        .foregroundColor(.white.opacity(0.9))
                }.padding(.horizontal, 10)
                    .padding(.top, 10)
                    .padding(.bottom, 16)
                    .frame(height: 357)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255))
                    )
            }.padding(.horizontal, 20)
        }
    }
}

#Preview {
    OwzmwpdRecordHistory()
}
