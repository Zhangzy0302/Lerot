import SwiftUI

struct LwianzBAwaUser: Codable, Identifiable, Equatable {

  let lwianzBAwaUserId: Int
  var lwianzBAwaEmail: String
  var lwianzBAwaPassword: String
  var lwianzBAwaUserName: String
  var lwianzBAwaAvatar: String
  var lwianzBAwaFollowing: [Int]
  var lwianzBAwaFans: [Int]
  var lwianzBAwaBlacklist: [Int]
  var lwianzBAwaWalletBalance: Int
  var lwianzBAwaLikeWorks: [Int]
  var lwianzBAwaIsDeleted: Bool

  // MARK: - Identifiable
  var id: Int { lwianzBAwaUserId }
}

@MainActor
final class LwianzBAwaUserViewModel: ObservableObject {

  @Published var users: [LwianzBAwaUser] = []
  @Published var currentUser: LwianzBAwaUser?
  @Published var userInfo: LwianzBAwaUser?

  private let storage = LerotStorageManager.shared

  func getUserInfoByUid(uid: Int) {
      userInfo = storage.getUserById(userId: uid)
  }

  func returnUserInfoById(userId: Int) -> LwianzBAwaUser? {
    storage.getUserById(userId: userId)
  }

  func loadLoginUser() {
    users = storage.getUsers()

    let uid: Int = storage.getCurrentUserId()
    currentUser = users.first { $0.lwianzBAwaUserId == uid }
  }

  // 登录
  func loginByEmailAndPassword(email: String, password: String) -> LwianzBAwaUser? {
    let users = storage.getUsers()
    guard
      let matchUser = users.first(where: {
        $0.lwianzBAwaEmail == email && $0.lwianzBAwaPassword == password && !$0.lwianzBAwaIsDeleted
      })
    else {
      return nil
    }

    // 记录登录态
    storage.setCurrentUserId(matchUser.lwianzBAwaUserId)
    loadLoginUser()
    return matchUser
  }

  // 游客登录
  func visitorLogin() {
    storage.setCurrentUserId(5)
    loadLoginUser()
  }

  // 删除账号
  func deleteAccount() {
    if storage.getCurrentUserId() == 5 {
      storage.updateUser(uid: 5) { user in
        var newUser: LwianzBAwaUser = user
        newUser.lwianzBAwaUserName = "Visitor_00" + "\(Int.random(in: 20...100))"
        newUser.lwianzBAwaAvatar = "cponlzna_default_avatar"
        newUser.lwianzBAwaFollowing = []
        newUser.lwianzBAwaFans = []
        newUser.lwianzBAwaBlacklist = []
        newUser.lwianzBAwaWalletBalance = 0
        newUser.lwianzBAwaLikeWorks = []
        newUser.lwianzBAwaIsDeleted = false
        return newUser
      }
    } else {
      toggleUserIsDeleted()
    }

    storage.setCurrentUserId(7700)
    loadLoginUser()
  }

  // 注册
  func register(email: String, password: String) -> LwianzBAwaUser? {
    let users = storage.getUsers()
    guard
      users.first(where: { $0.lwianzBAwaEmail == email }) == nil
    else {
      return nil
    }

    let newUser: LwianzBAwaUser = LwianzBAwaUser(
      lwianzBAwaUserId: users.count,
      lwianzBAwaEmail: email,
      lwianzBAwaPassword: password,
      lwianzBAwaUserName: "User_" + String(users.count),
      lwianzBAwaAvatar: "cponlzna_default_avatar",
      lwianzBAwaFollowing: [],
      lwianzBAwaFans: [],
      lwianzBAwaBlacklist: [],
      lwianzBAwaWalletBalance: 0,
      lwianzBAwaLikeWorks: [],
      lwianzBAwaIsDeleted: false
    )

    storage.addUser(user: newUser)
    storage.setCurrentUserId(newUser.lwianzBAwaUserId)
    loadLoginUser()
    return newUser
  }

  // 登出
  func logout() {
    storage.setCurrentUserId(7700)
    loadLoginUser()
  }

  // 切换用户状态
  func toggleUserIsDeleted() {
    storage.updateUser(uid: currentUser!.lwianzBAwaUserId) { user in
      var newUser: LwianzBAwaUser = user
      newUser.lwianzBAwaIsDeleted = !newUser.lwianzBAwaIsDeleted
      return newUser
    }

    loadLoginUser()
  }

  // 切换拉黑状态
  func toggleUserIsBlocked(blockUserId: Int) {
    storage.updateUser(uid: currentUser!.lwianzBAwaUserId) { user in
      var newUser: LwianzBAwaUser = user
      if newUser.lwianzBAwaBlacklist.contains(blockUserId) {
        newUser.lwianzBAwaBlacklist.removeAll { $0 == blockUserId }
      } else {
        newUser.lwianzBAwaBlacklist.append(blockUserId)
      }

      return newUser
    }

    loadLoginUser()
  }

  // 切换是否喜欢作品
  func toggleWorkIsLiked(workId: Int) {
    storage.updateUser(uid: currentUser!.lwianzBAwaUserId) { user in
      var newUser: LwianzBAwaUser = user
      if newUser.lwianzBAwaLikeWorks.contains(workId) {
        newUser.lwianzBAwaLikeWorks.removeAll { $0 == workId }
      } else {
        newUser.lwianzBAwaLikeWorks.append(workId)
      }
      return newUser
    }
    loadLoginUser()
  }

  // 切换关注状态
  func toggleUserIsFollowed(followUserId: Int) {
    guard let currentUser = currentUser else { return }

    // 1️⃣ 更新当前用户
    storage.updateUser(uid: currentUser.lwianzBAwaUserId) { user in
      var newUser = user

      if newUser.lwianzBAwaFollowing.contains(followUserId) {
        newUser.lwianzBAwaFollowing.removeAll { $0 == followUserId }
      } else {
        newUser.lwianzBAwaFollowing.append(followUserId)
      }

      return newUser
    }

    // 2️⃣ 更新被关注用户
    storage.updateUser(uid: followUserId) { user in
      var newFollowUser = user

      if newFollowUser.lwianzBAwaFans.contains(currentUser.lwianzBAwaUserId) {
        newFollowUser.lwianzBAwaFans.removeAll { $0 == currentUser.lwianzBAwaUserId }
      } else {
        newFollowUser.lwianzBAwaFans.append(currentUser.lwianzBAwaUserId)
      }

      return newFollowUser
    }

    loadLoginUser()
  }

  // 修改用户信息
  func editUserInfo(name: String, aboutMe: String, avatar: String) {
    storage.updateUser(uid: currentUser!.lwianzBAwaUserId) { user in
      var newUser: LwianzBAwaUser = user
      newUser.lwianzBAwaUserName = name
      newUser.lwianzBAwaAvatar = avatar
      return newUser
    }

    loadLoginUser()
  }

  // 更新用户钻石数
  func increaseUserDiamond(diamond: Int) {
    storage.updateUser(uid: currentUser!.lwianzBAwaUserId) { user in
      var newUser: LwianzBAwaUser = user
      newUser.lwianzBAwaWalletBalance = newUser.lwianzBAwaWalletBalance + diamond
      return newUser
    }

    loadLoginUser()
  }
}
