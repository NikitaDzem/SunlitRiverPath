import Foundation
import Combine

final class ShadowsChaseLightMiniGamesViewModel: ObservableObject {
    @Published var shadowsChaseLightProgress: ShadowsChaseLightMiniGameProgress
    private let shadowsChaseLightStore: ShadowsChaseLightStorage

    init(shadowsChaseLightStoreInstance: ShadowsChaseLightStorage = ShadowsChaseLightStorage()) {
        shadowsChaseLightStore = shadowsChaseLightStoreInstance
        let data = shadowsChaseLightStore.shadowsChaseLightReadData(key: ShadowsChaseLightStorageKeys.shadowsChaseLightMiniGameProgress)
        if let data = data, let decoded = try? JSONDecoder().decode(ShadowsChaseLightMiniGameProgress.self, from: data) {
            shadowsChaseLightProgress = decoded
        } else {
            shadowsChaseLightProgress = ShadowsChaseLightMiniGameProgress(shadowsChaseLightMatchPairBestMoves: 999, shadowsChaseLightMatchPairGamesWon: 0, shadowsChaseLightRememberSequenceBestLevel: 0, shadowsChaseLightRememberSequenceGamesWon: 0, shadowsChaseLightBombOrNotGamesPlayed: 0)
        }
    }

    func shadowsChaseLightSaveProgress() {
        guard let data = try? JSONEncoder().encode(shadowsChaseLightProgress) else { return }
        shadowsChaseLightStore.shadowsChaseLightWriteData(key: ShadowsChaseLightStorageKeys.shadowsChaseLightMiniGameProgress, value: data)
    }

    func shadowsChaseLightUpdateMatchPair(moves: Int) {
        if moves < shadowsChaseLightProgress.shadowsChaseLightMatchPairBestMoves {
            shadowsChaseLightProgress.shadowsChaseLightMatchPairBestMoves = moves
        }
        shadowsChaseLightProgress.shadowsChaseLightMatchPairGamesWon += 1
        shadowsChaseLightSaveProgress()
        let reward = max(15, 50 - moves)
        let balance = shadowsChaseLightStore.shadowsChaseLightReadInt(key: ShadowsChaseLightStorageKeys.shadowsChaseLightShopBalance)
        shadowsChaseLightStore.shadowsChaseLightWriteInt(key: ShadowsChaseLightStorageKeys.shadowsChaseLightShopBalance, value: balance + reward)
    }

    func shadowsChaseLightUpdateRememberSequence(level: Int) {
        if level > shadowsChaseLightProgress.shadowsChaseLightRememberSequenceBestLevel {
            shadowsChaseLightProgress.shadowsChaseLightRememberSequenceBestLevel = level
        }
        shadowsChaseLightProgress.shadowsChaseLightRememberSequenceGamesWon += 1
        shadowsChaseLightSaveProgress()
        let reward = 10 + level * 5
        let balance = shadowsChaseLightStore.shadowsChaseLightReadInt(key: ShadowsChaseLightStorageKeys.shadowsChaseLightShopBalance)
        shadowsChaseLightStore.shadowsChaseLightWriteInt(key: ShadowsChaseLightStorageKeys.shadowsChaseLightShopBalance, value: balance + reward)
    }

    func shadowsChaseLightUpdateBombOrNot(coinsWon: Int) {
        let played = shadowsChaseLightProgress.shadowsChaseLightBombOrNotGamesPlayed ?? 0
        shadowsChaseLightProgress.shadowsChaseLightBombOrNotGamesPlayed = played + 1
        shadowsChaseLightSaveProgress()
        if coinsWon > 0 {
            let balance = shadowsChaseLightStore.shadowsChaseLightReadInt(key: ShadowsChaseLightStorageKeys.shadowsChaseLightShopBalance)
            shadowsChaseLightStore.shadowsChaseLightWriteInt(key: ShadowsChaseLightStorageKeys.shadowsChaseLightShopBalance, value: balance + coinsWon)
        }
    }
}
