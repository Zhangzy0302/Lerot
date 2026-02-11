import SwiftUI

struct VyualmaOiajVideo: Codable, Identifiable, Equatable {

  let vyualmaOiajWorkId: Int
  var vyualmaOiajCreatorId: Int
  var vyualmaOiajTitle: String
  var vyualmaOiajTextContent: String
  var vyualmaOiajVideoUrl: String
  var vyualmaOiajVideoCover: String
  var vyualmaOiajLikeCount: Int
  var vyualmaOiajDate: Date
  var vyualmaOiajIsDeleted: Bool

  var id: Int { vyualmaOiajWorkId }
}

@MainActor
final class VyualmaOiajVideoViewModel: ObservableObject {

  @Published var allWorks: [VyualmaOiajVideo] = []
  @Published var allNotBlockWorks: [VyualmaOiajVideo] = []
  @Published var userWorks: [VyualmaOiajVideo] = []
  @Published var myFollowingUserWorks: [VyualmaOiajVideo] = []
  @Published var workDetail: VyualmaOiajVideo?

  private let storage = LerotStorageManager.shared

  func getAllWorks() {
    allWorks = storage.getWorks()
  }

  func getAllNotBlockWorks() {
    let allWorks: [VyualmaOiajVideo] = storage.getWorks()
    if let cnaiwjdMyInfo = storage.getUserById(userId: storage.getCurrentUserId()) {
      allNotBlockWorks = allWorks.filter {
        !cnaiwjdMyInfo.lwianzBAwaBlacklist.contains($0.vyualmaOiajCreatorId)
          && !$0.vyualmaOiajIsDeleted
      }
    }

  }

  func getWorksByUserId(userId: Int) {
    let allPostWorks: [VyualmaOiajVideo] = storage.getWorks()
    userWorks = allPostWorks.filter {
      $0.vyualmaOiajCreatorId == userId && !$0.vyualmaOiajIsDeleted
    }
  }

  func getMyFollowingWorks() {
    let currentUserId = storage.getCurrentUserId()
    guard let currentUserInfo: LwianzBAwaUser = storage.getUserById(userId: currentUserId)
    else {
      return
    }
    let allPostWorks: [VyualmaOiajVideo] = storage.getWorks()
    let myFollowingWorks: [VyualmaOiajVideo] = allPostWorks.filter {
      currentUserInfo.lwianzBAwaFollowing.contains($0.vyualmaOiajCreatorId)
        && !currentUserInfo.lwianzBAwaBlacklist.contains($0.vyualmaOiajCreatorId)
        && !$0.vyualmaOiajIsDeleted
    }
    myFollowingUserWorks = myFollowingWorks
  }

  func getWorkDetailByWorkId(workId: Int) {
    workDetail = storage.getWorkDetailById(workId: workId)
  }

  // 根据用户ID获取用户信息（封装存储层方法）
  func getUserByCreatorId(creatorId: Int) -> LwianzBAwaUser? {
    return storage.getUserById(userId: creatorId)
  }

  // 添加新作品
  func addNewWork(title: String, textContent: String, videoUrl: String, videoCover: String) -> Int {
    let postUserId: Int = storage.getCurrentUserId()
    getAllWorks()
    let newWorkId = allWorks.count

    let newWork: VyualmaOiajVideo = VyualmaOiajVideo(
      vyualmaOiajWorkId: newWorkId, vyualmaOiajCreatorId: postUserId, vyualmaOiajTitle: title,
      vyualmaOiajTextContent: textContent, vyualmaOiajVideoUrl: videoUrl,
      vyualmaOiajVideoCover: videoCover, vyualmaOiajLikeCount: 0, vyualmaOiajDate: Date(),
      vyualmaOiajIsDeleted: false)
    storage.addWork(newWork)
    getAllNotBlockWorks()
    return newWorkId
  }

  // 删除
  func deleteMyWorks() {
    let currentUserId = storage.getCurrentUserId()
    // 软删除: 将我的所有作品标记为已删除
      let vyualmaOiajMyWorks = allWorks.filter {
        $0.vyualmaOiajCreatorId == currentUserId && !$0.vyualmaOiajIsDeleted
      }
      for work in vyualmaOiajMyWorks {
          storage.deleteWork(work)
      }
  }
}
