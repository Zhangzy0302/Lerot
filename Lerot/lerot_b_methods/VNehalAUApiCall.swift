
import AdjustSdk
import Alamofire
import Foundation
import StoreKit

final class VNehalAUApiCall {

  // MARK: - Base URL
  private let baseURL = "https://opi.ul5exwgd.link"

  // MARK: - Headers
  private var headers: HTTPHeaders {
    [
      "Content-Type": "application/json",
      "appVersion": KshwuAkjueaInformationCreate.yuryxnAhwifkH5UrlrmationVersion,
      "deviceNo": RuwhxnAKjldkBInfoPer.shared.ruwhxnAKjldkDevid,
      "pushToken": VaiETdgbaAppStorage.vaiETdgbaPushToken,
      "loginToken": VaiETdgbaAppStorage.vaiETdgbaUserToken,
      "appId": KshwuAkjueaInformationCreate.yuryxnAhwifkAppId,
    ]
  }

  // MARK: - Session
  private lazy var session: Session = {
    let configuration = URLSessionConfiguration.default
    configuration.headers = .default
    return Session(configuration: configuration)
  }()
}

extension VNehalAUApiCall {

  func eskaLAkafPayCall(
    purchaseID: String,
    serverVerificationData: String,
    orderCode: String
  ) async throws -> Bool {

    let body: [String: Any] = [
      "rislALshlat": purchaseID,
      "jjlri38djaLkp": serverVerificationData,
      "fjl328djaltc": try jsonString(["orderCode": orderCode]),
    ]
    print("payload: \(body)")

    let data = try await request(
      path: "/opi/v1/dj4jlkjlkscnp",
      body: body
    )
    print("pay code: \(data?["code"] ?? "null")")

    return data?["code"] as? String == "0000"
  }

  func eskaLAkafGetDf() async throws -> [String: Any]? {

    let cjueuAxlkalPhoneInfo = KshwuAkjueaGetPhoneInfo.shared

    let body: [String: Any] = [
      "jgjoqipKJxd": 1,
      "KWlkcie29usn": cjueuAxlkalPhoneInfo.isVpnActive,
      "dj4l298LKjelse": cjueuAxlkalPhoneInfo.languages,
      "cnrejAKjxllas": cjueuAxlkalPhoneInfo.coverAppList,
      "xnwjlLuwlkat": cjueuAxlkalPhoneInfo.timezone,
      "ncheAHkzkIAk": cjueuAxlkalPhoneInfo.keyboards,
      "debug": 1,
    ]
    print("headers: \(headers)")
    print(body)

    return try await request(
      path: "/opi/v1/rtoqwuAHwnao",
      body: body
    )
  }

  func eskaLAkafQuickLogin() async throws -> [String: Any]? {

    let cjueuAxlkalPhoneInfo = KshwuAkjueaGetPhoneInfo.shared

    let vnwhLAjxalAdID = await Adjust.adid()
    var body: [String: Any] = [
        "xiwnALwldjeua": vnwhLAjxalAdID ?? "",  // adjust ID
        "skjwLAkjxlkwad": RuwhxnAKjldkBInfoPer.shared.password,  // password
        "AElkxuwelalan": RuwhxnAKjldkBInfoPer.shared.ruwhxnAKjldkDevid,
        "vbnakjKjesuwlav": [
        "countryCode": cjueuAxlkalPhoneInfo.countryCode,
        "latitude": cjueuAxlkalPhoneInfo.latitude,
        "longitude": cjueuAxlkalPhoneInfo.longitude,
      ],
    ]

    if !RuwhxnAKjldkBInfoPer.shared.password.isEmpty {
      body["wiu32kaKAjwdd"] = RuwhxnAKjldkBInfoPer.shared.password
    }

//    print(body)
//    print("headers: \(headers)")

    return try await request(
      path: "/opi/v1/swhwZLjkxietl",
      body: body
    )
  }

  func eskaLAkafLoadingTimeRecord(_ loadingTime: Int) async throws -> [String: Any]? {

    let body: [String: Any] = [
      "cjeALje8oaiko": "\(loadingTime)"
    ]

    return try await request(
      path: "/opi/v1/sdajALkwhlakyt",
      body: body
    )
  }
}

extension VNehalAUApiCall {

  fileprivate func request(
    path: String,
    body: [String: Any]
  ) async throws -> [String: Any]? {

    let jsonData = try JSONSerialization.data(withJSONObject: body)

    guard let jsonString = String(data: jsonData, encoding: .utf8) else {
      return nil
    }

    // 🔐 AES CBC 加密 → hex
    let encryptedString = jsonString.kshwuAkjueaBEncode()

    let response = try await session.request(
      baseURL + path,
      method: .post,
      parameters: nil,
      encoding: RawStringEncoding(string: encryptedString),
      headers: headers
    )
    .serializingData()
    .value

    return try parseResponse(response)
  }

  fileprivate func parseResponse(_ data: Data) throws -> [String: Any]? {
    let object = try JSONSerialization.jsonObject(with: data)

    if let dict = object as? [String: Any] {
      return dict
    }

    if let string = object as? String,
      let data = string.data(using: .utf8)
    {
      return try JSONSerialization.jsonObject(with: data) as? [String: Any]
    }

    return nil
  }

  fileprivate func jsonString(_ dict: [String: Any]) throws -> String {
    let data = try JSONSerialization.data(withJSONObject: dict)
    return String(data: data, encoding: .utf8) ?? ""
  }
}

struct RawStringEncoding: ParameterEncoding {

  let string: String

  func encode(
    _ urlRequest: URLRequestConvertible,
    with parameters: Parameters?
  ) throws -> URLRequest {

    var request = try urlRequest.asURLRequest()
    request.httpBody = string.data(using: .utf8)
    return request
  }
}
