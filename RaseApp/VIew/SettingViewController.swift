//
//  SettingViewController.swift
//  RaseApp
//
//  Created by Evgeny Trifonov on 15.03.2022.
//

import Foundation
import UIKit


class SettingViewController: UIViewController {
    
    var currentImageNumber = 0

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    let imagesArray = [
        CarColor.red.image,
        CarColor.yellow.image,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let setting = SettingManager.shared.data
        currentImageNumber = setting.carImageNum
        nameTextField?.text = setting.name
        image?.image = UIImage(named: imagesArray[currentImageNumber])
    }

    
    //MARK: - IBAction
    @IBAction func leftAction(_ sender: UIButton) {
        if currentImageNumber  == 0 {
            currentImageNumber = imagesArray.count
        }
        currentImageNumber -= 1
        
        showImage(shift: -view.frame.size.width)
    }
    
    @IBAction func rightAction(_ sender: UIButton) {
        currentImageNumber += 1
        if currentImageNumber == imagesArray.count {
            currentImageNumber = 0
        }
        showImage(shift: view.frame.size.width)
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        SettingManager.shared.data.carImageNum = currentImageNumber
        SettingManager.shared.data.name = nameTextField?.text
        SettingManager.shared.save()
        navigationController?.popToRootViewController(animated: true)
    }
    
    func showImage(shift: CGFloat){
        guard let image = self.image else { return }
        let newView = UIImageView()
        newView.image = UIImage(named: imagesArray[currentImageNumber])
        newView.frame = image.frame
        newView.frame.origin.x += shift
        newView.contentMode = image.contentMode
        view.addSubview(newView)
        
        UIView.animate(withDuration: 1, animations: {
            newView.frame = image.frame
        },completion: { (_) in
            image.image = newView.image
            newView.removeFromSuperview()
        })
    }
}




