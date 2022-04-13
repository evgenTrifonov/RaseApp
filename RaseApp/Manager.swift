//
//  Manager.swift
//  RaseApp
//
//  Created by Evgeny Trifonov on 26.03.2022.
//

import Foundation
import UIKit
import AVFoundation

class Manager {
    static let shared  = Manager()
    
    private init() {}
    
    var speed = 0.7
    var carPosition = 1
    var result = 0
    var isStop = false
    
    var timer: Timer?

    var displayView: UIView?
    
    let speedStep = 0.1
    let speedStart = 0.5
    
    func stopGame() {
        timer?.invalidate()
        timer = nil
        print("stop")
        isStop = true
        
        var dataResults: [Result] = UserDefaults.standard.value([Result].self, forKey: "results") ?? []
        let result = Result()
        result.date = Date()
        result.exp = self.result
        result.name = "name"
        dataResults.append(result)
        UserDefaults.standard.set(encodable: dataResults, forKey: "results")
        
    }
    
    func gameStart(){
        isStop = false
        result = 0
        carPosition = 1
        speed = speedStart - Double(SettingManager.shared.data.spartSpeed - 1) * speedStep
        
    }
}
