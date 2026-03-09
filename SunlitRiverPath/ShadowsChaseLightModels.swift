import Foundation

enum ShadowsChaseLightUrbanMood: String, Codable, CaseIterable {
    case curious
    case drained
    case restless
}

enum ShadowsChaseLightInterfaceStyle: String, Codable, CaseIterable {
    case concrete = "Concrete"
    case neon = "Neon"
    case midnight = "Midnight"
}

enum ShadowsChaseLightSoundMode: String, Codable, CaseIterable {
    case cityNoise = "CityNoise"
    case calmWaves = "CalmWaves"
    case silentStreets = "SilentStreets"
}

struct ShadowsChaseLightLoreEntry: Identifiable, Codable {
    let id: String
    let shadowsChaseLightTitle: String
    let shadowsChaseLightBody: String
    var shadowsChaseLightUnlocked: Bool
}

struct ShadowsChaseLightFactEntry: Identifiable {
    let id: String
    let shadowsChaseLightFactTitle: String
    let shadowsChaseLightFactPreview: String
    let shadowsChaseLightFactFullDetail: String
}

struct ShadowsChaseLightAchievementItem: Identifiable, Codable {
    let id: String
    let shadowsChaseLightTitle: String
    let shadowsChaseLightDescription: String
    var shadowsChaseLightEarned: Bool
    let shadowsChaseLightMentorQuote: String
}

struct ShadowsChaseLightAchievementWithProgress: Identifiable {
    let id: String
    let shadowsChaseLightTitle: String
    let shadowsChaseLightDescription: String
    let shadowsChaseLightCurrent: Int
    let shadowsChaseLightTarget: Int
    var shadowsChaseLightEarned: Bool
    let shadowsChaseLightMentorQuote: String
    var shadowsChaseLightProgress: Double {
        guard shadowsChaseLightTarget > 0 else { return 1 }
        return min(1, Double(shadowsChaseLightCurrent) / Double(shadowsChaseLightTarget))
    }
}

struct ShadowsChaseLightQuizQuestion: Identifiable {
    let id: Int
    let shadowsChaseLightQuestion: String
    let shadowsChaseLightOptions: [String]
    let shadowsChaseLightCorrectIndex: Int
}

struct ShadowsChaseLightMiniGameProgress: Codable {
    var shadowsChaseLightMatchPairBestMoves: Int
    var shadowsChaseLightMatchPairGamesWon: Int
    var shadowsChaseLightRememberSequenceBestLevel: Int
    var shadowsChaseLightRememberSequenceGamesWon: Int
    var shadowsChaseLightBombOrNotGamesPlayed: Int?
}

struct ShadowsChaseLightSettingsData: Codable {
    var shadowsChaseLightLightChasePrecision: Double
    var shadowsChaseLightGraffitiCipherComplexity: Double
    var shadowsChaseLightTrafficPulseSpeed: Double
    var shadowsChaseLightInterfaceStyle: String
    var shadowsChaseLightSoundMode: String
    var shadowsChaseLightSilentStreets: Bool
}

struct ShadowsChaseLightShopItem: Identifiable {
    let id: String
    let shadowsChaseLightShopTitle: String
    let shadowsChaseLightShopDescription: String
    let shadowsChaseLightShopCost: Int
    let shadowsChaseLightShopIncomePerMinute: Int
}
