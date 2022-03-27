//
//  RaceViewController.swift
//  RaseApp
//
//  Created by Evgeny Trifonov on 12.01.2022.
//

import UIKit

class RaceViewController: UIViewController {
    
    @IBOutlet weak var carImage: UIImageView?
    @IBOutlet weak var resultLabel: UILabel?
    @IBOutlet weak var displayView: UIView?
  //  @IBOutlet weak var speedLabel: UILabel?
    
    var timer: Timer?
    var isSetBarer = false
    var car: CarObject?

    
    @IBAction func leftAction(_ sender: Any) {
        car?.moveLeft()
    }
    @IBAction func rightAction(_ sender: Any) {
        car?.moveRight()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        startGame()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationController?.setNavigationBarHidden(true, animated: true)   
    }
    
    
    @objc func gameStep() {
        Manager.shared.result += 1
        resultLabel?.text = String(Manager.shared.result)
        if Manager.shared.result % 10 == 0 {
        }
        addObjects()
        
    }

    
    private func timerStop(){
        self.timer?.invalidate()
        self.timer = nil
    }
    
    private func addObject(object: RaceObject?) {
        guard let object = object else { return }
        
        if let addView = object.view {
             displayView?.addSubview(addView)
        }
        object.move()
    }
    
    func startGame() {
        Manager.shared.displayView = displayView

        setCarImage(num: SettingManager.shared.data.carImageNum)
        car = CarObject(view: self.carImage, displayView: self.displayView)
        car?.startPosition()
        
        Manager.shared.gameStart()
        
        Manager.shared.timer = Timer.scheduledTimer(timeInterval: Manager.shared.speed, target: self, selector: #selector(gameStep), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.showResultPage()
        }
    }
    
    private func setCarImage(num: Int) {
        carImage?.image = UIImage(named: CarColor(rawValue: num)?.image ?? CarColor.red.image) //SettingManager.shared.carImageName
    }
    
    //MARK: - private func
    private func showResultPage() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController else { return }
        if Manager.shared.isStop == true {
            vc.result = String(Manager.shared.result)
            timerStop()
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    private func addObjects() {
        isSetBarer = !isSetBarer
        if isSetBarer {
            return
        }
   
        switch Int.random(in: 0...20) {
        case 0...10:
            BarrierObject().add()
        default:
            print("empty")
        }
    }
    

}


