//
//  Settings.swift
//  RaseApp
//
//  Created by Evgeny Trifonov on 25.03.2022.
//

import Foundation

class Settings: Codable {
    
    var name: String?
    var carImageNum: Int = CarColor.red.rawValue
    var spartSpeed: Int = 1

    
    private enum CodingKeys: String, CodingKey {
        case name
        case carImageNum
        case spartSpeed
        case volume
    }
    
    init(){}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        carImageNum = try container.decodeIfPresent(Int.self, forKey: .carImageNum) ?? CarColor.red.rawValue
        spartSpeed = try container.decodeIfPresent(Int.self, forKey: .spartSpeed) ?? 1

    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.name, forKey: .name)
        try container.encode(self.carImageNum, forKey: .carImageNum)
        try container.encode(self.spartSpeed, forKey: .spartSpeed)
    }

}
