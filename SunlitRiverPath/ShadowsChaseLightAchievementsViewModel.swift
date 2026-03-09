import Foundation
import Combine

final class ShadowsChaseLightAchievementsViewModel: ObservableObject {
    @Published var shadowsChaseLightAchievements: [ShadowsChaseLightAchievementWithProgress]

    private let shadowsChaseLightStore: ShadowsChaseLightStorage
    private let shadowsChaseLightKeys = ShadowsChaseLightStorageKeys.self

    static func shadowsChaseLightDefinitions() -> [(id: String, title: String, description: String, target: Int, quote: String)] {
        [
            ("first_drop", "💧 First Drop", "Extract water 1 time", 1, "The lake remembers every drop."),
            ("water_50", "🌊 Water Collector", "Extract 50 water total", 50, "Patience fills the bucket."),
            ("sell_10", "💰 First Sale", "Sell water 10 times (any amount)", 10, "The market welcomes you."),
            ("match_one", "🃏 First Pair", "Win 1 Match the Pair game", 1, "Two that match, one step closer."),
            ("match_five", "🃏 Pair Master", "Win 5 Match the Pair games", 5, "The cards obey you."),
            ("sequence_3", "🧠 Sequence Level 3", "Reach level 3 in Remember the Sequence", 3, "The pattern runs deep."),
            ("bomb_one", "💣 Bomb or Not", "Play Bomb or Not once", 1, "Luck favours the bold."),
            ("lore_3", "📖 Lore Keeper", "Open 3 lore facts", 3, "The city tells its secrets."),
            ("quiz_one", "📝 First Quiz", "Complete the quiz once", 1, "Knowledge is the first step."),
            ("quiz_perfect", "⭐ Perfect Quiz", "Answer all 10 questions correctly", 10, "Flawless. The spirit approves.")
        ]
    }

    init(shadowsChaseLightStoreInstance: ShadowsChaseLightStorage = ShadowsChaseLightStorage()) {
        shadowsChaseLightStore = shadowsChaseLightStoreInstance
        shadowsChaseLightAchievements = []
    }

    func shadowsChaseLightRefresh() {
        let earnedMap = shadowsChaseLightLoadEarned()
        let definitions = Self.shadowsChaseLightDefinitions()
        shadowsChaseLightAchievements = definitions.map { def in
            let current = shadowsChaseLightCurrentValue(for: def.id)
            let target = def.target
            var earned = earnedMap[def.id] ?? false
            if current >= target && target > 0 {
                earned = true
                shadowsChaseLightMarkEarned(achievementId: def.id)
            }
            return ShadowsChaseLightAchievementWithProgress(
                id: def.id,
                shadowsChaseLightTitle: def.title,
                shadowsChaseLightDescription: def.description,
                shadowsChaseLightCurrent: current,
                shadowsChaseLightTarget: target,
                shadowsChaseLightEarned: earned,
                shadowsChaseLightMentorQuote: def.quote
            )
        }
    }

    private func shadowsChaseLightCurrentValue(for achievementId: String) -> Int {
        switch achievementId {
        case "first_drop", "water_50":
            return shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightTotalWaterExtracted, default: 0)
        case "sell_10":
            return shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightWaterSellCount, default: 0)
        case "match_one", "match_five":
            if let data = shadowsChaseLightStore.shadowsChaseLightReadData(key: shadowsChaseLightKeys.shadowsChaseLightMiniGameProgress),
               let progress = try? JSONDecoder().decode(ShadowsChaseLightMiniGameProgress.self, from: data) {
                return progress.shadowsChaseLightMatchPairGamesWon
            }
            return 0
        case "sequence_3":
            if let data = shadowsChaseLightStore.shadowsChaseLightReadData(key: shadowsChaseLightKeys.shadowsChaseLightMiniGameProgress),
               let progress = try? JSONDecoder().decode(ShadowsChaseLightMiniGameProgress.self, from: data) {
                return progress.shadowsChaseLightRememberSequenceBestLevel
            }
            return 0
        case "bomb_one":
            if let data = shadowsChaseLightStore.shadowsChaseLightReadData(key: shadowsChaseLightKeys.shadowsChaseLightMiniGameProgress),
               let progress = try? JSONDecoder().decode(ShadowsChaseLightMiniGameProgress.self, from: data),
               let played = progress.shadowsChaseLightBombOrNotGamesPlayed {
                return played
            }
            return 0
        case "lore_3":
            if let data = shadowsChaseLightStore.shadowsChaseLightReadData(key: shadowsChaseLightKeys.shadowsChaseLightFactsReadIds),
               let ids = try? JSONDecoder().decode([String].self, from: data) {
                return ids.count
            }
            return 0
        case "quiz_one":
            return shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightQuizAttempts, default: 0)
        case "quiz_perfect":
            return shadowsChaseLightStore.shadowsChaseLightReadInt(key: shadowsChaseLightKeys.shadowsChaseLightQuizPerfectCount, default: 0) >= 1 ? 10 : 0
        default:
            return 0
        }
    }

    private func shadowsChaseLightLoadEarned() -> [String: Bool] {
        let data = shadowsChaseLightStore.shadowsChaseLightReadData(key: shadowsChaseLightKeys.shadowsChaseLightAchievementStatus)
        guard let data = data, let decoded = try? JSONDecoder().decode([ShadowsChaseLightAchievementItem].self, from: data) else {
            return [:]
        }
        return Dictionary(uniqueKeysWithValues: decoded.map { ($0.id, $0.shadowsChaseLightEarned) })
    }

    private func shadowsChaseLightMarkEarned(achievementId: String) {
        var list: [ShadowsChaseLightAchievementItem]
        let data = shadowsChaseLightStore.shadowsChaseLightReadData(key: shadowsChaseLightKeys.shadowsChaseLightAchievementStatus)
        if let data = data, let decoded = try? JSONDecoder().decode([ShadowsChaseLightAchievementItem].self, from: data) {
            list = decoded
        } else {
            list = Self.shadowsChaseLightDefinitions().map { def in
                ShadowsChaseLightAchievementItem(id: def.id, shadowsChaseLightTitle: def.title, shadowsChaseLightDescription: def.description, shadowsChaseLightEarned: false, shadowsChaseLightMentorQuote: def.quote)
            }
        }
        if let idx = list.firstIndex(where: { $0.id == achievementId }) {
            var item = list[idx]
            item.shadowsChaseLightEarned = true
            list[idx] = item
            if let encoded = try? JSONEncoder().encode(list) {
                shadowsChaseLightStore.shadowsChaseLightWriteData(key: shadowsChaseLightKeys.shadowsChaseLightAchievementStatus, value: encoded)
            }
        }
    }

    func shadowsChaseLightPersistEarned() {
        let items = shadowsChaseLightAchievements.map { a in
            ShadowsChaseLightAchievementItem(id: a.id, shadowsChaseLightTitle: a.shadowsChaseLightTitle, shadowsChaseLightDescription: a.shadowsChaseLightDescription, shadowsChaseLightEarned: a.shadowsChaseLightEarned, shadowsChaseLightMentorQuote: a.shadowsChaseLightMentorQuote)
        }
        guard let data = try? JSONEncoder().encode(items) else { return }
        shadowsChaseLightStore.shadowsChaseLightWriteData(key: shadowsChaseLightKeys.shadowsChaseLightAchievementStatus, value: data)
    }
}
