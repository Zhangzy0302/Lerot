import SwiftUI
import PhotosUI

struct MrlnzlaUploadRecord: View {
    @State private var mrlnalWantToSay: String = ""
    @FocusState private var mrlanxIsFocus_2: Bool
    
    @State private var duration = Date()
    
    let mralnStatusEmoji: [String] = [
        "cponlzna_status_0",
        "cponlzna_status_1",
        "cponlzna_status_2",
        "cponlzna_status_3",
        "cponlzna_status_4"
    ]
    @State private var mralnSeletedStatus: Int = 0
    
    @State private var hours = 0
    @State private var minutes = 0
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var showAvatarPicker = false
    
    @State private var mrialnImage: String = ""
    
    @EnvironmentObject var mrlnzlaRecordVM: JflawhPracRecordViewModel
    @EnvironmentObject var mrlzNavi: NavigationManager
    
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
                            DurationPicker(hours: $hours, minutes: $minutes)
                                .frame(height: 64)          // Picker 自己舒服的高度
                                .clipped()                   // 🔥 关键
                                .frame(height: 64)           // 外层视觉高度
                                .padding(.horizontal, 15)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.white)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 1)
                                        }
                                )
                        }
                        VStack(alignment: .leading, spacing: 16){
                            Text("Status:")
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
                            Text("Want to say:")
                                .font(LerWifaTheme.LerotFont.baigo(18))
                                .foregroundColor(.black)
                            NbykzwTextFiled(nbykzInputText: $mrlnalWantToSay, nbykzIsFocus: $mrlanxIsFocus_2, nbykzPlaceholder: "Enter...", nbykzHeight: 132)
                            
                        }
                        VStack(alignment: .leading, spacing: 16){
                            Text("Picture:")
                                .font(LerWifaTheme.LerotFont.baigo(18))
                                .foregroundColor(.black)
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .frame(width: 92, height: 108)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 1)
                                }.overlay{
                                    if(mrialnImage.isEmpty){
                                        Image(systemName: "plus")
                                            .font(.system(size: 20))
                                            .foregroundColor(LerWifaTheme.Color.mainPurple)
                                    }else{
                                        KalfwalxImage(KalfwalxImageUrl: mrialnImage, KalfwalxWidth: 92, KalfwalxHeight: 108)
                                            .cornerRadius(20)
                                    }
                                    
                                }.onTapGesture {
                                    showAvatarPicker = true
                                }
                        }
                    }.padding(.horizontal, 20)
                }
            }
            if(!mrlanxIsFocus_2){
                VStack{
                    Spacer()
                    RyyeuaButton(ryyeuaWidth: 193, ryyeuaHeight: 48, ryyeuaText: "Upload", ryyeuaIsGradient: false, ryyeaAction: {
                        if(hours == 0 && minutes == 0){
                            LealoeoHUD.error("The practice duration cannot be 0")
                            return
                        }
                        if(mrlnalWantToSay.isEmpty){
                            LealoeoHUD.error("Text cannot be empty")
                            return
                        }
                        if(mrialnImage.isEmpty){
                            LealoeoHUD.error("Please upload a picture")
                            return
                        }
                        mrlnzlaRecordVM.addMyRecord(mrlnalWantToSay, image: mrialnImage, status: mralnSeletedStatus, duration: "\(hours)h \(minutes)min")
                        
                        mrlzNavi.pop()
                        LealoeoHUD.success("Upload successful")
                    })
                    .padding(.bottom, 26)
            }
            
                
            }
        }.photosPicker(
            isPresented: $showAvatarPicker,
            selection: $selectedItem,
            matching: .images
        )
        .onChange(of: selectedItem) { item in
            guard let item else { return }
            
            Task {
                if let data = try? await item.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    
                    // 1️⃣ 保存到本地
                    if let localPath = LocalImageManager.saveImage(image) {
                        mrialnImage = localPath   // ✅ 赋值给头像
                    }
                }
            }
        }.navigationBarHidden(true)
            .onTapGesture {
                mrlanxIsFocus_2 = false
            }
    }
}

#Preview {
    MrlnzlaUploadRecord()
}

struct DurationPicker: View {
    @Binding var hours: Int
    @Binding var minutes: Int

    var body: some View {
        HStack(spacing: 0) {
            Picker("Hours", selection: $hours) {
                ForEach(0..<24) { hour in
                    Text("\(hour) h")
                        .font(LerWifaTheme.LerotFont.baigo(16))
                        .tag(hour)
                }
            }
            .pickerStyle(.wheel)

            Picker("Minutes", selection: $minutes) {
                ForEach(0..<60) { min in
                    Text("\(min) min")
                        .font(LerWifaTheme.LerotFont.baigo(16))
                        .tag(min)
                }
            }
            .pickerStyle(.wheel)
        }
        .frame(height: 160)
    }
}
