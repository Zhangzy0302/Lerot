import SwiftUI

struct MrlnzlaUploadRecord: View {
    @State private var mrlnzlPracticeDuration: String = ""
    @State private var mrlnalWantToSay: String = ""
    @FocusState private var mrlanxIsFocus_1: Bool
    @FocusState private var mrlanxIsFocus_2: Bool
    
    let mralnStatusEmoji: [String] = [
        "cponlzna_status_0",
        "cponlzna_status_1",
        "cponlzna_status_2",
        "cponlzna_status_3",
        "cponlzna_status_4"
    ]
    @State private var mralnSeletedStatus: Int = 0
    
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
                    Image("cponlzna_up_logo")
                        .resizable()
                        .frame(width: 102, height: 65)
                }
                ScrollView {
                    VStack(alignment: .leading, spacing: 20){
                        VStack(alignment: .leading, spacing: 16){
                            Text("Practice duration:")
                                .font(LerWifaTheme.LerotFont.baigo(18))
                                .foregroundColor(.black)
                            NbykzwTextFiled(nbykzInputText: $mrlnzlPracticeDuration, nbykzIsFocus: $mrlanxIsFocus_1, nbykzPlaceholder: "hh:mm")
                        }
                        VStack(alignment: .leading, spacing: 16){
                            Text("Practice duration:")
                                .font(LerWifaTheme.LerotFont.baigo(18))
                                .foregroundColor(.black)
                            HStack{
                                ForEach(0..<mralnStatusEmoji.count, id: \.self) { statusIndex in
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 58)
                                        .overlay{
                                            Circle().stroke(LerWifaTheme.Color.mainPurple, lineWidth: statusIndex == mralnSeletedStatus ? 4 : 1)
                                        }
                                        .overlay{
                                            Image(mralnStatusEmoji[statusIndex])
                                                .resizable()
                                                .frame(width: 37, height: 20)
                                        }.onTapGesture{
                                            withAnimation(.easeOut) {
                                                mralnSeletedStatus = statusIndex
                                            }
                                        }
                                }
                            }
                        }
                        VStack(alignment: .leading, spacing: 16){
                            Text("Practice duration:")
                                .font(LerWifaTheme.LerotFont.baigo(18))
                                .foregroundColor(.black)
                            NbykzwTextFiled(nbykzInputText: $mrlnalWantToSay, nbykzIsFocus: $mrlanxIsFocus_2, nbykzPlaceholder: "Enter...", nbykzHeight: 132)
                        }
                        VStack(alignment: .leading, spacing: 16){
                            Text("Picture:")
                                .font(LerWifaTheme.LerotFont.baigo(18))
                                .foregroundColor(.black)
                            NbykzwTextFiled(nbykzInputText: $mrlnalWantToSay, nbykzIsFocus: $mrlanxIsFocus_2, nbykzPlaceholder: "Enter...", nbykzHeight: 132)
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

#Preview {
    MrlnzlaUploadRecord()
}
