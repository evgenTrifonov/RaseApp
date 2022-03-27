//
//  BarrierObject.swift
//  RaseApp
//
//  Created by Evgeny Trifonov on 25.03.2022.
//

import Foundation
import UIKit

let elements = ["wheel", "kirp", "stone"]

class BarrierObject: RaceObject {
    
    override func size() -> CGSize {
        return CGSize(width: 75, height: 75)
    }
    
    override func contactWithCar(){
        Manager.shared.stopGame()
        view!.isHidden = true
    }

    override func getImage(position: Int) -> UIImage {
        return UIImage(named: elements.randomElement() ??   "") ?? UIImage()
    }
}
