//
//  RaceViewController.swift
//  RaseApp
//
//  Created by Evgeny Trifonov on 12.01.2022.
//

import UIKit

class RaceViewController: UIViewController {
    
    
    
    enum Constants {
            static let step: CGFloat = 120
        }
    
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

    let imagesRoadView = UIImageView(image: UIImage(named: "street"))
    let imagesRoad2View = UIImageView(image: UIImage(named: "street2"))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagesRoadView.contentMode = .scaleAspectFill
        imagesRoadView.frame = CGRect(x: CGFloat.zero, y: CGFloat.zero, width: view.frame.width, height: view.frame.height)
        view.addSubview(imagesRoadView)
        view.sendSubviewToBack(imagesRoadView)

        imagesRoad2View.contentMode = .scaleAspectFill
        imagesRoad2View.frame = CGRect(x: CGFloat.zero, y: CGFloat.zero - view.frame.height, width: view.frame.width, height: view.frame.height)
        view.addSubview(imagesRoad2View)
        view.sendSubviewToBack(imagesRoad2View)

        DispatchQueue.main.async {
                self.moveRoad()
        }

        startGame()
        setPosition()

    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }

    func viewWillApper () {
            moveRoad()
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        setCarImage(num: 1)
//        setPosition()

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
        carImage?.image = UIImage(named: CarColor(rawValue: num)?.image ?? CarColor.red.image)
        //SettingManager.shared.carImage
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


extension RaceViewController {
func moveRoad() {
    UIView.animate(withDuration: 6,
                   delay: 0.0,
                   options: [.repeat, .curveLinear], animations: {
        self.imagesRoadView.frame = self.imagesRoadView.frame.offsetBy(dx: 0.0, dy: +1 * self.imagesRoadView.frame.size.height)
        self.imagesRoad2View.frame = self.imagesRoad2View.frame.offsetBy(dx: 0.0, dy: +1 * self.imagesRoad2View.frame.size.height)
    }, completion: nil)
  }
    
     func setPosition() {
         self.displayView!.addSubview(carImage!)

        NSLayoutConstraint.activate([
            carImage!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carImage!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            carImage!.widthAnchor.constraint(equalToConstant: view.bounds.maxX / 3),
            carImage!.heightAnchor.constraint(equalToConstant: 150)
            ])

    }
}
