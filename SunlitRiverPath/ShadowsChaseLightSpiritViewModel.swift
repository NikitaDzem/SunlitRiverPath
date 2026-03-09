import Foundation
import Combine

final class ShadowsChaseLightSpiritViewModel: ObservableObject {
    @Published var shadowsChaseLightWaterCount: Int

    static let shadowsChaseLightWaterPricePerUnit = 5

    private let shadowsChaseLightStore: ShadowsChaseLightStorage
    private let shadowsChaseLightKeys = ShadowsChaseLightStorageKeys.self

    init(shadowsChaseLightStoreInstance: ShadowsChaseLightStorage = ShadowsChaseLightStorage()) {
        shadowsChaseLightStore = shadowsChaseLightStoreInstance
        shadowsChaseLightWaterCount = shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightWaterCount, default: 0)
    }

    func shadowsChaseLightRefresh() {
        shadowsChaseLightWaterCount = shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightWaterCount, default: 0)
    }

    func shadowsChaseLightExtractWater() {
        shadowsChaseLightWaterCount += 1
        shadowsChaseLightStore.shadowsChaseLightWriteInt(key: shadowsChaseLightKeys.shadowsChaseLightWaterCount, value: shadowsChaseLightWaterCount)
    }

    func shadowsChaseLightAddWater(_ amount: Int) {
        shadowsChaseLightWaterCount += amount
        shadowsChaseLightStore.shadowsChaseLightWriteInt(key: shadowsChaseLightKeys.shadowsChaseLightWaterCount, value: shadowsChaseLightWaterCount)
        let total = shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightTotalWaterExtracted, default: 0) + amount
        shadowsChaseLightStore.shadowsChaseLightWriteInt(key: shadowsChaseLightKeys.shadowsChaseLightTotalWaterExtracted, value: total)
    }

    func shadowsChaseLightSellWater() {
        guard shadowsChaseLightWaterCount >= 1 else { return }
        let amountSold = shadowsChaseLightWaterCount
        let coinsEarned = amountSold * Self.shadowsChaseLightWaterPricePerUnit
        shadowsChaseLightWaterCount = 0
        shadowsChaseLightStore.shadowsChaseLightWriteInt(key: shadowsChaseLightKeys.shadowsChaseLightWaterCount, value: 0)
        let totalSold = shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightTotalWaterSold, default: 0) + amountSold
        shadowsChaseLightStore.shadowsChaseLightWriteInt(key: shadowsChaseLightKeys.shadowsChaseLightTotalWaterSold, value: totalSold)
        let sellCount = shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightWaterSellCount, default: 0) + 1
        shadowsChaseLightStore.shadowsChaseLightWriteInt(key: shadowsChaseLightKeys.shadowsChaseLightWaterSellCount, value: sellCount)
        let balance = shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightShopBalance)
        shadowsChaseLightStore.shadowsChaseLightWriteInt(key: shadowsChaseLightKeys.shadowsChaseLightShopBalance, value: balance + coinsEarned)
    }
}
