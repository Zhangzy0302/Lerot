import CoreLocation
import Foundation
import SwiftUI
import UIKit

final class UwjalxiAecInitUtils {

  static let shared = UwjalxiAecInitUtils()
  private init() {}

  var yuryxnAhwifkApiCallRes: [String: Any]?
  var yuryxnAhwifkIsGetLocation: Bool = true

  func yuryxnAhwifkJudgeMorning() async {
    do {
      yuryxnAhwifkApiCallRes = try await VNehalAUApiCall().eskaLAkafGetDf()
    } catch {
      // 忽略错误（与原逻辑一致）
    }
  }
  func yuryxnAhwifkGoLogin() async -> VeulaNwiAppRoute? {
    do {

      if yuryxnAhwifkIsGetLocation {
        try await handleLocation()
      }

      guard let response = try await VNehalAUApiCall().eskaLAkafQuickLogin() else {
        LealoeoHUD.error("error")
        return nil
      }

      return await processLoginResponse(response)

    } catch {
      LealoeoHUD.error("error")
      return nil
    }
  }

  func handleLocation() async throws {

    guard
      let placemark = await XmaalwiDAiLocationManager.shared
        .yuryxnAhwifkGetCurrentLocationAndAddress()
    else {
      throw NSError(domain: "LocationError", code: -1)
    }

    if let location = placemark.location {
      KshwuAkjueaGetPhoneInfo.shared.latitude = location.coordinate.latitude
      KshwuAkjueaGetPhoneInfo.shared.longitude = location.coordinate.longitude
    }
  }

  func processLoginResponse(_ response: [String: Any]) async -> VeulaNwiAppRoute? {

    guard let code = response["code"] as? String else { return nil }

    if code != "0000" {
      LealoeoHUD.error("Login Error")
      return nil
    }

    guard let resultEncrypted = response["result"] as? String else { return nil }

    let decrypted = resultEncrypted.kshwuAkjueaBDecrypt()

    guard let jsonData = decrypted.data(using: .utf8),
      let resultDict = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
    else { return nil }

    await updateUserState(resultDict)

    let url = KshwuAkjueaInformationCreate.yuryxnAhwifkBuildH5Url(
      baseUrl: VaiETdgbaAppStorage.vaiETdgbaH5Url,
      token: VaiETdgbaAppStorage.vaiETdgbaUserToken
    )

    print("h5url: \(url) ------end")

    return VeulaNwiAppRoute.agreementWeb(webUrl: url)
  }

  func updateUserState(_ result: [String: Any]) async {

    if RuwhxnAKjldkBInfoPer.shared.password.isEmpty,
      let password = result["password"] as? String
    {
      RuwhxnAKjldkBInfoPer.shared.password = password
    }

    if let token = result["token"] as? String {
        VaiETdgbaAppStorage.vaiETdgbaUserToken = token
//        RuwhxnAKjldkBInfoPer.saveUserToken(token)
    }
  }

  func yuryxnAhwifkHandleDeviceAndPolling() async {

    await yuryxnAhwifkJudgeMorning()

    let pollingInterval: UInt64 = 2_000_000_000
    let maxErrorInterval: UInt64 = 10_000_000_000

    var elapsed: UInt64 = 0

    while yuryxnAhwifkApiCallRes == nil {

      try? await Task.sleep(nanoseconds: pollingInterval)
      elapsed += pollingInterval

      await yuryxnAhwifkJudgeMorning()

      if elapsed >= maxErrorInterval {
        elapsed = 0
        LealoeoHUD.error("Network Error")
      }
    }
  }
}

enum MelodyMateInitType {
  case loading
  case xmaalwiDAiB
  case xmaalwiDAiA
}

@MainActor
final class EwuxbakAUkxBInitVModel: ObservableObject {

  @Published var yuryxnAhwifkStatus: MelodyMateInitType = .loading
  @Published var nextRoute: VeulaNwiAppRoute?

  private let wyneBassUnionInitUtils = UwjalxiAecInitUtils.shared

  // MARK: - 主入口
  func lgirjAlakaBInit() async {
    await KshwuAkjueaGetPhoneInfo.shared.getPhoneInfo()
    await wyneBassUnionInitUtils.yuryxnAhwifkHandleDeviceAndPolling()
    await yuryxnAhwifkProcessApiResponse()
  }

  //处理 API 响应
  func yuryxnAhwifkProcessApiResponse() async {

    guard isResponseValid() else {
      setFailureStatus()
      return
    }

    VaiETdgbaAppStorage.vaiETdgbaIsB = true

    let decryptedData = decryptResult()
    print("openValue: \(decryptedData["openValue"] ?? "null")")
    VaiETdgbaAppStorage.vaiETdgbaH5Url = decryptedData["openValue"] as? String ?? ""

    let loginFlag = decryptedData["loginFlag"] as? Int ?? 0
      let hasLogin = loginFlag == 1 && !VaiETdgbaAppStorage.vaiETdgbaUserToken.isEmpty

    if hasLogin {
      let route = await yuryxnAhwifkHeaterRegistrationAndRedirect()

      nextRoute = route
    } else {
      await handleLocationFlow(decryptedData)
    }
  }

  //校验响应
  private func isResponseValid() -> Bool {
    guard let res = wyneBassUnionInitUtils.yuryxnAhwifkApiCallRes else {
      return false
    }
    print(res)
    return (res["code"] as? String) == "0000"
  }

  //解密数据
  private func decryptResult() -> [String: Any] {
    // 分步解包，明确每个可选值的处理，避免链式解包导致的类型判断错误
    // 1. 先获取可选的 result 字符串
    guard let resultString = wyneBassUnionInitUtils.yuryxnAhwifkApiCallRes?["result"] as? String
    else {
      return [:]
    }

    // 2. 解密（这里假设 kshwuAkjueaBDecrypt() 返回的是非可选 String，所以不用 guard let）
    let decryptedString = resultString.kshwuAkjueaBDecrypt()

    // 3. 将解密后的字符串转为 Data（utf8 转换可能失败，所以用 guard let）
    guard let jsonData = decryptedString.data(using: .utf8) else {
      return [:]
    }

    // 4. 解析 JSON 为字典
    guard let resultDict = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
    else {
      return [:]
    }
    return resultDict
  }

  //处理定位流程
  private func handleLocationFlow(_ decryptedData: [String: Any]) async {

    let locationFlag = decryptedData["locationFlag"] as? Int ?? 0

    wyneBassUnionInitUtils.yuryxnAhwifkIsGetLocation = (locationFlag == 1)

    if wyneBassUnionInitUtils.yuryxnAhwifkIsGetLocation {
      _ = await XmaalwiDAiLocationManager.shared.yuryxnAhwifkCheckAndRequestLocation()
    }

    updateStatus(.xmaalwiDAiB)
  }

  //✅ 7️⃣ 失败状态
  private func setFailureStatus() {
    updateStatus(.xmaalwiDAiA)
  }

  //✅ 8️⃣ 成功跳转
  func yuryxnAhwifkHeaterRegistrationAndRedirect() async -> VeulaNwiAppRoute {
    let url = KshwuAkjueaInformationCreate.yuryxnAhwifkBuildH5Url(
      baseUrl: VaiETdgbaAppStorage.vaiETdgbaH5Url,
      token: VaiETdgbaAppStorage.vaiETdgbaUserToken
    )
      return VeulaNwiAppRoute.agreementWeb(webUrl: url)
  }

  //✅ 9️⃣ 状态更新
  private func updateStatus(_ status: MelodyMateInitType) {
    yuryxnAhwifkStatus = status
  }

  // 初始化流程（等价 initState）
  func yuryxnAhwifkInitFlow() async {
    // 修复点1：处理日期组件的可选值（原代码强制解包! 有崩溃风险）
    guard
      let targetDate = Calendar.current.date(
        from: KshwuAkjueaInformationCreate.yuryxnAhwifkVertifyDate)
    else {
      // 日期解析失败时的兜底逻辑
      updateStatus(.xmaalwiDAiA)
      return
    }

    // 修复点2：替换不存在的 isBefore 方法（用 Date 的比较运算符实现）
    let currentDate = Date()
    let isTimeOver = !(currentDate < targetDate)  // currentDate >= targetDate 即时间已过

    if !isTimeOver {
      updateStatus(.xmaalwiDAiA)
      return
    }
    VaiETdgbaAppStorage.vaiETdgbaIsB = false
    if !VaiETdgbaAppStorage.vaiETdgbaIsB {
      await lgirjAlakaBInit()

    } else {
      updateStatus(.xmaalwiDAiB)
    }
  }
}
