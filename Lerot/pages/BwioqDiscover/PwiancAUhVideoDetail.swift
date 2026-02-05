import SwiftUI

struct PwiancAUhVideoDetail: View {
    @Binding var pwainzcIsShowBlock: Bool
    
    var body: some View {
        GeometryReader{geo in
            ZStack(){
                ZStack{
                    
                }
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                        VStack{
                            Circle().frame(width: 60).padding(.bottom, 24)
                            VStack(spacing: 10){
                                Circle()
                                    .fill(.black.opacity(0.2))
                                    .frame(width: 48, height: 48)
                                    .overlay{
                                        Image("cponlzna_like_fill")
                                            .resizable()
                                            .frame(width: 22, height: 22)
                                    }
                                Text("99")
                                    .font(LerWifaTheme.LerotFont.baigo(16))
                                    .foregroundColor(.white)
                            }.padding(.bottom, 17)
                            VStack(spacing: 10){
                                Circle()
                                    .fill(.black.opacity(0.2))
                                    .frame(width: 48, height: 48)
                                    .overlay{
                                        Image("cponlzna_comment")
                                            .resizable()
                                            .frame(width: 22, height: 22)
                                    }
                                Text("99")
                                    .font(LerWifaTheme.LerotFont.baigo(16))
                                    .foregroundColor(.white)
                            }
                        }
                    }.padding(.bottom, 36)
                    Text("A perfect makeup makes the performance in a drama more realistic.")
                        .font(LerWifaTheme.LerotFont.miSans(16))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                        .padding(.bottom, 20)
                        .background(
                            Color.black.opacity(0.1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .ignoresSafeArea()
                        )
                }
                VNauwAUWTopBar() {
                    Circle().fill(.white)
                        .frame(width: 52)
                        .overlay{
                            Image(systemName: "ellipsis")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 6)
                        }.onTapGesture {
                            pwainzcIsShowBlock = true
                        }
                }
            }
            
        }.navigationBarHidden(true)
    }
}
