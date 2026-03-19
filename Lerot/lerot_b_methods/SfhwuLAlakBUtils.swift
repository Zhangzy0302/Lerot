//
//  mnhjfka_hswuq_b_utils.swift
//  Faio
//
//  Created by yangyang on 2026/2/25.
//

import CommonCrypto
import CoreLocation
import Foundation
import Network
import SwiftUI
import SystemConfiguration.CaptiveNetwork
import UIKit

extension String {

  // MARK: - Key & IV
//   private static let dravKey = "518486he8pzgbjsk"
//   private static let dravIV = "614436p28qzhkjsl"

  private static let dravKey = "frypeir8ec6w2ou0"
  private static let dravIV = "goito2bxk92fxw9t"

  // MARK: - 加密
  func kshwuAkjueaBEncode() -> String {
    guard let data = self.data(using: .utf8),
      let encrypted = kshwuAkjueaAesCrypt(data: data, operation: CCOperation(kCCEncrypt))
    else {
      return ""
    }

    return encrypted.map { String(format: "%02x", $0) }.joined()
  }

  // MARK: - 解密
  func kshwuAkjueaBDecrypt() -> String {
    guard let encryptedData = Data(hexString: self),
      let decrypted = kshwuAkjueaAesCrypt(data: encryptedData, operation: CCOperation(kCCDecrypt)),
      let result = String(data: decrypted, encoding: .utf8)
    else {
      return ""
    }

    return result
  }

  // MARK: - Core AES
  private func kshwuAkjueaAesCrypt(data: Data, operation: CCOperation) -> Data? {

    let keyData = Self.dravKey.data(using: .utf8)!
    let ivData = Self.dravIV.data(using: .utf8)!

    let dataLength = data.count
    let outLength = dataLength + kCCBlockSizeAES128

    var outBytes = Data(count: outLength)
    var finalLength = 0

    let status = outBytes.withUnsafeMutableBytes { outBytesPtr -> CCCryptorStatus in

      guard let outBase = outBytesPtr.baseAddress else { return CCCryptorStatus(kCCMemoryFailure) }

      return data.withUnsafeBytes { dataPtr in
        keyData.withUnsafeBytes { keyPtr in
          ivData.withUnsafeBytes { ivPtr in

            CCCrypt(
              operation,
              CCAlgorithm(kCCAlgorithmAES),
              CCOptions(kCCOptionPKCS7Padding),
              keyPtr.baseAddress,
              kCCKeySizeAES128,
              ivPtr.baseAddress,
              dataPtr.baseAddress,
              dataLength,
              outBase,
              outLength,
              &finalLength
            )
          }
        }
      }
    }

    guard status == kCCSuccess else { return nil }

    return outBytes.prefix(finalLength)
  }
}

extension Data {
  init?(hexString: String) {
    let len = hexString.count / 2
    var data = Data(capacity: len)

    var index = hexString.startIndex
    for _ in 0..<len {
      let nextIndex = hexString.index(index, offsetBy: 2)
      guard nextIndex <= hexString.endIndex else { return nil }

      let bytes = hexString[index..<nextIndex]
      guard let num = UInt8(bytes, radix: 16) else { return nil }

      data.append(num)
      index = nextIndex
    }

    self = data
  }
}

class KshwuAkjueaInformationCreate {

//   static let yuryxnAhwifkAppId = "44332211"
    static let yuryxnAhwifkAppId: String = "93973382"
    static let yuryxnAhwifkH5UrlrmationVersion: String = "1.1.0"
    
    static let yuryxnAhwifkVertifyDate: DateComponents = DateComponents(
        year: 2026, month: 3, day: 20, hour: 6
      )

  static func yuryxnAhwifkBuildH5Url(baseUrl: String, token: String) -> String {
    let timestamp = Int(Date().timeIntervalSince1970 * 1000)

    let openParams: [String: Any] = [
      "token": token,
      "timestamp": timestamp,
    ]
    print(token)
    guard let jsonData = try? JSONSerialization.data(withJSONObject: openParams),
      let jsonString = String(data: jsonData, encoding: .utf8)
    else {
      return ""
    }

    let encoded = jsonString.kshwuAkjueaBEncode()

    return "\(baseUrl)?openParams=\(encoded)&appId=\(yuryxnAhwifkAppId)"
  }
}

class XmaalwiDAiLocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {

  static let shared = XmaalwiDAiLocationManager()
  @Published var showLocationDialog: Bool = false
  private let xknwiALwiloqoManager = CLLocationManager()
  private var xknwiALwiloqoLocationContinuation: CheckedContinuation<CLLocation, Error>?

  override init() {
    super.init()
    xknwiALwiloqoManager.delegate = self
    xknwiALwiloqoManager.desiredAccuracy = kCLLocationAccuracyBest
  }

  func yuryxnAhwifkGetCurrentLocationAndAddress() async -> CLPlacemark? {

    let einclIAWlaskjSuccess = await yuryxnAhwifkCheckAndRequestLocation()
    if !einclIAWlaskjSuccess { return nil }

    do {
      let location = try await xknwiALwiloqoGetCurrentLocation()
      let placemark = try await reverseGeocode(location)
      return placemark
    } catch {
        LealoeoHUD.error("Positioning failed")
      return nil
    }
  }

  func yuryxnAhwifkCheckAndRequestLocation() async -> Bool {

    // 1️⃣ 检查系统定位开关
    guard CLLocationManager.locationServicesEnabled() else {
      await showPermissionDialog()

      if !CLLocationManager.locationServicesEnabled() {
        showLocationServiceDisabledToast()
        return false
      }
      return false
    }

    // 2️⃣ 检查权限
    let status = xknwiALwiloqoManager.authorizationStatus

    if status == .denied || status == .restricted {
      await showPermissionDialog()

      let newStatus = xknwiALwiloqoManager.authorizationStatus
      if newStatus == .denied || newStatus == .restricted {
        return false
      }
    }

    if status == .notDetermined {
      xknwiALwiloqoManager.requestWhenInUseAuthorization()
      return true
    }

    return true
  }

  private func xknwiALwiloqoGetCurrentLocation() async throws -> CLLocation {
    try await withCheckedThrowingContinuation { continuation in
      self.xknwiALwiloqoLocationContinuation = continuation
      xknwiALwiloqoManager.requestLocation()
    }
  }

  func xknwiALwiloqoLocationManager(
    _ xknwiALwiloqoManager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]
  ) {

    guard let location = locations.first else {
      xknwiALwiloqoLocationContinuation?.resume(throwing: NSError())
      return
    }

    xknwiALwiloqoLocationContinuation?.resume(returning: location)
    xknwiALwiloqoLocationContinuation = nil
  }

  func xknwiALwiloqoLocationManager(
    _ xknwiALwiloqoManager: CLLocationManager,
    didFailWithError error: Error
  ) {

    xknwiALwiloqoLocationContinuation?.resume(throwing: error)
    xknwiALwiloqoLocationContinuation = nil
  }

  private func reverseGeocode(_ location: CLLocation) async throws -> CLPlacemark? {

    try await withCheckedThrowingContinuation { continuation in

      CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in

        if let error = error {
          continuation.resume(throwing: error)
          return
        }

        continuation.resume(returning: placemarks?.first)
      }
    }
  }

  private func showLocationServiceDisabledToast() {
    LealoeoHUD.error("Please enable system location services.")
  }

  @MainActor
  private func showPermissionDialog() async {
    // 这里触发你的 SwiftUI 弹窗
    showLocationDialog = true
  }
}

class KshwuAkjueaGetPhoneInfo {

  static let shared = KshwuAkjueaGetPhoneInfo()

  var languages: [String] = []
  var countryCode: String = ""
  var latitude: Double = 0
  var longitude: Double = 0
  var coverAppList: [String] = []
  var keyboards: [String] = []
  var timezone: String = ""
  var isVpnActive: Int = 0

  func getPhoneInfo() async {

    await withTaskGroup(of: Void.self) { group in

      group.addTask { await self.getLanguages() }
      group.addTask { await self.getTimezone() }
      group.addTask { await self.getInstalledApps() }
      group.addTask { await self.checkVPN() }
      group.addTask {
        await self.getSystemKeyboards()
      }
        if RuwhxnAKjldkBInfoPer.shared.ruwhxnAKjldkDevid.isEmpty {
            print("RuwhxnAKjldkBInfoPer.getDevid: \(RuwhxnAKjldkBInfoPer.shared.ruwhxnAKjldkDevid)")
            group.addTask {
                RuwhxnAKjldkBInfoPer.shared.ruwhxnAKjldkDevid = await self.getDeviceId(appId: KshwuAkjueaInformationCreate.yuryxnAhwifkAppId)
            }
        }
      
    }
    // 所有任务执行完才会走到这里
    print("get phone info")
  }

  func getLanguages() async {
    self.languages = Locale.preferredLanguages
  }

  func getTimezone() async {
    self.timezone = TimeZone.current.identifier
  }

  func checkVPN() async {

    var isVPN = false

    if let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
      let scopes = settings["__SCOPED__"] as? [String: Any]
    {

      for key in scopes.keys {
        if key.contains("tap") || key.contains("tun") || key.contains("ppp")
          || key.contains("ipsec")
        {
          isVPN = true
          break
        }
      }
    }

    self.isVpnActive = isVPN ? 1 : 0
  }

  func getInstalledApps() async {

    var installed: [String] = []

    for app in yuryxnAhwifkApps {
      if let url = URL(string: "\(app.scheme)://"),
        await UIApplication.shared.canOpenURL(url)
      {
        installed.append(app.name)
      }
    }

    self.coverAppList = installed
  }

  func getSystemKeyboards() async {
      await MainActor.run {
              let languages = UITextInputMode.activeInputModes.compactMap {
                  $0.primaryLanguage
              }
              self.keyboards = languages
          }
  }

  func getDeviceId(appId: String) async -> String {

    let identifier = await UIDevice.current.identifierForVendor?.uuidString ?? ""
    return identifier + appId
  }
}

struct KshwuAkjueaApp {
  let name: String
  let scheme: String
}

let yuryxnAhwifkApps = [
  KshwuAkjueaApp(name: "WhatsApp", scheme: "whatsapp"),
  KshwuAkjueaApp(name: "Instagram", scheme: "instagram"),
  KshwuAkjueaApp(name: "Facebook", scheme: "fb"),
  KshwuAkjueaApp(name: "TikTok", scheme: "tiktok"),
  KshwuAkjueaApp(name: "GoogleMaps", scheme: "comgooglemaps"),
  KshwuAkjueaApp(name: "twitter", scheme: "tweetie"),
  KshwuAkjueaApp(name: "qq", scheme: "mqq"),
  KshwuAkjueaApp(name: "weiChat", scheme: "wechat"),
  KshwuAkjueaApp(name: "Aliapp", scheme: "alipay"),
]
