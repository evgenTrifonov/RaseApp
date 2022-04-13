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

let imagesRoadView = UIImageView(image: UIImage(named: "street"))

class RaceObject: UIImageView {
    
    var point = CGPoint(x: 0, y: 0)
    
    var view: UIImageView?
    let stepCount: Int = 10
    let objectSize: Int = 80
    
    var type: RaceObjectType = .barear
    
    func getImage(position: Int) -> UIImage {
        preconditionFailure("This method must be overridden")
    }
    
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
            let minFrame = self.calculatePosition(for: intX, isStart: true)
            let maxFrame = self.calculatePosition(for: intX, isStart: false)

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
        imageView.center = calculatePosition(for: cell, isStart: true)
        
        
        self.view = imageView
        self.point = CGPoint(x: cell, y: 0)
        
        Manager.shared.displayView?.addSubview(imageView)
        
        self.move()
    }
    
    
    func calculatePosition(for side: Int, isStart: Bool) -> CGPoint {
        guard let view = Manager.shared.displayView else { return CGPoint(x: 60, y: -11) }
        let yPosition = isStart ? -20 : view.frame.height + 20
        switch side {
        case 0:
            return CGPoint(x: 60, y: yPosition)
        case 1:
            return CGPoint(x: view.center.x, y: yPosition)
        default:
            return CGPoint(x: view.frame.width - 60, y: yPosition)
        }
    }
    
    func move() {
        self.point.y += 1
        
        if self.checkOut() == true {
            return
        }
        if self.isCarContact() == true {
            contactWithCar()
        }
        animate()
        
    }
    
    func contactWithCar(){
        Manager.shared.stopGame()
    }
    
    
    
}

