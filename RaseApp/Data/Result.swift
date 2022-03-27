//
//  Result.swift
//  RaseApp
//
//  Created by Evgeny Trifonov on 25.03.2022.
//

import Foundation

class Result: Codable {
    
    var name: String?
    var exp: Int = 0
    var date = Date()
    
    private enum CodingKeys: String, CodingKey {
        case name
        case exp
        case date
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        exp = try container.decodeIfPresent(Int.self, forKey: .exp) ?? 0
        date = try container.decodeIfPresent(Date.self, forKey: .date) ?? Date()
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.name, forKey: .name)
        try container.encode(self.exp, forKey: .exp)
        try container.encode(self.date, forKey: .date)
    }

}
