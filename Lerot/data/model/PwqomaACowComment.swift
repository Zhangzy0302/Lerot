import SwiftUI

struct PwqomaACowComment: Codable, Identifiable, Equatable {

  let id: UUID = UUID()

  var pwqomaACowCommentWorkId: Int
  var pwqomaACowCommentUserId: Int
  var pwqomaACowCommentText: String
  var pwqomaACowDate: Date

  enum CodingKeys: String, CodingKey {
    case pwqomaACowCommentWorkId
    case pwqomaACowCommentUserId
    case pwqomaACowCommentText
    case pwqomaACowDate
  }
}

@MainActor
final class PwqomaACowCommentsViewModel: ObservableObject {

  @Published var workCommentsNotBlock: [PwqomaACowComment] = []

  private let storage = LerotStorageManager.shared

  func getCommentsNotBlockByWorkId(workId: Int) {
    let allComments: [PwqomaACowComment] = storage.getComments(for: workId)
    guard let loginUserInfo = storage.getUserById(userId: storage.getCurrentUserId())
    else {
      return
    }
    workCommentsNotBlock = allComments.filter {
      !loginUserInfo.lwianzBAwaBlacklist.contains($0.pwqomaACowCommentUserId)
    }
  }

  func getCommetUserInfo(userId: Int) -> LwianzBAwaUser? {
    return storage.getUserById(userId: userId)
  }

  func addCommentItem(commentItem: PwqomaACowComment) {
    storage.addComment(commentItem)

  }

  // 删除我的所有评论
  func deleteCommentItem() {
    let currentUserId = storage.getCurrentUserId()
    let allComments = storage.getAllComments()
    for comment in allComments {
      if comment.pwqomaACowCommentUserId == currentUserId {
        storage.deleteComment(comment)
      }
    }
  }
}
