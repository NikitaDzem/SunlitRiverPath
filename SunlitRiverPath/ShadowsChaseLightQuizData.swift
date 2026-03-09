import Foundation

struct ShadowsChaseLightQuizData {
    private static let shadowsChaseLightAllQuestions: [ShadowsChaseLightQuizQuestion] = [
        ShadowsChaseLightQuizQuestion(id: 0, shadowsChaseLightQuestion: "What do you get when you extract water from the lake?", shadowsChaseLightOptions: ["Coins", "Water", "Materials", "XP"], shadowsChaseLightCorrectIndex: 1),
        ShadowsChaseLightQuizQuestion(id: 1, shadowsChaseLightQuestion: "Where do coins from selling water go?", shadowsChaseLightOptions: ["Spirit screen", "Games", "Shop balance", "Nowhere"], shadowsChaseLightCorrectIndex: 2),
        ShadowsChaseLightQuizQuestion(id: 2, shadowsChaseLightQuestion: "How much water do you get after one extraction animation?", shadowsChaseLightOptions: ["1", "5", "10", "20"], shadowsChaseLightCorrectIndex: 2),
        ShadowsChaseLightQuizQuestion(id: 3, shadowsChaseLightQuestion: "What is the lake used for?", shadowsChaseLightOptions: ["Selling coins", "Extracting water", "Building houses", "Playing games"], shadowsChaseLightCorrectIndex: 1),
        ShadowsChaseLightQuizQuestion(id: 4, shadowsChaseLightQuestion: "Which tab has mini-games?", shadowsChaseLightOptions: ["Spirit", "Games", "Lore", "Shop"], shadowsChaseLightCorrectIndex: 1),
        ShadowsChaseLightQuizQuestion(id: 5, shadowsChaseLightQuestion: "Match the Pair rewards more coins when you use...", shadowsChaseLightOptions: ["More moves", "Fewer moves", "Same moves", "No moves"], shadowsChaseLightCorrectIndex: 1),
        ShadowsChaseLightQuizQuestion(id: 6, shadowsChaseLightQuestion: "In Bomb or Not, how many cards are there?", shadowsChaseLightOptions: ["5", "8", "10", "12"], shadowsChaseLightCorrectIndex: 2),
        ShadowsChaseLightQuizQuestion(id: 7, shadowsChaseLightQuestion: "Remember the Sequence uses how many coloured buttons?", shadowsChaseLightOptions: ["2", "3", "4", "5"], shadowsChaseLightCorrectIndex: 2),
        ShadowsChaseLightQuizQuestion(id: 8, shadowsChaseLightQuestion: "What do urban spirits need to be born?", shadowsChaseLightOptions: ["Water only", "Light and shadow for 100 years", "Coins", "Lore"], shadowsChaseLightCorrectIndex: 1),
        ShadowsChaseLightQuizQuestion(id: 9, shadowsChaseLightQuestion: "Puddles after rain are said to be...", shadowsChaseLightOptions: ["Dangerous", "Portals for spirits", "Worth coins", "Empty"], shadowsChaseLightCorrectIndex: 1),
        ShadowsChaseLightQuizQuestion(id: 10, shadowsChaseLightQuestion: "Neon signs help spirits to...", shadowsChaseLightOptions: ["Earn coins", "Live longer", "Sell water", "Play games"], shadowsChaseLightCorrectIndex: 1),
        ShadowsChaseLightQuizQuestion(id: 11, shadowsChaseLightQuestion: "The midnight hour is when...", shadowsChaseLightOptions: ["Shop opens", "Spirits repair the streets", "Lake closes", "Games reset"], shadowsChaseLightCorrectIndex: 1),
        ShadowsChaseLightQuizQuestion(id: 12, shadowsChaseLightQuestion: "Graffiti in old districts can hold...", shadowsChaseLightOptions: ["Coins", "City memory", "Water", "Nothing"], shadowsChaseLightCorrectIndex: 1),
        ShadowsChaseLightQuizQuestion(id: 13, shadowsChaseLightQuestion: "Spirits move across the city by...", shadowsChaseLightOptions: ["Car", "Rooftop", "Subway", "Shop"], shadowsChaseLightCorrectIndex: 1),
        ShadowsChaseLightQuizQuestion(id: 14, shadowsChaseLightQuestion: "What angle do spirit doors open at?", shadowsChaseLightOptions: ["90 degrees", "137 degrees", "180 degrees", "45 degrees"], shadowsChaseLightCorrectIndex: 1),
        ShadowsChaseLightQuizQuestion(id: 15, shadowsChaseLightQuestion: "Streetlights remember the name of...", shadowsChaseLightOptions: ["The mayor", "Who lit them first", "The spirit", "No one"], shadowsChaseLightCorrectIndex: 1),
        ShadowsChaseLightQuizQuestion(id: 16, shadowsChaseLightQuestion: "Subway tunnels below platforms carry...", shadowsChaseLightOptions: ["Water", "Reflections", "Coins", "Lore"], shadowsChaseLightCorrectIndex: 1),
        ShadowsChaseLightQuizQuestion(id: 17, shadowsChaseLightQuestion: "Caretakers of the streets leave...", shadowsChaseLightOptions: ["Nothing", "Offerings", "Water only", "Games"], shadowsChaseLightCorrectIndex: 1),
        ShadowsChaseLightQuizQuestion(id: 18, shadowsChaseLightQuestion: "In Bomb or Not, how many cards are bombs?", shadowsChaseLightOptions: ["3", "4", "5", "6"], shadowsChaseLightCorrectIndex: 2),
        ShadowsChaseLightQuizQuestion(id: 19, shadowsChaseLightQuestion: "Match the Pair has how many pairs?", shadowsChaseLightOptions: ["4", "6", "8", "10"], shadowsChaseLightCorrectIndex: 2)
    ]

    static func shadowsChaseLightPick10Random() -> [ShadowsChaseLightQuizQuestion] {
        Array(shadowsChaseLightAllQuestions.shuffled().prefix(10))
            .map { q in
                let correctAnswer = q.shadowsChaseLightOptions[q.shadowsChaseLightCorrectIndex]
                let shuffledOptions = q.shadowsChaseLightOptions.shuffled()
                let newIndex = shuffledOptions.firstIndex(of: correctAnswer) ?? 0
                return ShadowsChaseLightQuizQuestion(id: q.id, shadowsChaseLightQuestion: q.shadowsChaseLightQuestion, shadowsChaseLightOptions: shuffledOptions, shadowsChaseLightCorrectIndex: newIndex)
            }
    }
}
