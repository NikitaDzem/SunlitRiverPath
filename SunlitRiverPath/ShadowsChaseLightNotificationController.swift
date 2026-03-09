//
//  ShadowsChaseLightNotificationController.swift
//  SunlitRiverPath
//

import Foundation
import SwiftUI
import UIKit
import UserNotifications

final class ShadowsChaseLightNotificationController: UIViewController {
    private let additionalLabelShadowsChaseLight = UILabel()
    private let backgroundShadowsChaseLight = UIImageView(image: UIImage(named: "bgForNotificationsShadowsChaseLightPortrait"))
    private let mainLabelShadowsChaseLight = UILabel()

    private let skipShadowsChaseLight = UIButton(type: .system)
    private let acceptShadowsChaseLight = UIButton(type: .system)

    private var portraitConstraintsShadowsChaseLight: [NSLayoutConstraint] = []
    private var widthSkipConstraintsShadowsChaseLight: NSLayoutConstraint!
    private var landscapeConstraintsShadowsChaseLight: [NSLayoutConstraint] = []
    private var widthAcceptConstraintsShadowsChaseLight: NSLayoutConstraint!

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        applyCorrectLayoutShadowsChaseLight()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsShadowsChaseLight()
        acceptShadowsChaseLight.translatesAutoresizingMaskIntoConstraints = false
        skipShadowsChaseLight.translatesAutoresizingMaskIntoConstraints = false
    }

    private func applyCorrectLayoutShadowsChaseLight() {
        let isLandscape = view.bounds.width > view.bounds.height

        if isLandscape {
            backgroundShadowsChaseLight.image = UIImage(named: "bgForNotificationsShadowsChaseLightLandscape")
            mainLabelShadowsChaseLight.font = UIFont(name: "Inter-Bold", size: 22)

            NSLayoutConstraint.deactivate(portraitConstraintsShadowsChaseLight)

            if landscapeConstraintsShadowsChaseLight.isEmpty {
                setLandscapeShadowsChaseLight()
            }

            mainLabelShadowsChaseLight.textAlignment = .left
            NSLayoutConstraint.activate(landscapeConstraintsShadowsChaseLight)
            getDeviceShadowsChaseLight()
        } else {
            backgroundShadowsChaseLight.image = UIImage(named: "bgForNotificationsShadowsChaseLightPortrait")
            mainLabelShadowsChaseLight.font = UIFont(name: "Inter-Bold", size: 21)
            additionalLabelShadowsChaseLight.font = UIFont(name: "Inter-Italic", size: 15)

            NSLayoutConstraint.deactivate(landscapeConstraintsShadowsChaseLight)
            mainLabelShadowsChaseLight.textAlignment = .center
            NSLayoutConstraint.activate(portraitConstraintsShadowsChaseLight)
        }
    }

    private func addSubviewsShadowsChaseLight() {
        view.addSubview(backgroundShadowsChaseLight)
        view.addSubview(mainLabelShadowsChaseLight)
        view.addSubview(additionalLabelShadowsChaseLight)
        view.addSubview(acceptShadowsChaseLight)
        view.addSubview(skipShadowsChaseLight)

        backgroundShadowsChaseLight.translatesAutoresizingMaskIntoConstraints = false
        mainLabelShadowsChaseLight.translatesAutoresizingMaskIntoConstraints = false
        additionalLabelShadowsChaseLight.translatesAutoresizingMaskIntoConstraints = false

        additionalLabelShadowsChaseLight.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        additionalLabelShadowsChaseLight.numberOfLines = 0
        additionalLabelShadowsChaseLight.adjustsFontSizeToFitWidth = true
        additionalLabelShadowsChaseLight.minimumScaleFactor = 0.5
        additionalLabelShadowsChaseLight.textAlignment = .center
        additionalLabelShadowsChaseLight.font = UIFont(name: "Inter-Italic", size: 15)

        skipShadowsChaseLight.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.5)
        skipShadowsChaseLight.setTitle("SKIP", for: .normal)
        skipShadowsChaseLight.layer.cornerRadius = 20
        skipShadowsChaseLight.titleLabel?.font = UIFont(name: "Inter-Bold", size: 19)
        skipShadowsChaseLight.backgroundColor = .white.withAlphaComponent(0.3)

        mainLabelShadowsChaseLight.textAlignment = .center
        mainLabelShadowsChaseLight.textColor = .white
        mainLabelShadowsChaseLight.adjustsFontSizeToFitWidth = true
        mainLabelShadowsChaseLight.font = UIFont(name: "Inter-Bold", size: 21)
        mainLabelShadowsChaseLight.numberOfLines = 2

        acceptShadowsChaseLight.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        acceptShadowsChaseLight.layer.cornerRadius = 9
        if let acceptImage = UIImage(named: "acceptShadowsChaseLight") {
            acceptShadowsChaseLight.setBackgroundImage(acceptImage, for: .normal)
        }

        mainLabelShadowsChaseLight.text = "ALLOW NOTIFICATIONS ABOUT BONUSES AND PROMOS".uppercased()
        additionalLabelShadowsChaseLight.text = "Stay tuned with best offers from our casino".uppercased()

        backgroundShadowsChaseLight.contentMode = .scaleAspectFill
    }

    private func settingsShadowsChaseLight() {
        ShadowsChaseLightAppDelegate.orientationShadowsChaseLight = .all
        addSubviewsShadowsChaseLight()
        setConstraintsShadowsChaseLight()
        setTargetsShadowsChaseLight()
    }

    private func setConstraintsShadowsChaseLight() {
        backgroundShadowsChaseLight.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundShadowsChaseLight.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundShadowsChaseLight.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundShadowsChaseLight.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        setPortraitShadowsChaseLight()
    }

    private func setLandscapeShadowsChaseLight() {
        widthAcceptConstraintsShadowsChaseLight = acceptShadowsChaseLight.widthAnchor.constraint(equalToConstant: 350)
        widthSkipConstraintsShadowsChaseLight = skipShadowsChaseLight.widthAnchor.constraint(equalToConstant: 340)
        mainLabelShadowsChaseLight.textAlignment = .left
        landscapeConstraintsShadowsChaseLight = [
            additionalLabelShadowsChaseLight.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            additionalLabelShadowsChaseLight.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -55),

            mainLabelShadowsChaseLight.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainLabelShadowsChaseLight.widthAnchor.constraint(equalToConstant: 300),
            mainLabelShadowsChaseLight.bottomAnchor.constraint(equalTo: additionalLabelShadowsChaseLight.topAnchor, constant: -15),

            acceptShadowsChaseLight.heightAnchor.constraint(equalToConstant: 53),
            acceptShadowsChaseLight.bottomAnchor.constraint(equalTo: skipShadowsChaseLight.topAnchor, constant: -15),
            acceptShadowsChaseLight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            widthAcceptConstraintsShadowsChaseLight,

            skipShadowsChaseLight.centerXAnchor.constraint(equalTo: acceptShadowsChaseLight.centerXAnchor),
            skipShadowsChaseLight.heightAnchor.constraint(equalToConstant: 40),
            widthSkipConstraintsShadowsChaseLight,
            skipShadowsChaseLight.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35)
        ]
        NSLayoutConstraint.activate(landscapeConstraintsShadowsChaseLight)
    }

    private func setPortraitShadowsChaseLight() {
        portraitConstraintsShadowsChaseLight = [
            mainLabelShadowsChaseLight.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabelShadowsChaseLight.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            mainLabelShadowsChaseLight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),

            additionalLabelShadowsChaseLight.topAnchor.constraint(equalTo: mainLabelShadowsChaseLight.bottomAnchor, constant: 10),
            additionalLabelShadowsChaseLight.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            additionalLabelShadowsChaseLight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            additionalLabelShadowsChaseLight.bottomAnchor.constraint(equalTo: acceptShadowsChaseLight.topAnchor, constant: -25),

            acceptShadowsChaseLight.heightAnchor.constraint(equalToConstant: 53),
            acceptShadowsChaseLight.bottomAnchor.constraint(equalTo: skipShadowsChaseLight.topAnchor, constant: -15),
            acceptShadowsChaseLight.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            acceptShadowsChaseLight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            skipShadowsChaseLight.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            skipShadowsChaseLight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            skipShadowsChaseLight.heightAnchor.constraint(equalToConstant: 45),
            skipShadowsChaseLight.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45)
        ]

        NSLayoutConstraint.activate(portraitConstraintsShadowsChaseLight)
    }

    private func setTargetsShadowsChaseLight() {
        acceptShadowsChaseLight.addTarget(self, action: #selector(acceptActionShadowsChaseLight), for: .touchUpInside)
        skipShadowsChaseLight.addTarget(self, action: #selector(skipActionShadowsChaseLight), for: .touchUpInside)
    }

    @objc
    private func skipActionShadowsChaseLight() {
        // Замените на ваш следующий экран
        dismiss(animated: true)
    }

    @objc
    private func acceptActionShadowsChaseLight() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, _ in
            UserDefaults.standard.set(granted, forKey: "ShadowsChaseLightNotificationsEnabled")
            if !granted {
                UserDefaults.standard.set(1000, forKey: "ShadowsChaseLightNotificationsDeclined")
            }
            DispatchQueue.main.async {
                self?.dismiss(animated: true)
            }
        }
    }

    private func getDeviceShadowsChaseLight() {
        let screenWidth = UIScreen.main.bounds.width

        if screenWidth == 667.0 {
            widthAcceptConstraintsShadowsChaseLight.constant = 280
            widthSkipConstraintsShadowsChaseLight.constant = 260
            additionalLabelShadowsChaseLight.font = UIFont(name: "Inter-Italic", size: 12)
        } else if screenWidth == 896.0 {
            additionalLabelShadowsChaseLight.font = UIFont(name: "Inter-Italic", size: 15)
        }
    }
}

#Preview {
    ShadowsChaseLightNotificationView()
        .ignoresSafeArea()
}
