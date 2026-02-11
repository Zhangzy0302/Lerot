import SwiftUI

struct HaudjzahMessagePage:View {
    @EnvironmentObject var ciwaNavi: NavigationManager
    @EnvironmentObject var haudizChatModel: KsajwufslChatViewModel
    
    
    
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
                    if(haudizChatModel.myChatRooms.isEmpty){
                        NvawildNoData(nwaiTopPadding: 100)
                    }else{
                        HauaRoom()
                    }
                    
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(
                Color.white
            )
        }.navigationBarHidden(true)
            .onAppear{
                haudizChatModel.getMyChatRoomsNotBlock()
            }
    }
    
    private struct HauaRoom: View {
        @EnvironmentObject var ciwaNavi: NavigationManager
        @EnvironmentObject var haudizChatModel: KsajwufslChatViewModel
        
        func hagianFormatTime(time: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            return formatter.string(from: time)
        }
        
        var body: some View {
            LazyVStack(spacing: 0){
                ForEach(haudizChatModel.myChatRooms) {room in
                    Button(action: {
                        ciwaNavi.push(VeulaNwiAppRoute.viqoanChatRoom(roomId: room.ksajwufslRoomId))
                    }){
                        if let hausamiChatUserInfo = haudizChatModel.getChatUserInfo(chatRoomId: room.ksajwufslRoomId) {
                            HStack{
                                KalfwalxImage(KalfwalxImageUrl: hausamiChatUserInfo.lwianzBAwaAvatar, KalfwalxWidth: 60, KalfwalxHeight: 60, KalfwalxIsCircle: true)
                                VStack(alignment: .leading, spacing: 15){
                                    HStack{
                                        Text(hausamiChatUserInfo.lwianzBAwaUserName)
                                            .font(LerWifaTheme.LerotFont.baigo(20))
                                            .foregroundColor(.black)
                                        Spacer()
                                        Text(hagianFormatTime(time: room.ksajwufslLastSendTime))
                                            .font(LerWifaTheme.LerotFont.miSans(12))
                                            .foregroundColor(.black)
                                    }
                                    Text(room.ksajwufslLastSendMsg)
                                        .font(LerWifaTheme.LerotFont.miSans(14))
                                        .lineLimit(1)
                                        .foregroundColor(Color(red: 51/255, green: 51/255, blue: 51/255))
                                }
                            }.padding(20)
                                .border(Color(red: 229 / 255, green: 229 / 255, blue: 229 / 255), width: 1)
                        }
                    }
                }
            }
        }
    }
}
