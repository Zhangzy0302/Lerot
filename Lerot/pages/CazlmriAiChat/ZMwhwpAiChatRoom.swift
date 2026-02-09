import SwiftUI
import Alamofire

struct ZMwhwpAiChatRoom: View {
    @State private var turyInput: String = ""
    @FocusState var turyIsFocus: Bool
    
    @State private var zmwhieChatList: [ZwhaianAIChatMsg] = []
    @State private var xuwbaChatIsLoading: Bool = false

    func xuwbaRequestAiApi(xwubaSendText: String) async {
      do {
          zmwhieChatList.append(
            ZwhaianAIChatMsg(id: UUID(), zwhaianSendByMyself: true, zwhaianSendText: turyInput)
        )
          turyInput = ""
        xuwbaChatIsLoading = true
        let data = try await urqiinakaAiCall(xwubaSendText)
        let decoded = try JSONDecoder().decode(AiResponse.self, from: data)

        if let aiText = decoded.result.output.choices.first?.message.content {
          xuwbaChatIsLoading = false
            zmwhieChatList.append(
                ZwhaianAIChatMsg(id: UUID(), zwhaianSendByMyself: false, zwhaianSendText: aiText)
          )
        }
      } catch {
        xuwbaChatIsLoading = false
        print("Parsing failed:", error)
      }
    }
    
    private func scrollToBottom(_ proxy: ScrollViewProxy) {
        guard let lastId = zmwhieChatList.last?.id else { return }
        withAnimation(.easeOut(duration: 0.25)) {
            proxy.scrollTo(lastId, anchor: .bottom)
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geo in
              Image("cponlzna_main_bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()
                
                Image("cponlzna_ai_char_bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width)
            }
            
                
            VStack{
                VNauwAUWTopBar()
                GeometryReader { geo in
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack {
                                HStack {
                                    Text("Welcome! If you have any questions you want to know or share today's practice results, feel free to let me know at any time!")
                                        .font(LerWifaTheme.LerotFont.neoneon(16))
                                        .foregroundColor(LerWifaTheme.Color.mainPurple)
                                        .padding(10)
                                        .frame(maxWidth: 226)
                                        .background(
                                            UnevenRoundedRectangle(
                                                topLeadingRadius: 0,
                                                bottomLeadingRadius: 16,
                                                bottomTrailingRadius: 16,
                                                topTrailingRadius: 16
                                            ).fill(.white)
                                        )
                                    Spacer()
                                }

                                ZwajMsgList(zmwhieChatList: zmwhieChatList)
                            }
                        }
                        .scrollIndicators(.hidden)
                        .onChange(of: zmwhieChatList.count) { _ in
                            scrollToBottom(proxy)
                        }
                    }
                }
                ZwmajBottomInput(zmwhiInput: $turyInput, zwmnaIsFocus: $turyIsFocus,xuwbaChatIsLoading: $xuwbaChatIsLoading, onSend: { text in
                    Task {
                        await xuwbaRequestAiApi(xwubaSendText: text)
                    }
                })
            }.padding(.horizontal, 20)
            
        }.navigationBarHidden(true)
            .onTapGesture {
                turyIsFocus = false
            }
    }
    
    private struct ZwajMsgList: View {
        let zmwhieChatList: [ZwhaianAIChatMsg]
        var body: some View {
            LazyVStack(spacing: 12) {
                ForEach(zmwhieChatList, id: \.id) { msg in
                    HStack {
                        if msg.zwhaianSendByMyself { Spacer() }

                        Text(msg.zwhaianSendText)
                            .font(LerWifaTheme.LerotFont.miSans(16))
                            .foregroundColor(
                                msg.zwhaianSendByMyself ? .white : LerWifaTheme.Color.mainPurple
                            )
                            .padding(10)
                            
                            .background(
                                UnevenRoundedRectangle(
                                    topLeadingRadius: msg.zwhaianSendByMyself ? 16 : 0,
                                    bottomLeadingRadius: 16,
                                    bottomTrailingRadius: 16,
                                    topTrailingRadius: msg.zwhaianSendByMyself ? 0 : 16
                                )
                                .fill(
                                    msg.zwhaianSendByMyself
                                    ? LerWifaTheme.Color.mainPurple
                                    : .white
                                )
                            )

                        if !msg.zwhaianSendByMyself { Spacer() }
                    }
                    .id(msg.id) // ⭐️ 关键
                }
            }
        }
    }
    
    private struct ZwmajBottomInput: View {
        @Binding var zmwhiInput: String
        @FocusState.Binding var zwmnaIsFocus: Bool
        
        @Binding var xuwbaChatIsLoading: Bool
        
        let onSend: (_ text: String) -> Void
        
        var body: some View {
            if(xuwbaChatIsLoading){
                HStack(spacing: 12) {
                  Spacer()
                  ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(1.1)
                    .tint(.black)

                  Text("AI is thinking")
                        .font(LerWifaTheme.LerotFont.baigo(16))
                        .foregroundColor(.black)
                  Spacer()
                }.frame(height: 58)
                    .padding(.bottom, 20)
            }else{
                HStack{
                    TextField("Say something...", text: $zmwhiInput)
                        .focused($zwmnaIsFocus)
                        .tint(.black)
                        .textInputAutocapitalization(.never)
                        .font(LerWifaTheme.LerotFont.miSans(14))
                        .foregroundColor(.black)
                        
                    Image("cponlzna_send_icon")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .onTapGesture {
                            guard !zmwhiInput.isEmpty else { return }
                            onSend(zmwhiInput)     // ⭐️ 调用回调
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
                    ).padding(.bottom, 20)
            }
            
        }
    }
}

struct ZwhaianAIChatMsg {
  let id: UUID
  let zwhaianSendByMyself: Bool
  let zwhaianSendText: String
}

func urqiinakaAiCall(_ urqiinaka: String) async throws -> Data {

    let params: [String: Any] = [
        "dashScopeMessageDTOList": [
            [
                "role": "user",
                "content": urqiinaka
            ]
        ]
    ]

    let response = await AF.request(
        "https://api.wklk.link/api/dash/scope/textIssues",
        method: .post,
        parameters: params,
        encoding: JSONEncoding.default
    )
    .validate()
    .serializingData()
    .response

    switch response.result {
    case .success(let data):
        return data
    case .failure(let error):
        throw error
    }
}

struct AiResponse: Decodable {
  let result: AiResult
}

struct AiResult: Decodable {
  let output: AiOutput
}

struct AiOutput: Decodable {
  let choices: [AiChoice]
}

struct AiChoice: Decodable {
  let message: AiMessage
}

struct AiMessage: Decodable {
  let content: String
}
