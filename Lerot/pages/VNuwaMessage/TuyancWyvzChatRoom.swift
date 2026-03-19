import SwiftUI
import PhotosUI
import AVFoundation

struct TuyancWyvzChatRoom: View {
    @FocusState private var truryIsFocus: Bool
    @EnvironmentObject var tuyanNavi: NavigationManager
    @EnvironmentObject var turyanChatVM: KsajwufslChatViewModel
    @EnvironmentObject var turyUserVM: LwianzBAwaUserViewModel
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var showAvatarPicker = false
    
    let tuyancWyvzRoomId: Int
    
    var body: some View {
        GeometryReader{ geo in
            ZStack(alignment: .top) {
                ZStack{
                    LinearGradient(colors: [
                        LerWifaTheme.Color.mainPurple,
                        LerWifaTheme.Color.mainPurple.opacity(0)
                    ], startPoint: .bottom, endPoint: .top)
                }.frame(height: geo.safeAreaInsets.top + 159)
                .ignoresSafeArea()
                VStack {
                    VNauwAUWTopBar() {
                        Circle().fill(.white)
                            .frame(width: 52)
                            .overlay{
                                Image(systemName: "ellipsis")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 6)
                            }.onTapGesture {
                                if let ruahUserId = turyanChatVM.getChatUserId(chatRoomId: tuyancWyvzRoomId){
                                    tuyanNavi.showReportBlock(ruahUserId)
                                }
                                
                            }
                    }
                    
                    ZStack(alignment: .topLeading){
                        UnevenRoundedRectangle(
                            topLeadingRadius: 30,
                            topTrailingRadius: 30
                        )
                        .fill(.white)
                        
                        .overlay{
                            VStack{
                                TuyancMessageList()
                                TuyahcBottomInput(raioRoomId: tuyancWyvzRoomId, turyIsFocus: $truryIsFocus)
                                    .padding(.bottom, geo.safeAreaInsets.bottom < 10 ? 24 : 6)
                            }.padding(.top, 16)
                        }
                        .padding(.top, 42)
                        if let tuyancWyaChatUserInfo = turyanChatVM.getChatUserInfo(chatRoomId: tuyancWyvzRoomId){
                            HStack(spacing: 6){
                                KalfwalxImage(KalfwalxImageUrl: tuyancWyaChatUserInfo.lwianzBAwaAvatar, KalfwalxWidth: 60
                                              , KalfwalxHeight: 60, KalfwalxIsCircle: true)
                                Text(tuyancWyaChatUserInfo.lwianzBAwaUserName)
                                    .font(LerWifaTheme.LerotFont.baigo(20))
                                    .foregroundColor(.white)
                            }.padding(.leading, 20)
                        }
                        
                    }
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
                        guard let maaiId = turyUserVM.currentUser?.lwianzBAwaUserId else { return }
                        turyanChatVM.addMessage(sendMsg: KsajwufslMessage(nuwzawiGhrdcjsRoomId: tuyancWyvzRoomId, ksajwufslSendUserId: maaiId, ksajwufslTextMsg: "", ksajwufslImageMsg: localPath, ksajwufslAudioMsg: "", ksajwufslAudioTime: "", ksajwufslDate: Date()))
                    }
                }
            }
        }
        .navigationBarHidden(true)
            .onTapGesture {
                truryIsFocus = false
            }
            .onAppear{
                turyanChatVM.getMessageListByChatId(chatRoomId: tuyancWyvzRoomId)
            }.onChange(of: tuyanNavi.isShowBlock) {show in
                guard show == false else { return }
                if let tuahMyInfo = turyUserVM.currentUser {
                    if let chaowan = turyanChatVM.getChatUserId(chatRoomId: tuyancWyvzRoomId) {
                        if(tuahMyInfo.lwianzBAwaBlacklist.contains(chaowan)){
                            
                            DispatchQueue.main.async {
                                tuyanNavi.popToRoot()
                                }
                        }
                    }
                    
                }
            }
    }
    
    private struct TuyancMessageList: View {
        @EnvironmentObject var tunaAChatVM: KsajwufslChatViewModel
        @EnvironmentObject var tuaynUserVM: LwianzBAwaUserViewModel
        @State private var audioPlayer: AVAudioPlayer?
        
        func playAudio(path: String) {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print("❌ 播放失败：\(error)")
            }
        }
        
        func msgSendByMe(_ sendUserId: Int) -> Bool {
            tuaynUserVM.currentUser?.lwianzBAwaUserId == sendUserId
        }
        
        var body: some View {
            ScrollView {
                LazyVStack(spacing: 20){
                    ForEach(tunaAChatVM.chatMessageList) { msg in
                        VStack{
                            if(!msgSendByMe(msg.ksajwufslSendUserId)){
                                HStack{
                                    if(!msg.ksajwufslTextMsg.isEmpty){
                                        Text(msg.ksajwufslTextMsg)
                                            .font(LerWifaTheme.LerotFont.miSans(16))
                                            .foregroundColor(.black)
                                            .padding(15)
                                            .background(
                                                UnevenRoundedRectangle(
                                                    bottomLeadingRadius: 16,
                                                    bottomTrailingRadius: 16,
                                                    topTrailingRadius: 16
                                                ).fill(LerWifaTheme.Color.mainYellow)
                                            ).frame(maxWidth: 278)
                                    }
                                    
                                    Spacer()
                                }
                            }
                            if(msgSendByMe(msg.ksajwufslSendUserId)){
                                
                                HStack(alignment: .top){
                                    Spacer()
                                    if(!msg.ksajwufslTextMsg.isEmpty){
                                        Text(msg.ksajwufslTextMsg)
                                            .font(LerWifaTheme.LerotFont.miSans(16))
                                            .foregroundColor(.white)
                                            .padding(15)
                                            .background(
                                                UnevenRoundedRectangle(
                                                    topLeadingRadius: 16,
                                                    bottomLeadingRadius: 16,
                                                    bottomTrailingRadius: 16  ).fill(LerWifaTheme.Color.mainPurple)
                                            ).frame(maxWidth: 230, alignment: .trailing)
                                    }
                                    if(!msg.ksajwufslImageMsg.isEmpty){
                                        KalfwalxImage(KalfwalxImageUrl: msg.ksajwufslImageMsg, KalfwalxWidth: 120, KalfwalxHeight: 120)
                                            .cornerRadius(20)
                                    }
                                    if(!msg.ksajwufslAudioMsg.isEmpty){
                                        Image("cponlzna_audio_msg")
                                            .resizable()
                                            .frame(width: 80, height: 22)
                                            .padding(15)
                                            .background(
                                                UnevenRoundedRectangle(
                                                    topLeadingRadius: 16,
                                                    bottomLeadingRadius: 16,
                                                    bottomTrailingRadius: 16  ).fill(LerWifaTheme.Color.mainPurple)
                                            ).onTapGesture {
                                                playAudio(path: msg.ksajwufslAudioMsg)
                                            }
                                    }
                                    KalfwalxImage(KalfwalxImageUrl: tuaynUserVM.currentUser?.lwianzBAwaAvatar ?? "cponlzna_default_avatar", KalfwalxWidth: 50, KalfwalxHeight: 50, KalfwalxIsCircle: true)
                                }
                                
                                
                            }
                            
                        }
                    }
                    
                }.padding(.horizontal, 20)
                    .padding(.vertical, 30)
            }.scrollIndicators(.hidden)
        }
    }
    
    private struct TuyahcBottomInput:View {
        let raioRoomId: Int
        @State private var turyInput: String = ""
        @FocusState.Binding var turyIsFocus: Bool
        
        @State private var turyaIsShowMic: Bool = false
        
        @EnvironmentObject var trnzuiChatVM: KsajwufslChatViewModel
        @EnvironmentObject var tuanUserVM: LwianzBAwaUserViewModel
        @EnvironmentObject var tuaeaunNavi: NavigationManager
        
        var body: some View {
            if(turyaIsShowMic){
                WIalnMiczc(wialnRoomId: raioRoomId, wialmxIsShowMic: $turyaIsShowMic)
            }else{
                VStack(alignment: .leading, spacing: 20){
                    HStack(spacing: 10){
                        Circle().frame(width: 34)
                            .overlay{
                                Image("cponlzna_micphone")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                            }.onTapGesture {
                                turyaIsShowMic = true
                            }
                        Image("xkjaliAliwa")
                            .resizable()
                            .frame(width: 34, height: 34)
                            .onTapGesture {
                                if let chatuserIdawa = trnzuiChatVM.getChatUserId(chatRoomId: raioRoomId) {
                                    tuaeaunNavi.push(.piwnxAcCallVideo(chatUserInfo: chatuserIdawa))
                                }
                                
                            }
                    }
                    HStack{
                        TextField("Say something...", text: $turyInput)
                            .focused($turyIsFocus)
                            .tint(.black)
                            .font(LerWifaTheme.LerotFont.miSans(14))
                            .textInputAutocapitalization(.never)
                            .foregroundColor(.black)
                            
                        Image("cponlzna_send_icon")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                if(turyInput.isEmpty){
                                    return
                                }
                                if let myid = tuanUserVM.currentUser?.lwianzBAwaUserId {
                                    trnzuiChatVM.addMessage(sendMsg: KsajwufslMessage(nuwzawiGhrdcjsRoomId: raioRoomId, ksajwufslSendUserId: myid, ksajwufslTextMsg: turyInput, ksajwufslImageMsg: "", ksajwufslAudioMsg: "", ksajwufslAudioTime: "", ksajwufslDate: Date()))
                                }else{
                                    LealoeoHUD.error("error")
                                    return
                                }
                                turyInput = ""
                                
                            }
                    }.padding(.horizontal, 20)
                        .padding(.vertical, 9)
                        .background(
                            RoundedRectangle(cornerRadius: 29)
                                .fill(.white)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 29)
                                        .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 1)
                                }// ⬆️ 上内阴影
                                .overlay(
                                    RoundedRectangle(cornerRadius: 29)
                                        .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 2)
                                        .blur(radius: 4)
                                        .offset(y: 2)
                                        .mask(
                                            RoundedRectangle(cornerRadius: 29)
                                        )
                                )
                                // ⬇️ 下内阴影
                                .overlay(
                                    RoundedRectangle(cornerRadius: 29)
                                        .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 2)
                                        .blur(radius: 4)
                                        .offset(y: -2)
                                        .mask(
                                            RoundedRectangle(cornerRadius: 29)
                                        )
                                )
                        )
                }.padding(.horizontal, 20)
            }
            
        }
    }
}

struct WIalnMiczc: View {
    let wialnRoomId: Int
    @Binding var wialmxIsShowMic: Bool
    @StateObject private var recorder = WialnAudioRecorder()
    @State private var isRecording = false
    
    @EnvironmentObject var tuyancWyvzChatVM: KsajwufslChatViewModel
    @EnvironmentObject var tuyancUserVM: LwianzBAwaUserViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {

            VStack(spacing: 14) {
                Text(isRecording ? "Talking" : "Long press the button below")
                    .font(LerWifaTheme.LerotFont.baigo(14))
                    .foregroundColor(.black)
                    .frame(width: 240, height: 41)
                    .background(
                        RoundedRectangle(cornerRadius: 29)
                            .fill(.white)
                            .overlay {
                                RoundedRectangle(cornerRadius: 29)
                                    .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 1)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 29)
                                    .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 2)
                                    .blur(radius: 4)
                                    .offset(y: 2)
                                    .mask(RoundedRectangle(cornerRadius: 29))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 29)
                                    .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 2)
                                    .blur(radius: 4)
                                    .offset(y: -2)
                                    .mask(RoundedRectangle(cornerRadius: 29))
                            )
                    )

                Image("cponlzna_micphone")
                    .resizable()
                    .frame(width: 27.29, height: 27.29)
                    .background(
                        Circle()
                            .fill(isRecording
                                  ? LerWifaTheme.Color.mainPurple
                                  : LerWifaTheme.Color.mainYellow)
                            .frame(width: 58, height: 58)
                    )
                    .frame(width: 58, height: 58)
                    .simultaneousGesture(
                        LongPressGesture(minimumDuration: 0.3)
                            .onEnded { _ in
                                // ✅ 只负责开始
                                isRecording = true
                                recorder.startRecord()
                            }
                    )
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onEnded { _ in
                                // ✅ 松手才结束
                                guard isRecording else { return }

                                isRecording = false
                                recorder.stopRecord()

                                if let url = recorder.recordURL {
                                    print("🎙️ 录音完成：\(url.path)")
                                    guard let myInfo = tuyancUserVM.currentUser else { return }

                                    tuyancWyvzChatVM.addMessage(
                                        sendMsg: KsajwufslMessage(
                                            nuwzawiGhrdcjsRoomId: wialnRoomId,
                                            ksajwufslSendUserId: myInfo.lwianzBAwaUserId,
                                            ksajwufslTextMsg: "",
                                            ksajwufslImageMsg: "",
                                            ksajwufslAudioMsg: url.path,
                                            ksajwufslAudioTime: "",
                                            ksajwufslDate: Date()
                                        )
                                    )
                                }
                            }
                    )
            }
            .frame(maxWidth: .infinity)

            // 👇 左上角 keyboard
            Image("cponlzna_keyboard")
                .resizable()
                .frame(width: 23, height: 23)
                .padding(.top, 9)
                .onTapGesture {
                    wialmxIsShowMic = false
                }
        }
        .frame(height: 111)
        .padding(.bottom, 24)
        .padding(.horizontal, 20)
    }
}
