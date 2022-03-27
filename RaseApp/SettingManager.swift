//
//  SettingManager.swift
//  RaseApp
//
//  Created by Evgeny Trifonov on 26.03.2022.
//

import Foundation

class SettingManager {
    static let shared  = SettingManager()
    
    private init() {
        guard let setting = UserDefaults.standard.value(Settings.self, forKey: "Settings") else {
            data = Settings()
            return
        }
        self.data = setting
    }
   
    var data: Settings
    
    func save() {
        UserDefaults.standard.set(encodable: data, forKey: "Settings")
    }
    
}
