import SwiftUI

// 练习记录
struct JflawhPracRecord: Codable, Identifiable, Equatable {
  let id: UUID = UUID()
  var jflawhPracRecordUserId: Int
  var jflawhPracRecordImage: String
  var jflawhPracRecordText: String
  var jflawhPracRecordDate: Date

  enum CodingKeys: String, CodingKey {
    case jflawhPracRecordUserId
    case jflawhPracRecordImage
    case jflawhPracRecordText
    case jflawhPracRecordDate
  }
}

@MainActor
final class JflawhPracRecordViewModel: ObservableObject {

  @Published var myRecord: [JflawhPracRecord] = []

    private let storage: LerotStorageManager = LerotStorageManager.shared

  func getMyRecord() {
    let cnealjcw: [JflawhPracRecord] = storage.getMoiveScriptRecord()
    myRecord = cnealjcw.filter {
      $0.jflawhPracRecordUserId == storage.getCurrentUserId()
    }
  }

func deleteMyRecord(workId: UUID) {
    storage.deleteMoiveScriptRecord(workId)
    getMyRecord()
  }

  func clearMyRecord(userId: Int) {
    storage.deleteMoiveScriptRecordByUserId(userId)
    getMyRecord()
  }

  // 添加
  func addMyRecord(_ cnwianz: String, image: String) {
    storage.addMoiveScriptRecord(
      JflawhPracRecord(
        jflawhPracRecordUserId: storage.getCurrentUserId(),
        jflawhPracRecordImage: image,
         jflawhPracRecordText: cnwianz,
        jflawhPracRecordDate: Date()
      ))
    getMyRecord()
  }
}
