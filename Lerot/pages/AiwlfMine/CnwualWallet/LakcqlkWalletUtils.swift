
import StoreKit
import SwiftUI
import FBSDKCoreKit

struct LakcqlkProduct {
  let lakcqlkKeyId: String
  let lakcqlkGetDiamond: Int
  let lakcqlkPrice: Double
}

let bjealALiwlProducst: [LakcqlkProduct] = [
  LakcqlkProduct(
    lakcqlkKeyId: "uuawqenxoegktdwt", lakcqlkGetDiamond: 400, lakcqlkPrice: 0.99),
  LakcqlkProduct(
    lakcqlkKeyId: "nyembqgosvgtozwi", lakcqlkGetDiamond: 800, lakcqlkPrice: 1.99),
  LakcqlkProduct(
    lakcqlkKeyId: "zwxcpceamjhsipot", lakcqlkGetDiamond: 2450, lakcqlkPrice: 4.99),
  LakcqlkProduct(
    lakcqlkKeyId: "rtykqvbnzplmdxua", lakcqlkGetDiamond: 3950, lakcqlkPrice: 7.99),
  LakcqlkProduct(
    lakcqlkKeyId: "viqolchsyyjuqdjy", lakcqlkGetDiamond: 5150, lakcqlkPrice: 9.99),
  LakcqlkProduct(
    lakcqlkKeyId: "hzmqplrtsvknadwx", lakcqlkGetDiamond: 8900, lakcqlkPrice: 17.99),
  LakcqlkProduct(
    lakcqlkKeyId: "kgcnuowkmlnwgphn", lakcqlkGetDiamond: 10800, lakcqlkPrice: 19.99),
  LakcqlkProduct(
    lakcqlkKeyId: "lxqvmpztnkrsadhw", lakcqlkGetDiamond: 14900, lakcqlkPrice: 29.99),
  LakcqlkProduct(
    lakcqlkKeyId: "qemafkhibigxyipb", lakcqlkGetDiamond: 29400, lakcqlkPrice: 49.99),
  LakcqlkProduct(
    lakcqlkKeyId: "cvmelsnxidysnzfl", lakcqlkGetDiamond: 63700, lakcqlkPrice: 99.99)
]

enum LakcqlkPurchaseResult {
    case success(diamond: Int)
    case cancelled
    case pending
    case failed(message: String)
}

class LakcqlkIAPManager: NSObject, ObservableObject {
    
    @Published var products: [SKProduct] = []
    
    private var request: SKProductsRequest?
    private var lasuiwCOmpletion: ((LakcqlkPurchaseResult) -> Void)?
    
    // MARK: - 初始化
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    
    private var zwALwuxciwWilf = 0
    private let maxRetryCount = 3
    private var isRequesting = false
    
    // MARK: - 拉取商品
    func woiqhnFqoietchProducts() {
        guard products.isEmpty else { return }
        guard !isRequesting else { return }
        
        isRequesting = true
        zwALwuxciwWilf = 0
        
        startRequest()
    }
    private func startRequest() {
        let ids = Set(bjealALiwlProducst.map { $0.lakcqlkKeyId })
        
        request?.cancel()
        
        let newRequest = SKProductsRequest(productIdentifiers: ids)
        newRequest.delegate = self
        self.request = newRequest
        
        newRequest.start()
    }
    
    // MARK: - 对外购买入口
    func cmeuoALwlnRecharge(
        _ productKeyId: String,
        lasuiwCOmpletion: ((LakcqlkPurchaseResult) -> Void)? = nil
    ) {
        LealoeoHUD.showLoading()
//        isPurchasing = true
        
        print("IAPManager recharge:", ObjectIdentifier(self))
        
        // 保存回调（可选）
        self.lasuiwCOmpletion = lasuiwCOmpletion
        
        // 确保商品已加载
        if products.isEmpty {
            woiqhnFqoietchProducts()
        }
        
        guard let product = products.first(where: { $0.productIdentifier == productKeyId }) else {
            LealoeoHUD.hideLoading()
//            isPurchasing = false
            
            lasuiwCOmpletion?(.failed(message: "Product not found"))
            return
        }
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
}

extension LakcqlkIAPManager: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        
        print("Loaded products:", products.map { $0.productIdentifier })
        
        // 重置状态
        isRequesting = false
        zwALwuxciwWilf = 0
        
        if !response.invalidProductIdentifiers.isEmpty {
            print("Invalid IDs:", response.invalidProductIdentifiers)
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Fetch products failed:", error)
        
        zwALwuxciwWilf += 1
        
        if zwALwuxciwWilf <= maxRetryCount {
            let delay = pow(2.0, Double(zwALwuxciwWilf)) // 2s, 4s, 8s
            
            print("Retrying in \(delay)s... (\(zwALwuxciwWilf)/\(maxRetryCount))")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                self?.startRequest()
            }
        } else {
            isRequesting = false
            LealoeoHUD.error("Load products failed")
        }
    }
    
   
}

extension LakcqlkIAPManager: SKPaymentTransactionObserver {
    
    private func findWalletItem(productID: String) -> LakcqlkProduct? {
        bjealALiwlProducst.first { $0.lakcqlkKeyId == productID }
    }
    
    // MARK: - Facebook 埋点
    private func peiaWUkAKwuFBLog(price: Double) {
        AppEvents.shared.logPurchase(
            amount: price,
            currency: "USD",
            parameters: [AppEvents.ParameterName(rawValue: "fb_mobile_purchase"): "true"]
        )
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch transaction.transactionState {
                
            case .purchased:
                guard let model = findWalletItem(productID: transaction.payment.productIdentifier) else {
                    LealoeoHUD.error("Product config not found")
                    SKPaymentQueue.default().finishTransaction(transaction)
                    LealoeoHUD.hideLoading()
                    return
                }
                
                if VaiETdgbaAppStorage.vaiETdgbaIsB {
                    Task{
                        let xiwalAWInxclakPurId = transaction.transactionIdentifier ?? ""
                        let cueAKwukfalVerificationData: String
                        if let receiptURL = Bundle.main.appStoreReceiptURL,
                           let receiptData = try? Data(contentsOf: receiptURL)
                        {
                            cueAKwukfalVerificationData = receiptData.base64EncodedString()
                        } else {
                            cueAKwukfalVerificationData = ""
                        }
                        let siueAKLuwxjeiVertify = try await VNehalAUApiCall().eskaLAkafPayCall(
                            purchaseID: xiwalAWInxclakPurId,
                            serverVerificationData: cueAKwukfalVerificationData,  // StoreKit1 没有 JWS，通常传空或自签
                            orderCode: yuryxnAhwifkUsersOrdercode
                        )

                        if siueAKLuwxjeiVertify {
                            peiaWUkAKwuFBLog(price: model.lakcqlkPrice) // fb
                            await UwhxAUBSKAdjustManager.shared.slwinxAiuwnTrackPurchase(dollar: model.lakcqlkPrice) // adjust
                            SKPaymentQueue.default().finishTransaction(transaction)
                            LealoeoHUD.success("Purchase success")
                        } else {
                            SKPaymentQueue.default().finishTransaction(transaction)
                            LealoeoHUD.error("Purchase unverified")
                        }

                        LealoeoHUD.hideLoading()
                    }
                }else {
                    SKPaymentQueue.default().finishTransaction(transaction)
                    LealoeoHUD.hideLoading()
                    
                    lasuiwCOmpletion?(.success(diamond: 0)) // ⚠️ 你需要自己映射 diamond
                    lasuiwCOmpletion = nil
                }
                
                
                
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                LealoeoHUD.hideLoading()
                
                if let error = transaction.error as? SKError,
                   error.code == .paymentCancelled {
                    lasuiwCOmpletion?(.cancelled)
                } else {
                    lasuiwCOmpletion?(.failed(message: transaction.error?.localizedDescription ?? "Purchase failed"))
                }
                
                lasuiwCOmpletion = nil
                
            case .purchasing:
                break
                
            case .deferred:
                // 类似 StoreKit2 的 pending
                lasuiwCOmpletion?(.pending)
                
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                
            @unknown default:
                break
            }
        }
    }
}
