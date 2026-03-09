//
//  ShadowsChaseLightNotificationView.swift
//  SunlitRiverPath
//

import SwiftUI

struct ShadowsChaseLightNotificationView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ShadowsChaseLightNotificationController {
        let controller = ShadowsChaseLightNotificationController()
        return controller
    }

    func updateUIViewController(_ uiViewController: ShadowsChaseLightNotificationController, context: Context) {}

    typealias UIViewControllerType = ShadowsChaseLightNotificationController
}
