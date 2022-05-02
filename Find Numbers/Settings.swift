//
//  Settings.swift
//  Find Numbers
//
//  Created by Андрей Русин on 02.05.2022.
//

import Foundation
enum keysUserDefaults {
    static let settingsGame = "settingsGame"
}
struct SettingsGame: Codable{
    var timerState: Bool
    var timeForGame: Int
}

class Settings {
    static var shared = Settings()
    private let defaultSettings = SettingsGame(timerState: true, timeForGame: 30)
    
    var currentSettings: SettingsGame {
        get {
            if let data = UserDefaults.standard.object(forKey: keysUserDefaults.settingsGame) as? Data {
                return try! PropertyListDecoder().decode(SettingsGame.self, from: data)
            } else {
                if let data = try? PropertyListEncoder().encode(defaultSettings) {
                    UserDefaults.standard.set(data, forKey: keysUserDefaults.settingsGame)
                }
            }
            return defaultSettings
        }
        set{
            if let data = try? PropertyListEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: keysUserDefaults.settingsGame)
            }
            
        }
    }
    func resetSettings() {
        currentSettings = defaultSettings
    }
}


