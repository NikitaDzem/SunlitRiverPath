import Foundation
import Combine

final class ShadowsChaseLightShopViewModel: ObservableObject {
    @Published var shadowsChaseLightBalance: Int
    @Published var shadowsChaseLightOwnedCounts: [String: Int]
    @Published var shadowsChaseLightOverlayMessage: ShadowsChaseLightShopOverlayMessage?
    @Published var shadowsChaseLightSelectedItem: ShadowsChaseLightShopItem?
    @Published var shadowsChaseLightTotalIncomePerMinute: Int = 0

    private let shadowsChaseLightStore: ShadowsChaseLightStorage
    private let shadowsChaseLightKeys = ShadowsChaseLightStorageKeys.self
    private var shadowsChaseLightPassiveIncomeWorkItem: DispatchWorkItem?
    private let shadowsChaseLightPassiveQueue = DispatchQueue(label: "com.shadowschaselight.shop.passive", qos: .utility)

    static func shadowsChaseLightShopItemsList() -> [ShadowsChaseLightShopItem] {
        [
            ShadowsChaseLightShopItem(id: "shop_building_kit", shadowsChaseLightShopTitle: "Building materials", shadowsChaseLightShopDescription: "Materials to build a house on the Spirit screen. Each house earns +1 coin/min. Demolish returns 50% coins.", shadowsChaseLightShopCost: 30, shadowsChaseLightShopIncomePerMinute: 0),
            ShadowsChaseLightShopItem(id: "shop_lamp", shadowsChaseLightShopTitle: "Street Lamp", shadowsChaseLightShopDescription: "A steady light for the spirit. Earns coins over time.", shadowsChaseLightShopCost: 50, shadowsChaseLightShopIncomePerMinute: 2),
            ShadowsChaseLightShopItem(id: "shop_neon", shadowsChaseLightShopTitle: "Neon Sign", shadowsChaseLightShopDescription: "Bright neon attracts urban spirits and coins.", shadowsChaseLightShopCost: 150, shadowsChaseLightShopIncomePerMinute: 6),
            ShadowsChaseLightShopItem(id: "shop_subway", shadowsChaseLightShopTitle: "Subway Token", shadowsChaseLightShopDescription: "Old transit charm. Passive income from the underground.", shadowsChaseLightShopCost: 400, shadowsChaseLightShopIncomePerMinute: 15),
            ShadowsChaseLightShopItem(id: "shop_rooftop", shadowsChaseLightShopTitle: "Rooftop Beacon", shadowsChaseLightShopDescription: "Spirits cross the city by rooftop. This beacon pays well.", shadowsChaseLightShopCost: 1000, shadowsChaseLightShopIncomePerMinute: 40),
            ShadowsChaseLightShopItem(id: "shop_puddle", shadowsChaseLightShopTitle: "Reflection Pool", shadowsChaseLightShopDescription: "A small portal. Coins flow through reflections.", shadowsChaseLightShopCost: 2500, shadowsChaseLightShopIncomePerMinute: 100),
            ShadowsChaseLightShopItem(id: "shop_district", shadowsChaseLightShopTitle: "District Shrine", shadowsChaseLightShopDescription: "Honour the spirits of a whole district. High yield.", shadowsChaseLightShopCost: 6000, shadowsChaseLightShopIncomePerMinute: 250)
        ]
    }

    init(shadowsChaseLightStoreInstance: ShadowsChaseLightStorage = ShadowsChaseLightStorage()) {
        shadowsChaseLightStore = shadowsChaseLightStoreInstance
        shadowsChaseLightBalance = shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightShopBalance)
        let ownedData = shadowsChaseLightStore.shadowsChaseLightReadData(key: shadowsChaseLightKeys.shadowsChaseLightShopOwned)
        if let data = ownedData,
           let decoded = try? JSONDecoder().decode([String: Int].self, from: data) {
            shadowsChaseLightOwnedCounts = decoded
        } else {
            shadowsChaseLightOwnedCounts = [:]
        }
        if shadowsChaseLightBalance <= 50 && shadowsChaseLightOwnedCounts.isEmpty {
            shadowsChaseLightBalance = 100
            shadowsChaseLightStore.shadowsChaseLightWriteInt(key: shadowsChaseLightKeys.shadowsChaseLightShopBalance, value: 100)
        }
        shadowsChaseLightRecalcTotalIncome()
        shadowsChaseLightStartPassiveIncome()
    }

    func shadowsChaseLightRecalcTotalIncome() {
        let items = Self.shadowsChaseLightShopItemsList()
        var total = 0
        for (id, count) in shadowsChaseLightOwnedCounts {
            if let item = items.first(where: { $0.id == id }) {
                total += count * item.shadowsChaseLightShopIncomePerMinute
            }
        }
        let housesCount = shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightHousesCount, default: 0)
        total += housesCount
        shadowsChaseLightTotalIncomePerMinute = total
    }

    func shadowsChaseLightStartPassiveIncome() {
        func shadowsChaseLightScheduleNext() {
            shadowsChaseLightPassiveIncomeWorkItem = DispatchWorkItem { [weak self] in
                guard let self = self else { return }
                let items = Self.shadowsChaseLightShopItemsList()
                var totalPerMin = 0
                for (id, count) in self.shadowsChaseLightOwnedCounts {
                    if let item = items.first(where: { $0.id == id }) {
                        totalPerMin += count * item.shadowsChaseLightShopIncomePerMinute
                    }
                }
                let housesCount = self.shadowsChaseLightStore.shadowsChaseLightReadInt(key: self.shadowsChaseLightKeys.shadowsChaseLightHousesCount, default: 0)
                totalPerMin += housesCount
                guard totalPerMin > 0 else {
                    self.shadowsChaseLightPassiveQueue.asyncAfter(deadline: .now() + 60, execute: shadowsChaseLightScheduleNext)
                    return
                }
                let currentBalance = self.shadowsChaseLightStore.shadowsChaseLightReadInt(key: self.shadowsChaseLightKeys.shadowsChaseLightShopBalance)
                let newBalance = currentBalance + totalPerMin
                self.shadowsChaseLightStore.shadowsChaseLightWriteInt(key: self.shadowsChaseLightKeys.shadowsChaseLightShopBalance, value: newBalance)
                DispatchQueue.main.async {
                    self.shadowsChaseLightBalance = newBalance
                }
                self.shadowsChaseLightPassiveQueue.asyncAfter(deadline: .now() + 60, execute: shadowsChaseLightScheduleNext)
            }
            shadowsChaseLightPassiveQueue.asyncAfter(deadline: .now() + 60, execute: shadowsChaseLightPassiveIncomeWorkItem!)
        }
        shadowsChaseLightScheduleNext()
    }

    func shadowsChaseLightPurchase(item: ShadowsChaseLightShopItem) {
        guard shadowsChaseLightBalance >= item.shadowsChaseLightShopCost else {
            shadowsChaseLightOverlayMessage = .notEnoughCoins(needed: item.shadowsChaseLightShopCost)
            return
        }
        if item.id == "shop_building_kit" {
            let newBalance = shadowsChaseLightBalance - item.shadowsChaseLightShopCost
            let materials = shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightBuildingMaterials, default: 0) + 1
            shadowsChaseLightBalance = newBalance
            shadowsChaseLightStore.shadowsChaseLightWriteInt(key: shadowsChaseLightKeys.shadowsChaseLightShopBalance, value: newBalance)
            shadowsChaseLightStore.shadowsChaseLightWriteInt(key: shadowsChaseLightKeys.shadowsChaseLightBuildingMaterials, value: materials)
            shadowsChaseLightRecalcTotalIncome()
            shadowsChaseLightSelectedItem = nil
            shadowsChaseLightOverlayMessage = .purchaseSuccess(item: item)
            return
        }
        let newBalance = shadowsChaseLightBalance - item.shadowsChaseLightShopCost
        let count = (shadowsChaseLightOwnedCounts[item.id] ?? 0) + 1
        shadowsChaseLightOwnedCounts[item.id] = count
        shadowsChaseLightBalance = newBalance
        shadowsChaseLightStore.shadowsChaseLightWriteInt(key: shadowsChaseLightKeys.shadowsChaseLightShopBalance, value: newBalance)
        if let data = try? JSONEncoder().encode(shadowsChaseLightOwnedCounts) {
            shadowsChaseLightStore.shadowsChaseLightWriteData(key: shadowsChaseLightKeys.shadowsChaseLightShopOwned, value: data)
        }
        shadowsChaseLightRecalcTotalIncome()
        shadowsChaseLightSelectedItem = nil
        shadowsChaseLightOverlayMessage = .purchaseSuccess(item: item)
    }

    func shadowsChaseLightCloseOverlay() {
        shadowsChaseLightOverlayMessage = nil
    }

    func shadowsChaseLightClosePurchaseSheet() {
        shadowsChaseLightSelectedItem = nil
    }

    func shadowsChaseLightAddTestCoins() {
        shadowsChaseLightBalance += 500
        shadowsChaseLightStore.shadowsChaseLightWriteInt(key: shadowsChaseLightKeys.shadowsChaseLightShopBalance, value: shadowsChaseLightBalance)
    }

    func shadowsChaseLightOwnedCount(for itemId: String) -> Int {
        shadowsChaseLightOwnedCounts[itemId] ?? 0
    }

    func shadowsChaseLightRefreshBalance() {
        shadowsChaseLightBalance = shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightShopBalance)
    }
}

enum ShadowsChaseLightShopOverlayMessage {
    case purchaseSuccess(item: ShadowsChaseLightShopItem)
    case notEnoughCoins(needed: Int)
}
