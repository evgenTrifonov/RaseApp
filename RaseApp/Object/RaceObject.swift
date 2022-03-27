//
//  RaceObject.swift
//  RaseApp
//
//  Created by Evgeny Trifonov on 25.03.2022.
//

import UIKit

enum RaceObjectType {
    case barear
}


class RaceObject: UIImageView {
    
    var point = CGPoint(x: 0, y: 0)
    
    var view: UIImageView?
    let stepCount: Int = 10
    let objectSize: Int = 100
    
    var type: RaceObjectType = .barear
    
    func getImage(position: Int) -> UIImage {
        preconditionFailure("This method must be overridden")
    }
    
    var raceMap:[[CGPoint]] = [
        [ // 1 begin
            CGPoint(x: 60,  y: -11),
            CGPoint(x: 200, y: -11),
            CGPoint(x: 350, y: -11)
        ],
        [ // 6 out line
            CGPoint(x: 60,  y: 810),
            CGPoint(x: 200, y: 810),
            CGPoint(x: 350, y: 810)
        ],
    ]
    
    func size() -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func checkOut() -> Bool {
        if Int(self.point.y) == self.stepCount {
            view?.removeFromSuperview()
            view = nil
            return true
        }
        return false
    }
    
    func isCarContact() -> Bool {
        if Int(point.y) == 8 {
            if Int(point.x) == Manager.shared.carPosition {
                return true
            }
        }
        return false
    }
    
    func animate() {
        UIView.animate(withDuration: TimeInterval(Manager.shared.speed), delay: 0, options: .curveLinear,  animations: {
            let intY = Int(self.point.y)
            let intX = Int(self.point.x)
            let minFrame = self.raceMap[0][intX]
            let maxFrame = self.raceMap[1][intX]

            let x: Int = Int(minFrame.x)
            let y: Int = Int(minFrame.y) + Int(maxFrame.y - minFrame.y) / self.stepCount * intY

            self.view?.frame.size = self.size()
            self.view?.center = CGPoint(x: x, y: y)

        }) { (Bool) in
            self.move()
        }
    }
    
    func add() {
        let cell = Int.random(in: 0...2)
        self.add(to: cell)
    }
    
    func add(to: Int) {
        let cell = to
        
        let imageView = UIImageView()
        imageView.image =  getImage(position: cell)
        imageView.center = raceMap[0][cell]
        
        
        self.view = imageView
        self.point = CGPoint(x: cell, y: 0)
        
        Manager.shared.displayView?.addSubview(imageView)
        
        self.move()
    }
    
    func move() {
        self.point.y += 1
        
        if self.checkOut() == true {
            return
        }
        if self.isCarContact() == true {
            contactWithCar()
        }
        self.animate()
    }
    
    func contactWithCar(){
        Manager.shared.stopGame()
    }
    
    
    
}

