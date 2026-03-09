import Foundation

enum ShadowsChaseLightStorageKeys {
    static let shadowsChaseLightEssenceStability = "shadowsChaseLightEssenceStability"
    static let shadowsChaseLightGlowIntensity = "shadowsChaseLightGlowIntensity"
    static let shadowsChaseLightUrbanMood = "shadowsChaseLightUrbanMood"
    static let shadowsChaseLightPathfindingFocus = "shadowsChaseLightPathfindingFocus"
    static let shadowsChaseLightMiniGameProgress = "shadowsChaseLightMiniGameProgress"
    static let shadowsChaseLightFactCatalog = "shadowsChaseLightFactCatalog"
    static let shadowsChaseLightAchievementStatus = "shadowsChaseLightAchievementStatus"
    static let shadowsChaseLightSettings = "shadowsChaseLightSettings"
    static let shadowsChaseLightLightFragments = "shadowsChaseLightLightFragments"
    static let shadowsChaseLightShadowInk = "shadowsChaseLightShadowInk"
    static let shadowsChaseLightSenseCrystals = "shadowsChaseLightSenseCrystals"
    static let shadowsChaseLightCityTokens = "shadowsChaseLightCityTokens"
    static let shadowsChaseLightLightRunsCompleted = "shadowsChaseLightLightRunsCompleted"
    static let shadowsChaseLightCiphersDecoded = "shadowsChaseLightCiphersDecoded"
    static let shadowsChaseLightPulsesStabilized = "shadowsChaseLightPulsesStabilized"
    static let shadowsChaseLightLoreUnlocked = "shadowsChaseLightLoreUnlocked"
    static let shadowsChaseLightShopBalance = "shadowsChaseLightShopBalance"
    static let shadowsChaseLightShopOwned = "shadowsChaseLightShopOwned"
    static let shadowsChaseLightHousesCount = "shadowsChaseLightHousesCount"
    static let shadowsChaseLightBuildingMaterials = "shadowsChaseLightBuildingMaterials"
    static let shadowsChaseLightWaterCount = "shadowsChaseLightWaterCount"
    static let shadowsChaseLightTotalWaterExtracted = "shadowsChaseLightTotalWaterExtracted"
    static let shadowsChaseLightTotalWaterSold = "shadowsChaseLightTotalWaterSold"
    static let shadowsChaseLightWaterSellCount = "shadowsChaseLightWaterSellCount"
    static let shadowsChaseLightQuizAttempts = "shadowsChaseLightQuizAttempts"
    static let shadowsChaseLightQuizTotalCorrect = "shadowsChaseLightQuizTotalCorrect"
    static let shadowsChaseLightQuizLastCorrect = "shadowsChaseLightQuizLastCorrect"
    static let shadowsChaseLightQuizLastTotal = "shadowsChaseLightQuizLastTotal"
    static let shadowsChaseLightTotalXP = "shadowsChaseLightTotalXP"
    static let shadowsChaseLightQuizPerfectCount = "shadowsChaseLightQuizPerfectCount"
    static let shadowsChaseLightFactsReadIds = "shadowsChaseLightFactsReadIds"
}

struct ShadowsChaseLightStorage {
    private let shadowsChaseLightDefaults: UserDefaults

    init(shadowsChaseLightDefaultsInstance: UserDefaults = .standard) {
        shadowsChaseLightDefaults = shadowsChaseLightDefaultsInstance
    }

    func shadowsChaseLightReadInt(key: String) -> Int {
        shadowsChaseLightDefaults.object(forKey: key) as? Int ?? 50
    }

    func shadowsChaseLightReadInt(key: String, default defaultValue: Int) -> Int {
        shadowsChaseLightDefaults.object(forKey: key) as? Int ?? defaultValue
    }

    func shadowsChaseLightWriteInt(key: String, value: Int) {
        shadowsChaseLightDefaults.set(value, forKey: key)
    }

    func shadowsChaseLightReadString(key: String) -> String? {
        shadowsChaseLightDefaults.string(forKey: key)
    }

    func shadowsChaseLightWriteString(key: String, value: String) {
        shadowsChaseLightDefaults.set(value, forKey: key)
    }

    func shadowsChaseLightReadData(key: String) -> Data? {
        shadowsChaseLightDefaults.data(forKey: key)
    }

    func shadowsChaseLightWriteData(key: String, value: Data) {
        shadowsChaseLightDefaults.set(value, forKey: key)
    }

    func shadowsChaseLightReadBool(key: String) -> Bool {
        shadowsChaseLightDefaults.object(forKey: key) as? Bool ?? false
    }

    func shadowsChaseLightWriteBool(key: String, value: Bool) {
        shadowsChaseLightDefaults.set(value, forKey: key)
    }

    func shadowsChaseLightRemove(key: String) {
        shadowsChaseLightDefaults.removeObject(forKey: key)
    }
}
