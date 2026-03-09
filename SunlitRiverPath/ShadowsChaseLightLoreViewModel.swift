import Foundation
import Combine

final class ShadowsChaseLightLoreViewModel: ObservableObject {
    @Published var shadowsChaseLightCatalog: [ShadowsChaseLightLoreEntry]

    private let shadowsChaseLightStore: ShadowsChaseLightStorage

    static func shadowsChaseLightDefaultCatalog() -> [ShadowsChaseLightLoreEntry] {
        [
            ShadowsChaseLightLoreEntry(id: "hidden_geometry", shadowsChaseLightTitle: "Hidden City Geometry", shadowsChaseLightBody: "The streets form angles only spirits can see. Where two alleys meet at 137 degrees, a door opens at midnight.", shadowsChaseLightUnlocked: false),
            ShadowsChaseLightLoreEntry(id: "streetlight_myth", shadowsChaseLightTitle: "Streetlight Mythology", shadowsChaseLightBody: "Every sodium lamp holds a pact. The first streetlight of each district remembers the name of the one who lit it.", shadowsChaseLightUnlocked: false),
            ShadowsChaseLightLoreEntry(id: "subway_legends", shadowsChaseLightTitle: "Forgotten Subway Legends", shadowsChaseLightBody: "Below the platforms, older tunnels run. Trains that never appear on maps still pass through, carrying only reflections.", shadowsChaseLightUnlocked: false),
            ShadowsChaseLightLoreEntry(id: "spirit_origins", shadowsChaseLightTitle: "Origins of Urban Spirits", shadowsChaseLightBody: "Urban spirits are born when light and shadow meet in the same place for a hundred years. They are the city remembering itself.", shadowsChaseLightUnlocked: false)
        ]
    }

    init(shadowsChaseLightStoreInstance: ShadowsChaseLightStorage = ShadowsChaseLightStorage()) {
        shadowsChaseLightStore = shadowsChaseLightStoreInstance
        let data = shadowsChaseLightStore.shadowsChaseLightReadData(key: ShadowsChaseLightStorageKeys.shadowsChaseLightFactCatalog)
        if let data = data, let decoded = try? JSONDecoder().decode([ShadowsChaseLightLoreEntry].self, from: data) {
            shadowsChaseLightCatalog = decoded
        } else {
            shadowsChaseLightCatalog = Self.shadowsChaseLightDefaultCatalog()
        }
    }

    func shadowsChaseLightUnlock(entryId: String) {
        if let idx = shadowsChaseLightCatalog.firstIndex(where: { $0.id == entryId }) {
            var entry = shadowsChaseLightCatalog[idx]
            entry.shadowsChaseLightUnlocked = true
            shadowsChaseLightCatalog[idx] = entry
            shadowsChaseLightPersist()
        }
    }

    func shadowsChaseLightUnlockAll() {
        for i in shadowsChaseLightCatalog.indices {
            var entry = shadowsChaseLightCatalog[i]
            entry.shadowsChaseLightUnlocked = true
            shadowsChaseLightCatalog[i] = entry
        }
        shadowsChaseLightPersist()
    }

    func shadowsChaseLightPersist() {
        guard let data = try? JSONEncoder().encode(shadowsChaseLightCatalog) else { return }
        shadowsChaseLightStore.shadowsChaseLightWriteData(key: ShadowsChaseLightStorageKeys.shadowsChaseLightFactCatalog, value: data)
    }

    func shadowsChaseLightUnlockedCount() -> Int {
        shadowsChaseLightCatalog.filter { $0.shadowsChaseLightUnlocked }.count
    }

    static func shadowsChaseLightFactsList() -> [ShadowsChaseLightFactEntry] {
        [
            ShadowsChaseLightFactEntry(
                id: "fact_geometry",
                shadowsChaseLightFactTitle: "Hidden City Geometry",
                shadowsChaseLightFactPreview: "Street angles visible only to spirits.",
                shadowsChaseLightFactFullDetail: "The streets form angles only spirits can see. Where two alleys meet at 137 degrees, a door opens at midnight. Surveyors have tried to map these intersections for centuries; their instruments always show 90 or 180. Yet those who walk with urban spirits report corners that bend the eye. The 137° junctions appear only in certain light—sodium vapour at dusk, or the first neon after rain. Through these openings, the city’s older layers remain accessible: cobbles under asphalt, forgotten tram lines, and the names of streets that no longer exist. Architects who respect these angles say their buildings stand longer and feel quieter at night."
            ),
            ShadowsChaseLightFactEntry(
                id: "fact_streetlight",
                shadowsChaseLightFactTitle: "Streetlight Mythology",
                shadowsChaseLightFactPreview: "Every streetlight holds a pact.",
                shadowsChaseLightFactFullDetail: "Every sodium lamp holds a pact. The first streetlight of each district remembers the name of the one who lit it. In the oldest neighbourhoods, the names are still spoken at midnight by maintenance crews who inherited the duty. Newer districts have forgotten; their lamps flicker more often and attract fewer spirits. The mythology says that when the last keeper of a district’s first light dies without passing the name on, that street goes dim for one night every year. Some say you can hear the name in the hum of the transformer. Others say the spirits themselves whisper it to those who stand still long enough under the lamp."
            ),
            ShadowsChaseLightFactEntry(
                id: "fact_subway",
                shadowsChaseLightFactTitle: "Forgotten Subway Legends",
                shadowsChaseLightFactPreview: "Older tunnels run below the platforms.",
                shadowsChaseLightFactFullDetail: "Below the platforms, older tunnels run. Trains that never appear on maps still pass through, carrying only reflections. Workers who have been in the deepest levels describe corridors that match no blueprint: tiles in patterns that were never approved, and stations with no exits to the surface. The reflections in the train windows are said to be older than the city above. Some passengers claim to have boarded by mistake and ridden for hours before stepping out at a familiar stop, their watches unchanged. Transit authorities do not confirm or deny; they only advise staying behind the yellow line and avoiding the last car after midnight."
            ),
            ShadowsChaseLightFactEntry(
                id: "fact_origins",
                shadowsChaseLightFactTitle: "Origins of Urban Spirits",
                shadowsChaseLightFactPreview: "Spirits are born where light meets shadow.",
                shadowsChaseLightFactFullDetail: "Urban spirits are born when light and shadow meet in the same place for a hundred years. They are the city remembering itself. The first signs are small: a patch of pavement that stays dry in the rain, or a reflection that doesn’t match the person standing there. As the spirit grows stronger, it learns to move between streetlights and shop windows, between puddles and neon signs. It has no voice of its own at first; it borrows the sounds of the street—engines, footsteps, snatches of conversation. Those who care for a young spirit say it is like raising a child who can only see in reflections. In return, the spirit may one day show you the city as it was, or as it could be."
            ),
            ShadowsChaseLightFactEntry(
                id: "fact_rooftops",
                shadowsChaseLightFactTitle: "Rooftop Crossings",
                shadowsChaseLightFactPreview: "Spirits cross from roof to roof.",
                shadowsChaseLightFactFullDetail: "Spirits move across the city by rooftop. The gaps between buildings are not empty to them; they step on updrafts, on the heat rising from vents, on the memory of bridges that once connected the upper floors. If you see a shadow that crosses from one roof to another without a body, it is likely a spirit in a hurry. They prefer clear nights when the neon below draws sharp lines. Old fire escapes and water towers mark their resting places. Some buildings have left out bowls of light—old lamps, left on—as offerings. The spirits rarely take the light; they only pause there, and the building sleeps more quietly afterward."
            ),
            ShadowsChaseLightFactEntry(
                id: "fact_graffiti",
                shadowsChaseLightFactTitle: "Graffiti as Memory",
                shadowsChaseLightFactPreview: "Graffiti holds what the city forgot.",
                shadowsChaseLightFactFullDetail: "Graffiti in the oldest districts is not only paint. Spirits use walls to store what the city has forgotten: names of streets, faces of the missing, dates of events that never made the news. The symbols overlap and fade; decoding them requires both patience and the right light. Dawn and dusk are best, when the angle of the sun matches the angle at which the spirit wrote. Some murals have been painted over dozens of times, but the oldest layer still shows through in certain weather. Restorers who work with spirits can read the full history of a wall. They say the city’s true archive is not in libraries but on the sides of buildings, waiting for the right reader."
            ),
            ShadowsChaseLightFactEntry(
                id: "fact_midnight",
                shadowsChaseLightFactTitle: "The Midnight Hour",
                shadowsChaseLightFactPreview: "Between the last train and the first morning.",
                shadowsChaseLightFactFullDetail: "Between the last train and the first delivery truck, the city belongs to the spirits. This is the midnight hour—not a single moment but a stretch of time that lasts as long as the streets are empty. Traffic lights still change, but no one is there to obey them. The spirits use the interval to repair what the day has worn down: they smooth cracks in the pavement, restore faded signs, and return lost items to the places they remember. If you are out during the midnight hour, you may see them at work. They do not mind being watched, but they ask that you do not take photographs. The light of a flash, they say, steals a little of the city’s memory."
            ),
            ShadowsChaseLightFactEntry(
                id: "fact_puddles",
                shadowsChaseLightFactTitle: "Puddles and Reflections",
                shadowsChaseLightFactPreview: "Puddles are portals for spirits.",
                shadowsChaseLightFactFullDetail: "After rain, puddles become portals. Spirits use them to move between neighbourhoods without crossing the streets. What you see in a puddle is not always what is above it; the reflection may show another street, another time of day, or another city entirely. Children are better at seeing the difference; they often point at puddles and describe places they have never been. Adults learn to look away. The spirits do not mind. They step through the surface as if it were a door, and the puddle dries a little faster afterward. In districts where the spirits are respected, people leave small puddles undisturbed until the sun dries them naturally."
            ),
            ShadowsChaseLightFactEntry(
                id: "fact_neon",
                shadowsChaseLightFactTitle: "Neon and Longevity",
                shadowsChaseLightFactPreview: "Neon extends the life of spirits.",
                shadowsChaseLightFactFullDetail: "Spirits drawn to neon live longer. The light is constant, even in the small hours, and it holds a trace of the gas that once filled the tubes. Old signs—the ones that still flicker with the original script—are especially valued. Spirits gather around them like moths, but they do not burn; they drink the light and grow steadier. When a neon sign is taken down, the spirits that depended on it may fade within a year. Some cities have designated certain signs as protected, not for their design but for the spirits that feed there. The signs are repaired in secret, by workers who know how to solder glass without disturbing the inhabitants."
            ),
            ShadowsChaseLightFactEntry(
                id: "fact_caretakers",
                shadowsChaseLightFactTitle: "Caretakers of the Streets",
                shadowsChaseLightFactPreview: "Those who feed the spirits see the city differently.",
                shadowsChaseLightFactFullDetail: "Those who feed the spirits see the city differently. Lights stay on a little longer when they pass; shadows step aside. They rarely get lost, because the streets rearrange themselves for their benefit. In return, they leave offerings: a coin at a crossroads, a moment of silence under a particular lamp, a kind word to a reflection that has no body. There is no formal initiation. You become a caretaker by habit—by noticing the spirits, by not dismissing what you see, by giving the city your attention. The spirits do not speak in words, but they remember. They remember who stopped in the rain to look at a puddle, who turned off a harsh light that hurt their eyes, who walked the same route at the same time until it became a path. The city, through them, remembers you too."
            )
        ]
    }
}
