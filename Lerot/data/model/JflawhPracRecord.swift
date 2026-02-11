import SwiftUI

// 练习记录
struct JflawhPracRecord: Codable, Identifiable, Equatable {
  let id: UUID = UUID()
  var jflawhPracRecordUserId: Int
  var jflawhPracRecordImage: String
  var jflawhPracRecordText: String
  var jflawhPracRecordStatus: Int
    var jflawhPracRecordPracticeDuration: String
  var jflawhPracRecordDate: Date

  enum CodingKeys: String, CodingKey {
    case jflawhPracRecordUserId
    case jflawhPracRecordImage
    case jflawhPracRecordText
    case jflawhPracRecordStatus
      case jflawhPracRecordPracticeDuration
    case jflawhPracRecordDate
  }
}

@MainActor
final class JflawhPracRecordViewModel: ObservableObject {

  @Published var myRecord: [JflawhPracRecord] = []

  private let storage: LerotStorageManager = LerotStorageManager.shared

  func getMyRecord() {
    let cnealjcw: [JflawhPracRecord] = storage.getViolinRecord()
    myRecord = cnealjcw.filter {
      $0.jflawhPracRecordUserId == storage.getCurrentUserId()
    }
  }

  // 获取今天的记录
  func getTodayRecord() -> [JflawhPracRecord] {
    let cnealjcw: [JflawhPracRecord] = storage.getViolinRecord()
    return cnealjcw.filter {
      $0.jflawhPracRecordUserId == storage.getCurrentUserId() &&
        Calendar.current.isDateInToday($0.jflawhPracRecordDate)
    }
  }

  func deleteMyRecord() {
      for record in myRecord {
          storage.deleteViolinRecord(record.id)
      }
    getMyRecord()
  }

  func clearMyRecord(userId: Int) {
    storage.deleteViolinRecordByUserId(userId)
    getMyRecord()
  }

  // 添加
    func addMyRecord(_ cnwianz: String, image: String, status: Int, duration: String) {
    storage.addViolinRecord(
      JflawhPracRecord(
        jflawhPracRecordUserId: storage.getCurrentUserId(),
        jflawhPracRecordImage: image,
        jflawhPracRecordText: cnwianz,
        jflawhPracRecordStatus: status,
        jflawhPracRecordPracticeDuration: duration,
        jflawhPracRecordDate: Date()
      ))
    getMyRecord()
  }
}
