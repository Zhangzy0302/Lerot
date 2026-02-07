import SwiftUI

struct KsajwufslChatRoom: Codable, Identifiable, Equatable {

  let ksajwufslRoomId: Int
  var ksajwufslChatUsers: [Int]
  var ksajwufslLastSendMsg: String
  var ksajwufslLastSendTime: Date
  var ksajwufslUnreadCount: Int
  var ksajwufslIsDeleted: Bool

  var id: Int { ksajwufslRoomId }
}

struct KsajwufslMessage: Codable, Identifiable, Equatable {

  let id: UUID = UUID()

  var nuwzawiGhrdcjsRoomId: Int
  var ksajwufslSendUserId: Int
  var ksajwufslTextMsg: String
  var ksajwufslImageMsg: String
  var ksajwufslAudioMsg: String
  var ksajwufslAudioTime: String
  var ksajwufslDate: Date

  enum CodingKeys: String, CodingKey {
    case nuwzawiGhrdcjsRoomId
    case ksajwufslSendUserId
    case ksajwufslTextMsg
    case ksajwufslDate
    case ksajwufslImageMsg
    case ksajwufslAudioMsg
    case ksajwufslAudioTime
  }
}

@MainActor
final class KsajwufslChatViewModel: ObservableObject {

  @Published var myChatRooms: [KsajwufslChatRoom] = []
  @Published var chatMessageList: [KsajwufslMessage] = []

  private let storage = LerotStorageManager.shared

  func getChatUserId(chatRoomId: Int) -> Int? {
    guard
      let chatRoomInfo = storage.getChatRooms().first(where: {
        $0.ksajwufslRoomId == chatRoomId
      })
    else {
      return nil
    }
    guard
      let chatUserId = chatRoomInfo.ksajwufslChatUsers.first(where: {
        $0 != storage.getCurrentUserId()
      })
    else {
      return nil
    }

    return chatUserId
  }

  func getMyChatRoomsNotBlock() {
    let bhajaAllChatRooms = storage.getChatRooms()
    let loginUserId = storage.getCurrentUserId()
    guard let myInfo = storage.getUserById(userId: loginUserId) else {
      return
    }

    myChatRooms = bhajaAllChatRooms.filter {
      if let chatUserId = getChatUserId(chatRoomId: $0.ksajwufslRoomId) {
        $0.ksajwufslChatUsers.contains(loginUserId)
          && !myInfo.lwianzBAwaBlacklist.contains(chatUserId) && !$0.ksajwufslIsDeleted
      } else {
        false
      }

    }
  }

  // 获取聊天用户信息
  func getChatUserInfo(chatRoomId: Int) -> LwianzBAwaUser? {
    guard let chatUserId = getChatUserId(chatRoomId: chatRoomId) else {
      return nil
    }
    return storage.getUserById(userId: chatUserId)
  }

  // 获取聊天消息列表
  func getMessageListByChatId(chatRoomId: Int) {
    chatMessageList = storage.getMessages(roomId: chatRoomId)
  }

  // 发送消息
  func addMessage(sendMsg: KsajwufslMessage) {
    storage.addMessage(sendMsg)
    getMessageListByChatId(chatRoomId: sendMsg.nuwzawiGhrdcjsRoomId)
  }

  // 查找或创建聊天室
  func findOrCreateChatRoom(chatUserId: Int) -> KsajwufslChatRoom {
    let loginUserId = storage.getCurrentUserId()
    // 查找聊天室是否已存在
    let chatRoom: KsajwufslChatRoom? = storage.getChatRooms().first(where: {
      $0.ksajwufslChatUsers.contains(chatUserId)
        && $0.ksajwufslChatUsers.contains(loginUserId)
    })
    if let chatRoom: KsajwufslChatRoom = chatRoom {
      return chatRoom
    }
    return storage.createChatRoom(chatUsersId: [loginUserId, chatUserId])
  }
}
