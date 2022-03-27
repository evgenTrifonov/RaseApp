//
//  CarColor.swift
//  RaseApp
//
//  Created by Evgeny Trifonov on 25.03.2022.
//

import Foundation

enum CarColor: Int, CaseIterable {
    case red = 0, yellow
    
    
    var image: String {
        get {
            switch self {
            case .red: return "carRed"
            case .yellow: return "carYellow"

            }
        }
    }
}
