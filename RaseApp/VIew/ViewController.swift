//
//  ViewController.swift
//  RaseApp
//
//  Created by Evgeny Trifonov on 25.03.2022.
//

import UIKit

class ViewController: UIViewController {
   
    
    @IBAction func playButtonAction(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: RaceViewController.className) as? RaceViewController else {return}
        navigationController?.pushViewController(vc, animated: true)    }
    
    
    @IBAction func settingButtonAction(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: SettingViewController.className) as? SettingViewController else {return}
        navigationController?.pushViewController(vc, animated: true)
    }
    
    let imagesFonView = UIImageView(image: UIImage(named: "oboi"))

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //create Fon
        imagesFonView.contentMode = .scaleAspectFill
        view.addSubview(imagesFonView)
        imagesFonView.frame = CGRect(x: CGFloat.zero, y: CGFloat.zero, width: view.frame.width, height: view.frame.height)
        view.sendSubviewToBack(imagesFonView)

    }
    
}
