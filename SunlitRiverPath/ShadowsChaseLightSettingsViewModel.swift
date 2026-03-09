import Foundation
import Combine

final class ShadowsChaseLightSettingsViewModel: ObservableObject {
    @Published var shadowsChaseLightLightChasePrecisionValue: Double
    @Published var shadowsChaseLightGraffitiCipherComplexityValue: Double
    @Published var shadowsChaseLightTrafficPulseSpeedValue: Double
    @Published var shadowsChaseLightInterfaceStyleValue: ShadowsChaseLightInterfaceStyle
    @Published var shadowsChaseLightSoundModeValue: ShadowsChaseLightSoundMode
    @Published var shadowsChaseLightSilentStreetsEnabled: Bool
    @Published var shadowsChaseLightLightRunsCompleted: Int
    @Published var shadowsChaseLightCiphersDecoded: Int
    @Published var shadowsChaseLightPulsesStabilized: Int
    @Published var shadowsChaseLightLoreUnlockedCount: Int
    @Published var shadowsChaseLightMatchPairGamesWon: Int
    @Published var shadowsChaseLightMatchPairBestMoves: Int

    private let shadowsChaseLightStore: ShadowsChaseLightStorage
    private let shadowsChaseLightKeys = ShadowsChaseLightStorageKeys.self

    init(shadowsChaseLightStoreInstance: ShadowsChaseLightStorage = ShadowsChaseLightStorage()) {
        shadowsChaseLightStore = shadowsChaseLightStoreInstance
        let settingsData = shadowsChaseLightStore.shadowsChaseLightReadData(key: shadowsChaseLightKeys.shadowsChaseLightSettings)
        if let data = settingsData, let decoded = try? JSONDecoder().decode(ShadowsChaseLightSettingsData.self, from: data) {
            shadowsChaseLightLightChasePrecisionValue = decoded.shadowsChaseLightLightChasePrecision
            shadowsChaseLightGraffitiCipherComplexityValue = decoded.shadowsChaseLightGraffitiCipherComplexity
            shadowsChaseLightTrafficPulseSpeedValue = decoded.shadowsChaseLightTrafficPulseSpeed
            shadowsChaseLightInterfaceStyleValue = ShadowsChaseLightInterfaceStyle(rawValue: decoded.shadowsChaseLightInterfaceStyle) ?? .concrete
            shadowsChaseLightSoundModeValue = ShadowsChaseLightSoundMode(rawValue: decoded.shadowsChaseLightSoundMode) ?? .cityNoise
            shadowsChaseLightSilentStreetsEnabled = decoded.shadowsChaseLightSilentStreets
        } else {
            shadowsChaseLightLightChasePrecisionValue = 0.5
            shadowsChaseLightGraffitiCipherComplexityValue = 0.5
            shadowsChaseLightTrafficPulseSpeedValue = 0.5
            shadowsChaseLightInterfaceStyleValue = .concrete
            shadowsChaseLightSoundModeValue = .cityNoise
            shadowsChaseLightSilentStreetsEnabled = false
        }
        shadowsChaseLightLightRunsCompleted = shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightLightRunsCompleted)
        shadowsChaseLightCiphersDecoded = shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightCiphersDecoded)
        shadowsChaseLightPulsesStabilized = shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightPulsesStabilized)
        shadowsChaseLightLoreUnlockedCount = 0
        shadowsChaseLightMatchPairGamesWon = 0
        shadowsChaseLightMatchPairBestMoves = 999
        if let progressData = shadowsChaseLightStore.shadowsChaseLightReadData(key: shadowsChaseLightKeys.shadowsChaseLightMiniGameProgress),
           let progress = try? JSONDecoder().decode(ShadowsChaseLightMiniGameProgress.self, from: progressData) {
            shadowsChaseLightMatchPairGamesWon = progress.shadowsChaseLightMatchPairGamesWon
            shadowsChaseLightMatchPairBestMoves = progress.shadowsChaseLightMatchPairBestMoves
        }
    }

    func shadowsChaseLightRefreshStats() {
        shadowsChaseLightLightRunsCompleted = shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightLightRunsCompleted)
        shadowsChaseLightCiphersDecoded = shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightCiphersDecoded)
        shadowsChaseLightPulsesStabilized = shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightPulsesStabilized)
        let catalogData = shadowsChaseLightStore.shadowsChaseLightReadData(key: shadowsChaseLightKeys.shadowsChaseLightFactCatalog)
        if let data = catalogData, let catalog = try? JSONDecoder().decode([ShadowsChaseLightLoreEntry].self, from: data) {
            shadowsChaseLightLoreUnlockedCount = catalog.filter { $0.shadowsChaseLightUnlocked }.count
        }
        if let progressData = shadowsChaseLightStore.shadowsChaseLightReadData(key: shadowsChaseLightKeys.shadowsChaseLightMiniGameProgress),
           let progress = try? JSONDecoder().decode(ShadowsChaseLightMiniGameProgress.self, from: progressData) {
            shadowsChaseLightMatchPairGamesWon = progress.shadowsChaseLightMatchPairGamesWon
            shadowsChaseLightMatchPairBestMoves = progress.shadowsChaseLightMatchPairBestMoves
        }
    }

    func shadowsChaseLightPersist() {
        let payload = ShadowsChaseLightSettingsData(
            shadowsChaseLightLightChasePrecision: shadowsChaseLightLightChasePrecisionValue,
            shadowsChaseLightGraffitiCipherComplexity: shadowsChaseLightGraffitiCipherComplexityValue,
            shadowsChaseLightTrafficPulseSpeed: shadowsChaseLightTrafficPulseSpeedValue,
            shadowsChaseLightInterfaceStyle: shadowsChaseLightInterfaceStyleValue.rawValue,
            shadowsChaseLightSoundMode: shadowsChaseLightSoundModeValue.rawValue,
            shadowsChaseLightSilentStreets: shadowsChaseLightSilentStreetsEnabled
        )
        guard let data = try? JSONEncoder().encode(payload) else { return }
        shadowsChaseLightStore.shadowsChaseLightWriteData(key: shadowsChaseLightKeys.shadowsChaseLightSettings, value: data)
    }

    func shadowsChaseLightResetAllData() {
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightEssenceStability)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightGlowIntensity)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightUrbanMood)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightPathfindingFocus)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightMiniGameProgress)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightFactCatalog)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightAchievementStatus)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightSettings)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightLightFragments)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightShadowInk)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightSenseCrystals)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightCityTokens)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightLightRunsCompleted)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightCiphersDecoded)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightPulsesStabilized)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightShopBalance)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightShopOwned)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightHousesCount)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightBuildingMaterials)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightWaterCount)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightTotalWaterExtracted)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightTotalWaterSold)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightWaterSellCount)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightQuizAttempts)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightQuizTotalCorrect)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightQuizLastCorrect)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightQuizLastTotal)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightTotalXP)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightQuizPerfectCount)
        shadowsChaseLightStore.shadowsChaseLightRemove(key: shadowsChaseLightKeys.shadowsChaseLightFactsReadIds)
        shadowsChaseLightLightChasePrecisionValue = 0.5
        shadowsChaseLightGraffitiCipherComplexityValue = 0.5
        shadowsChaseLightTrafficPulseSpeedValue = 0.5
        shadowsChaseLightInterfaceStyleValue = .concrete
        shadowsChaseLightSoundModeValue = .cityNoise
        shadowsChaseLightSilentStreetsEnabled = false
        shadowsChaseLightLightRunsCompleted = 0
        shadowsChaseLightCiphersDecoded = 0
        shadowsChaseLightPulsesStabilized = 0
        shadowsChaseLightLoreUnlockedCount = 0
        shadowsChaseLightMatchPairGamesWon = 0
        shadowsChaseLightMatchPairBestMoves = 999
        shadowsChaseLightPersist()
    }
}
