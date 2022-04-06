//
//  CarObject.swift
//  RaseApp
//
//  Created by Evgeny Trifonov on 25.03.2022.
//

import Foundation
import UIKit

class CarObject {
    
    var view: UIImageView?
    var displayView: UIView?
    var carImage: UIImageView?
    
    var rotate: Double = 0
    
    let rotateRad: Double = 30
    var yPosition: CGFloat = 650
  
    init(view: UIImageView?, displayView: UIView?) {
        self.view = view
        self.displayView = displayView
        self.setPosition()
    }
    
    func size() -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func startPosition() {
        guard let view = self.view,
              let displayView = self.displayView else { return }
        
        self.yPosition = (displayView.frame.size.height  -  CGFloat(self.size().height)) - 10
        
        UIView.animate(withDuration: 0) {
            self.setPosition()
            self.rotate = 0
            view.frame.size = self.size()
        }
    }
    
    private func carMove() {
        guard let view = self.view else { return }
        
        UIView.animate(withDuration: 0.2) {
            self.setPosition()
            
            let rotateBy = (self.rotate < 0) ? self.rotateRad: -self.rotateRad
            self.rotate = 0
            view.transform = view.transform.rotated(by: self.getRadius(rotateBy: rotateBy))
            view.frame.size = self.size()
            
        }
    }
    
    func moveLeft() {
        if rotate != 0 {return}
        Manager.shared.carPosition -= 1
        rotate -= rotateRad
        animate(rotateBy: rotate)
    }
    
    func moveRight() {
        if rotate != 0 {return}
        Manager.shared.carPosition += 1
        rotate += rotateRad
        animate(rotateBy: rotate)
    }
    
    private func animate(rotateBy: Double) {
        guard let view  = self.view else { return }
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveLinear], animations: {
            view.transform = view.transform.rotated(by: self.getRadius(rotateBy: rotateBy))
        }) { (_) in
            self.carMove()
        }
      
    }
    
    private func getRadius(rotateBy: Double) -> CGFloat {
        return CGFloat(Double.pi * 2 / Double(rotateBy))
    }
    

    
//    private func setPosition() {
//        guard let view = self.view else { return }
//
//        switch Manager.shared.carPosition {
//        case 0:
//            view.center.x = 60
//        case 1:
//            view.center.x = 200
//        case 2:
//            view.center.x = 350
//        default: Manager.shared.stopGame()
//        }
//        view.center.y = self.yPosition
//
//    }

    private func setPosition() {
        displayView.addSubviewsForAutoLayout([carImage])

        NSLayoutConstraint.activate([
            carImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, contains: -0),
            carImage.widthAnchor.constraint(equalTo: view.bounds.maxX / 3),
            carImage.heightAnchor.constraint(equalTo: 150)
            ])

    }
       
    
    
}
