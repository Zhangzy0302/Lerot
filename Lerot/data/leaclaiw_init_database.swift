import Foundation
import SwiftUI

final class LerotStorageManager {

  static let shared = LerotStorageManager()
  private init() {}

  private let storage = UserDefaults.standard

  // MARK: - Keys
  private enum Keys {
    static let lwianzBAwaUsers: String = "lwianzBAwaUsers"
    static let vyualmaOiajWorks: String = "vyualmaOiajWorks"
    static let pwqomaACowComments: String = "pwqomaACowComments"
    static let ksajwufslChatRooms: String = "ksajwufslChatRooms"
    static let ksajwufslMessages: String = "ksajwufslMessages"
    static let violinRecord: String = "violinRecord"
    static let lerotCurrentUserId: String = "lerotCurrentUserId"
  }
}

extension LerotStorageManager {

  func initializeAllDefaults() {
    initializeUsersIfNeeded()
    initializeWorksIfNeeded()
    initializeCommentsIfNeeded()
    initializeChatRoomsIfNeeded()
    initializeMessagesIfNeeded()
    initializeViolinRecordIfNeeded()
  }

}

//User CRUD & 登录态
extension LerotStorageManager {

  private func initializeUsersIfNeeded() {
    guard storage.data(forKey: Keys.lwianzBAwaUsers) == nil else { return }

    let users: [LwianzBAwaUser] = [
      LwianzBAwaUser(
        lwianzBAwaUserId: 0,
        lwianzBAwaEmail: "test@gmail.com",
        lwianzBAwaPassword: "123456",
        lwianzBAwaUserName: "Tanner",
        lwianzBAwaAvatar:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_avatar_0.jpg",
        lwianzBAwaFollowing: [1],
        lwianzBAwaFans: [],
        lwianzBAwaBlacklist: [],
        lwianzBAwaWalletBalance: 1000,
        lwianzBAwaLikeWorks: [],
        lwianzBAwaIsDeleted: false
      ),
      LwianzBAwaUser(
        lwianzBAwaUserId: 1,
        lwianzBAwaEmail: "wadadvnq@gmail.com",
        lwianzBAwaPassword: "8dh198h1",
        lwianzBAwaUserName: "Martin",
        lwianzBAwaAvatar:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_avatar_1.jpg",
        lwianzBAwaFollowing: [],
        lwianzBAwaFans: [0],
        lwianzBAwaBlacklist: [],
        lwianzBAwaWalletBalance: 0,
        lwianzBAwaLikeWorks: [],
        lwianzBAwaIsDeleted: false
      ),
      LwianzBAwaUser(
        lwianzBAwaUserId: 2,
        lwianzBAwaEmail: "Carroll@gmail.com",
        lwianzBAwaPassword: "4731901",
        lwianzBAwaUserName: "Carroll",
        lwianzBAwaAvatar:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_avatar_2.jpg",
        lwianzBAwaFollowing: [],
        lwianzBAwaFans: [0],
        lwianzBAwaBlacklist: [],
        lwianzBAwaWalletBalance: 0,
        lwianzBAwaLikeWorks: [],
        lwianzBAwaIsDeleted: false
      ),
      LwianzBAwaUser(
        lwianzBAwaUserId: 3,
        lwianzBAwaEmail: "Caswqeyasda@gmail.com",
        lwianzBAwaPassword: "457981071",
        lwianzBAwaUserName: "Casey",
        lwianzBAwaAvatar:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_avatar_3.jpg",
        lwianzBAwaFollowing: [],
        lwianzBAwaFans: [0],
        lwianzBAwaBlacklist: [],
        lwianzBAwaWalletBalance: 0,
        lwianzBAwaLikeWorks: [],
        lwianzBAwaIsDeleted: false
      ),
      LwianzBAwaUser(
        lwianzBAwaUserId: 4,
        lwianzBAwaEmail: "Shirley9238@gmail.com",
        lwianzBAwaPassword: "71846198",
        lwianzBAwaUserName: "Shirley",
        lwianzBAwaAvatar:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_avatar_4.jpg",
        lwianzBAwaFollowing: [],
        lwianzBAwaFans: [0],
        lwianzBAwaBlacklist: [],
        lwianzBAwaWalletBalance: 0,
        lwianzBAwaLikeWorks: [],
        lwianzBAwaIsDeleted: false
      ),
      LwianzBAwaUser(
        lwianzBAwaUserId: 5,
        lwianzBAwaEmail: "Raja1ja@gmail.com",
        lwianzBAwaPassword: "2832005",
        lwianzBAwaUserName: "Raja",
        lwianzBAwaAvatar:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_avatar_5.jpg",
        lwianzBAwaFollowing: [],
        lwianzBAwaFans: [0],
        lwianzBAwaBlacklist: [],
        lwianzBAwaWalletBalance: 0,
        lwianzBAwaLikeWorks: [],
        lwianzBAwaIsDeleted: false
      ),
      LwianzBAwaUser(
        lwianzBAwaUserId: 6,
        lwianzBAwaEmail: "",
        lwianzBAwaPassword: "",
        lwianzBAwaUserName: "Visitor_40024",
        lwianzBAwaAvatar: "cponlzna_default_avatar",
        lwianzBAwaFollowing: [],
        lwianzBAwaFans: [],
        lwianzBAwaBlacklist: [],
        lwianzBAwaWalletBalance: 0,
        lwianzBAwaLikeWorks: [],
        lwianzBAwaIsDeleted: false
      ),
    ]

    save(users, forKey: Keys.lwianzBAwaUsers)
  }

  func getUsers() -> [LwianzBAwaUser] {
    load([LwianzBAwaUser].self, forKey: Keys.lwianzBAwaUsers, default: [])
  }

  func saveUsers(_ users: [LwianzBAwaUser]) {
    save(users, forKey: Keys.lwianzBAwaUsers)
  }

  func getUserById(userId: Int) -> LwianzBAwaUser? {
    let allUsers = getUsers()
    // 查找第一个 userId 匹配的用户
    return allUsers.first { $0.lwianzBAwaUserId == userId }
  }

  func updateUser(
    uid: Int,
    update: (LwianzBAwaUser) -> LwianzBAwaUser
  ) {
    var users = getUsers()
    guard let index = users.firstIndex(where: { $0.lwianzBAwaUserId == uid }) else { return }
    users[index] = update(users[index])
    saveUsers(users)
  }

  // add user
  func addUser(user: LwianzBAwaUser) {
    var users: [LwianzBAwaUser] = getUsers()
    users.append(user)
    saveUsers(users)
  }

  // MARK: Login State
  func setCurrentUserId(_ uid: Int) {
    storage.set(uid, forKey: Keys.lerotCurrentUserId)
  }

  func getCurrentUserId() -> Int {
    return storage.object(forKey: Keys.lerotCurrentUserId) as? Int ?? 7700
  }

}

//work
extension LerotStorageManager {

  private func initializeWorksIfNeeded() {
    guard storage.data(forKey: Keys.vyualmaOiajWorks) == nil else { return }

    let vyualmaOiajWorks: [VyualmaOiajVideo] = [
      VyualmaOiajVideo(
        vyualmaOiajWorkId: 0,
        vyualmaOiajCreatorId: 0,
        vyualmaOiajTitle: "Ambient music performance",
        vyualmaOiajTextContent: "Playing the violin in this setting has a unique charm.",
        vyualmaOiajVideoUrl:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_v_0.mp4",
        vyualmaOiajVideoCover:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_v_cover_0.png",
        vyualmaOiajLikeCount: 397,
        vyualmaOiajDate: Date(timeIntervalSince1970: 1_706_418_600),
        vyualmaOiajIsDeleted: false),
      VyualmaOiajVideo(
        vyualmaOiajWorkId: 1,
        vyualmaOiajCreatorId: 1,
        vyualmaOiajTitle: "The sound of the violin in the snowfield",
        vyualmaOiajTextContent:
          "Playing the violin on the vast snowy ground gives the music a sense of emptiness.",
        vyualmaOiajVideoUrl:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_v_1.mp4",
        vyualmaOiajVideoCover:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_v_cover_1.png",
        vyualmaOiajLikeCount: 727,
        vyualmaOiajDate: Date(timeIntervalSince1970: 1_706_418_700),
        vyualmaOiajIsDeleted: false),
      VyualmaOiajVideo(
        vyualmaOiajWorkId: 2,
        vyualmaOiajCreatorId: 2,
        vyualmaOiajTitle: "A melody that heals all the exhaustion.",
        vyualmaOiajTextContent:
          "Using the sound of the violin to communicate with the world, each note is a gentle expression.",
        vyualmaOiajVideoUrl:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_v_2.mp4",
        vyualmaOiajVideoCover:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_v_cover_2.png",
        vyualmaOiajLikeCount: 986,
        vyualmaOiajDate: Date(timeIntervalSince1970: 1_706_418_600),
        vyualmaOiajIsDeleted: false),
      VyualmaOiajVideo(
        vyualmaOiajWorkId: 3,
        vyualmaOiajCreatorId: 3,
        vyualmaOiajTitle: "A wonderful night",
        vyualmaOiajTextContent: "May everyone who hears this melody be treated with kindness.",
        vyualmaOiajVideoUrl:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_v_3.mp4",
        vyualmaOiajVideoCover:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_v_cover_3.png",
        vyualmaOiajLikeCount: 657,
        vyualmaOiajDate: Date(timeIntervalSince1970: 1_706_418_600),
        vyualmaOiajIsDeleted: false),
      VyualmaOiajVideo(
        vyualmaOiajWorkId: 4,
        vyualmaOiajCreatorId: 4,
        vyualmaOiajTitle: "Daily practice",
        vyualmaOiajTextContent: "Practice the violin seriously and live seriously.",
        vyualmaOiajVideoUrl:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_v_4.mp4",
        vyualmaOiajVideoCover:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_v_cover_4.png",
        vyualmaOiajLikeCount: 1397,
        vyualmaOiajDate: Date(timeIntervalSince1970: 1_706_418_600),
        vyualmaOiajIsDeleted: false),
      VyualmaOiajVideo(
        vyualmaOiajWorkId: 5,
        vyualmaOiajCreatorId: 5,
        vyualmaOiajTitle: "Playing the violin freely",
        vyualmaOiajTextContent: "The sound of the violin is the outlet for emotions.",
        vyualmaOiajVideoUrl:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_v_5.mp4",
        vyualmaOiajVideoCover:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_v_cover_5.png",
        vyualmaOiajLikeCount: 297,
        vyualmaOiajDate: Date(timeIntervalSince1970: 1_706_418_600),
        vyualmaOiajIsDeleted: false),
    ]
    save(vyualmaOiajWorks, forKey: Keys.vyualmaOiajWorks)
  }

  func getWorks() -> [VyualmaOiajVideo] {
    load([VyualmaOiajVideo].self, forKey: Keys.vyualmaOiajWorks, default: [])
  }

  func getWorksNotBlock() -> [VyualmaOiajVideo] {
    let allWorks = getWorks()
    let currentUserInfo = getUserById(userId: getCurrentUserId())

    // 用 $0 指代遍历的每个 work 元素
    return allWorks.filter {
      guard let blacklist = currentUserInfo?.lwianzBAwaBlacklist else { return true }
      return !blacklist.contains($0.vyualmaOiajCreatorId)
    }
  }

  func getWorkDetailById(workId: Int) -> VyualmaOiajVideo? {
    let allWorks = getWorks()
    guard
      let workDetail = allWorks.first(where: {
        $0.vyualmaOiajWorkId == workId
      })
    else {
      return nil
    }

    return workDetail
  }

  func addWork(_ work: VyualmaOiajVideo) {
    var vyualmaOiajWorks = getWorks()
    vyualmaOiajWorks.insert(work, at: 0)
    save(vyualmaOiajWorks, forKey: Keys.vyualmaOiajWorks)
  }

  func updateWork(_ work: VyualmaOiajVideo) {
    var vyualmaOiajWorks = getWorks()
    guard
      let index = vyualmaOiajWorks.firstIndex(where: {
        $0.vyualmaOiajWorkId == work.vyualmaOiajWorkId
      })
    else {
      return
    }

    vyualmaOiajWorks[index] = work
  }

  // 软删除
  func deleteWork(_ work: VyualmaOiajVideo) {
    var vyualmaOiajWorks = getWorks()
    guard
      let index = vyualmaOiajWorks.firstIndex(where: {
        $0.vyualmaOiajWorkId == work.vyualmaOiajWorkId
      })
    else {
      return
    }

    vyualmaOiajWorks[index].vyualmaOiajIsDeleted = true
  }
}

//Comment
extension LerotStorageManager {

  private func initializeCommentsIfNeeded() {
    guard storage.data(forKey: Keys.pwqomaACowComments) == nil else { return }
    save([PwqomaACowComment](), forKey: Keys.pwqomaACowComments)
  }

  func getComments(for workId: Int) -> [PwqomaACowComment] {
    load([PwqomaACowComment].self, forKey: Keys.pwqomaACowComments, default: [])
      .filter { $0.pwqomaACowCommentWorkId == workId }
  }

  // 获取所有评论
  func getAllComments() -> [PwqomaACowComment] {
    load([PwqomaACowComment].self, forKey: Keys.pwqomaACowComments, default: [])
  }

  func addComment(_ comment: PwqomaACowComment) {
    var pwqomaACowComments = load(
      [PwqomaACowComment].self, forKey: Keys.pwqomaACowComments, default: [])
    pwqomaACowComments.append(comment)
    save(pwqomaACowComments, forKey: Keys.pwqomaACowComments)
  }

  func deleteComment(_ comment: PwqomaACowComment) {
    var comments = load(
      [PwqomaACowComment].self,
      forKey: Keys.pwqomaACowComments,
      default: []
    )

    comments.removeAll { $0.id == comment.id }

    save(comments, forKey: Keys.pwqomaACowComments)
  }
}

//ChatRoom & Message
extension LerotStorageManager {

  private func initializeChatRoomsIfNeeded() {
    guard storage.data(forKey: Keys.ksajwufslChatRooms) == nil else { return }
    save([KsajwufslChatRoom](), forKey: Keys.ksajwufslChatRooms)
  }

  func getChatRooms() -> [KsajwufslChatRoom] {
    load([KsajwufslChatRoom].self, forKey: Keys.ksajwufslChatRooms, default: [])
  }

  // 创建聊天室
  func createChatRoom(chatUsersId: [Int]) -> KsajwufslChatRoom {
    var ksajwufslChatRooms: [KsajwufslChatRoom] = getChatRooms()
    let newRoom: KsajwufslChatRoom = KsajwufslChatRoom(
      ksajwufslRoomId: ksajwufslChatRooms.count,
      ksajwufslChatUsers: chatUsersId,
      ksajwufslLastSendMsg: "",
      ksajwufslLastSendTime: Date(),
      ksajwufslUnreadCount: 0,
      ksajwufslIsDeleted: false
    )
    ksajwufslChatRooms.append(newRoom)
    save(ksajwufslChatRooms, forKey: Keys.ksajwufslChatRooms)

    return newRoom
  }
  // 更新聊天室
  func updateChatRoom(roomId: Int, update: (KsajwufslChatRoom) -> KsajwufslChatRoom) {
    var ksajwufslChatRooms: [KsajwufslChatRoom] = getChatRooms()
    guard let index = ksajwufslChatRooms.firstIndex(where: { $0.ksajwufslRoomId == roomId }) else {
      return
    }
    ksajwufslChatRooms[index] = update(ksajwufslChatRooms[index])
    save(ksajwufslChatRooms, forKey: Keys.ksajwufslChatRooms)
  }

  private func initializeMessagesIfNeeded() {
    guard storage.data(forKey: Keys.ksajwufslMessages) == nil else { return }
    save([KsajwufslMessage](), forKey: Keys.ksajwufslMessages)
  }

  func getMessages(roomId: Int) -> [KsajwufslMessage] {
    return load([KsajwufslMessage].self, forKey: Keys.ksajwufslMessages, default: [])
      .filter { $0.nuwzawiGhrdcjsRoomId == roomId }
  }

  func addMessage(_ msg: KsajwufslMessage) {
    var ksajwufslMessages = load(
      [KsajwufslMessage].self, forKey: Keys.ksajwufslMessages, default: [])
    ksajwufslMessages.append(msg)
    save(ksajwufslMessages, forKey: Keys.ksajwufslMessages)
  }
}

// moive
extension LerotStorageManager {
  private func initializeViolinRecordIfNeeded() {
    guard storage.data(forKey: Keys.violinRecord) == nil else { return }
    let jflawhPracRecord: [JflawhPracRecord] = [
      JflawhPracRecord(
        jflawhPracRecordUserId: 0,
        jflawhPracRecordImage:
          "http://huanniuchat.oss-accelerate.aliyuncs.com/Lerot2026/wiancz_practice.jpg",
        jflawhPracRecordText:
          "Good concentration, core tasks fully practiced with obvious improvement; slight instability in bow tip/root bowing, stiff finger shifting in high positions, rigid dotted rhythm handling",
        jflawhPracRecordStatus: 3,
        jflawhPracRecordPracticeDuration: "1h 30min",
        jflawhPracRecordDate: Date(timeIntervalSince1970: 1_706_418_600)
      )
    ]
    save(jflawhPracRecord, forKey: Keys.violinRecord)
  }

  func getViolinRecord() -> [JflawhPracRecord] {
    load([JflawhPracRecord].self, forKey: Keys.violinRecord, default: [])
  }

  func addViolinRecord(_ history: JflawhPracRecord) {
    var histories = load([JflawhPracRecord].self, forKey: Keys.violinRecord, default: [])
    histories.append(history)
    save(histories, forKey: Keys.violinRecord)
  }

  func deleteViolinRecord(_ workId: UUID) {
    var histories: [JflawhPracRecord] = load(
      [JflawhPracRecord].self, forKey: Keys.violinRecord, default: [])
    histories.removeAll {
      $0.id == workId
    }
    save(histories, forKey: Keys.violinRecord)
  }

  // 根据用户Id删除所有
  func deleteViolinRecordByUserId(_ userId: Int) {
    var histories: [JflawhPracRecord] = load(
      [JflawhPracRecord].self, forKey: Keys.violinRecord, default: [])
    histories.removeAll {
      $0.jflawhPracRecordUserId == userId
    }
    save(histories, forKey: Keys.violinRecord)
  }
}

//底层通用存取（核心）
extension LerotStorageManager {

  fileprivate func save<T: Codable>(_ value: T, forKey key: String) {
    if let data = try? JSONEncoder().encode(value) {
      storage.set(data, forKey: key)
    }
  }

  fileprivate func load<T: Codable>(
    _ type: T.Type,
    forKey key: String,
    default defaultValue: T
  ) -> T {
    guard
      let data = storage.data(forKey: key),
      let value = try? JSONDecoder().decode(type, from: data)
    else {
      return defaultValue
    }
    return value
  }
}
