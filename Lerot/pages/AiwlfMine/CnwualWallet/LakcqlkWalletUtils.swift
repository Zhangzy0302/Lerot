
import StoreKit
import SwiftUI

struct LakcqlkProduct {
  let lakcqlkKeyId: String
  let lakcqlkGetDiamond: Int
  let lakcqlkPrice: Double
}

let ghuencziwProducts: [LakcqlkProduct] = [
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

@MainActor
class LakcqlkIAPManager: ObservableObject {

    @Published var products: [Product] = []

    // MARK: - 拉取商品
    func woiqhnFqoietchProducts() async {
        guard products.isEmpty else { return }

        do {
            let ids = ghuencziwProducts.map { $0.lakcqlkKeyId }
            products = try await Product.products(for: ids)
            print("Loaded products:", products.map { $0.id })
        } catch {
            LealoeoHUD.error("Load products failed: \(error.localizedDescription)")
            print("Fetch products failed:", error)
        }
    }

    // MARK: - 对外购买入口
    func cmeuoALwlnRecharge(
        _ model: LakcqlkProduct
    ) async -> LakcqlkPurchaseResult {

        LealoeoHUD.showLoading()

        // 确保商品已加载
        if products.isEmpty {
            await woiqhnFqoietchProducts()
        }

        guard let product = products.first(where: { $0.id == model.lakcqlkKeyId }) else {
            LealoeoHUD.hideLoading()
            return .failed(message: "Product not found")
        }

        do {
            let result = try await product.purchase()

            switch result {

            case .success(let verification):
                if case .verified(let transaction) = verification {
                    await transaction.finish()
                    LealoeoHUD.hideLoading()
                    return .success(diamond: model.lakcqlkGetDiamond)
                } else {
                    LealoeoHUD.hideLoading()
                    return .failed(message: "Purchase unverified")
                }

            case .userCancelled:
                LealoeoHUD.hideLoading()
                return .cancelled

            case .pending:
                // pending 不关 loading
                return .pending

            @unknown default:
                LealoeoHUD.hideLoading()
                return .failed(message: "Unknown purchase result")
            }

        } catch {
            LealoeoHUD.hideLoading()
            return .failed(message: error.localizedDescription)
        }
    }
}
