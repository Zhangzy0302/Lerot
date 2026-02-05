import SwiftUI

struct AsuwatpUploadVideo: View {
    @State private var mrlnzlPracticeDuration: String = ""
    @State private var mrlnalWantToSay: String = ""
    @FocusState private var mrlanxIsFocus_1: Bool
    @FocusState private var mrlanxIsFocus_2: Bool
    
    @EnvironmentObject var asuwaNavi: NavigationManager
    
    var body: some View {
        ZStack(alignment: .top){
            GeometryReader { geo in
              Image("cponlzna_main_bg")
                .resizable()
                .frame(maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()
            }
            VStack {
                VNauwAUWTopBar() {
                    Image("cponlzna_up_logo")
                        .resizable()
                        .frame(width: 102, height: 65)
                }
                ScrollView {
                    VStack(alignment: .leading, spacing: 20){
                        VStack(alignment: .leading, spacing: 16){
                            Text("Title:")
                                .font(LerWifaTheme.LerotFont.baigo(18))
                                .foregroundColor(.black)
                            NbykzwTextFiled(nbykzInputText: $mrlnzlPracticeDuration, nbykzIsFocus: $mrlanxIsFocus_1, nbykzPlaceholder: "Enter...")
                        }
                        VStack(alignment: .leading, spacing: 16){
                            Text("Copywriting:")
                                .font(LerWifaTheme.LerotFont.baigo(18))
                                .foregroundColor(.black)
                            NbykzwTextFiled(nbykzInputText: $mrlnalWantToSay, nbykzIsFocus: $mrlanxIsFocus_2, nbykzPlaceholder: "Enter...", nbykzHeight: 132)
                        }
                        VStack(alignment: .leading, spacing: 16){
                            Text("Video:")
                                .font(LerWifaTheme.LerotFont.baigo(18))
                                .foregroundColor(.black)
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 1)
                                }.overlay{
                                    Image(systemName: "plus.circle")
                                        .font(.system(size: 20))
                                        .foregroundColor(LerWifaTheme.Color.mainPurple)
                                }
                        }
                    }.padding(.horizontal, 20)
                }
            }
            VStack{
                Spacer()
                RyyeuaButton(ryyeuaWidth: 193, ryyeuaHeight: 48, ryyeuaText: "Upload", ryyeuaIsGradient: false, ryyeaAction: {})
            }
        }.navigationBarHidden(true)
            .onTapGesture {
                mrlanxIsFocus_1 = false
                mrlanxIsFocus_2 = false
            }
    }
}
